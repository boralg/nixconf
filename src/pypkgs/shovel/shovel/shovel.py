import os
import argparse
import subprocess
import shutil
from pathlib import Path
import sys
import uuid

NIXCONF_HOME = os.environ.get("NIXCONF_HOME", "/home/yallo/nixconf")

def get_pkgs():
    with open(NIXCONF_HOME + "/src/pkgs.nix", 'r') as file:
        lines = file.readlines()

    return lines[0], lines[2:-1]

def set_pkgs(header, packages):
    content = [header, '['] + packages + [']']

    with open(f"{NIXCONF_HOME}/src/pkgs.nix", 'w') as file:
        file.write('\n'.join(content))

def add_packages_to_nix(packages):
    header, existing_packages = get_pkgs()

    # Add the new packages, skipping the ones that are already there
    for package in packages:
        if f'  {package}' not in existing_packages:
            existing_packages.append(f'  {package}')

    set_pkgs(header, existing_packages)

def remove_packages_from_nix(packages):
    header, existing_packages = get_pkgs()

    # Remove the specified packages
    existing_packages = [package for package in existing_packages if f'  {package}' not in packages]

    set_pkgs(header, existing_packages)

def sync_nix_conf():
    backup_uuid = str(uuid.uuid4())
    backup_dir = f"/etc/nixos/.backup/{backup_uuid}"
    
    subprocess.run(['sudo', 'mkdir', '-p', backup_dir], check=True)
    subprocess.run(['sudo', 'rsync', '-a', '--exclude=.backup', 
                    '/etc/nixos/', backup_dir], check=True)
    subprocess.run(['sudo', 'rsync', '-a', '--exclude=.backup', '--exclude=.*', 
                    f"{NIXCONF_HOME}/", '/etc/nixos/'], check=True)
    subprocess.run(['sudo', 'nixos-rebuild', 'switch'], check=True)
    shutil.copy('/etc/nixos/flake.lock', f"{NIXCONF_HOME}/flake.lock")


def rollback_nix_conf(backup_uuid):
    backup_dir = f"/etc/nixos/.backup/{backup_uuid}/"
    if Path(backup_dir).exists():
        shutil.copytree(backup_dir, "/etc/nixos/")
        subprocess.run(['sudo', 'nixos-rebuild', 'switch'], check=True)
    else:
        raise ValueError(f"No backup found for the given UUID: {backup_uuid}")

def preprocess_args(args):
    """Preprocess arguments to handle -s combined with other options"""
    new_args = []
    sync = False
    for arg in args:
        if arg.startswith('-') and 's' in arg and len(arg) > 2:  # If -s is combined with other option(s)
            new_args.append(arg.replace('s', ''))  # Remove s from the combined option(s)
            sync = True  # Mark that we have a sync option
        else:
            new_args.append(arg)
    if sync:
        new_args.append('-s')  # Append -s as a separate option at the end
    return new_args

def main():
    args = preprocess_args(sys.argv[1:])
    parser = argparse.ArgumentParser(prog='shovel', 
        description='Shovel, a script to manage a NixOS configuration structured in Shovel-style')
    parser.add_argument('-i', '--install', nargs='+', help='Add the specified packages to pkgs.nix')
    parser.add_argument('-u', '--uninstall', nargs='+', help='Remove the specified packages from pkgs.nix')
    parser.add_argument('-s', '--sync', action='store_true', 
                        help='Sync the NIXCONF_HOME directory with /etc/nixos and rebuild the system configuration')
    parser.add_argument('-r', '--rollback', help='Rollback the system configuration to a specified backup')
    args = parser.parse_args(args)

    if args.install:
        add_packages_to_nix(args.install)
    if args.uninstall:
        remove_packages_from_nix(args.uninstall)
    if args.sync:
        sync_nix_conf()
    if args.rollback:
        rollback_nix_conf(args.rollback)
