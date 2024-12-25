import argparse
import getpass
import os
import time
import yaml
import subprocess
from cryptography.fernet import Fernet, InvalidToken
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend
from base64 import urlsafe_b64encode

PASS_STORE = os.environ.get("PASS_STORE", "/home/yallo/.creds")

def put_to_clipboard(data: str) -> None:
    """
    Place the given data into the clipboard using wl-copy for Wayland,
    then clear it, along with the entirety of klipper.
    """
    # Copy the data to the clipboard
    cmd = ['wl-copy', '--trim-newline']
    with subprocess.Popen(cmd, stdin=subprocess.PIPE) as proc:
        proc.communicate(input=data.encode())

    # Wait a moment
    time.sleep(5)

    subprocess.run(['qdbus', 'org.kde.klipper', '/klipper', 'org.kde.klipper.klipper.clearClipboardHistory'])

def main():
    parser = argparse.ArgumentParser(description='Encrypt/decrypt passwords in YAML file.')
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('-e', '--encrypt', action='store_true', help='Encrypt new passwords')
    group.add_argument('-d', '--decrypt', metavar='SITE', help='Decrypt password for a site')

    args = parser.parse_args()

    password = getpass.getpass("Enter your password: ")
    password = password.encode()  # Convert to bytes

    salt = b'\x00'*16  # SHOULD BE STORED SECURELY, THIS IS JUST AN EXAMPLE
    kdf = PBKDF2HMAC(algorithm=hashes.SHA256(), length=32, salt=salt, iterations=100000, backend=default_backend())
    key = urlsafe_b64encode(kdf.derive(password))  # Can only use kdf once

    cipher_suite = Fernet(key)

    with open(PASS_STORE + '/.creds.yaml', 'r+') as file:
        data = yaml.safe_load(file)

        if args.encrypt:
            for site, creds in data['new'].items():
                for field, value in creds.items():
                    if field == 'password':
                        creds[field] = cipher_suite.encrypt(value.encode()).decode()  # Encrypt field

                if site in data:
                    data[site].update(creds)  # Update existing site
                else:
                    data[site] = creds  # Add new site

            del data['new']  # Remove 'new' field

            file.seek(0)  # Go back to the start of the file
            yaml.dump(data, file, default_flow_style=False)
            file.truncate()  # Remove remaining contents

        elif args.decrypt:
            site = args.decrypt

            if site in data:
                encrypted_password = data[site].get('password')
                if encrypted_password:
                    try:
                        decrypted_password = cipher_suite.decrypt(encrypted_password.encode()).decode()
                        
                        print("Password for site '{}' has been placed into clipboard.".format(site))
                        put_to_clipboard(decrypted_password)
                        print("Clipboard has been cleared.")
                    except InvalidToken:
                        print("Incorrect password.")
                        return
                else:
                    print("No password found for site '{}'.".format(site))
            else:
                print("Site not found.")

if __name__ == "__main__":
    main()
