import os
import argparse
import subprocess
import shutil
from pathlib import Path
import sys
import uuid

NIXCONF_HOME = os.environ.get("NIXCONF_HOME", "/home/yallo/nixconf")


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
    parser = argparse.ArgumentParser(prog='shovel', 
        description='Shovel, a script to manage a NixOS configuration structured in Shovel-style')

    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        '-s', '--sync',
        action='store_true',
        help='Sync the NIXCONF_HOME directory with /etc/nixos and rebuild the system configuration'
    )
    group.add_argument(
        '-r', '--rollback',
        metavar='BACKUP',
        help='Rollback the system configuration to a specified backup and rebuild the system configuration'
    )

    args = parser.parse_args()

    if args.sync:
        sync_nix_conf()
    elif args.rollback:
        rollback_nix_conf(args.rollback)
    else:
        parser.print_help()
