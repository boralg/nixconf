WIFI_SSID=""
WIFI_PWD=""
DO_CLONE=1
DO_ENCRYPT=0
FORMAT_PART="/dev/nvme0n1"
HOSTNAME="dark"

set -e


if [ -n "$WIFI_SSID" ]; then
    echo "network={
    ssid=\"$WIFI_SSID\"
    psk=\"$WIFI_PWD\"
}" | sudo tee /etc/wpa_supplicant.conf
    sudo ip link set wlp0s20f3 up
    sudo wpa_supplicant -B -i wlp0s20f3 -c /etc/wpa_supplicant.conf
    sudo dhcpcd wlp0s20f3
fi


if [ "$DO_CLONE" = "1" ]; then
    git clone https://github.com/boralg/nixconf.git
fi


sudo parted $FORMAT_PART -- mklabel gpt
sudo parted $FORMAT_PART -- mkpart ESP fat32 1MB 512MB
sudo parted $FORMAT_PART -- set 1 esp on
sudo parted $FORMAT_PART -- mkpart primary 512MB 100%

sudo mkfs.fat -F 32 -n boot ${FORMAT_PART}p1

if [ "$DO_ENCRYPT" = "1" ]; then
    sudo cryptsetup --verify-passphrase -v luksFormat ${FORMAT_PART}p2
    sudo cryptsetup open ${FORMAT_PART}p2 cryptroot
    ROOT_DEV="/dev/mapper/cryptroot"
else
    ROOT_DEV="${FORMAT_PART}p2"
fi

sudo mkfs.btrfs -L nixos $ROOT_DEV

sudo mount $ROOT_DEV /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo umount /mnt

sudo mount -o subvol=root,compress=zstd,noatime $ROOT_DEV /mnt
sudo mkdir -p /mnt/{home,nix,boot}
sudo mount -o subvol=home,compress=zstd,noatime $ROOT_DEV /mnt/home
sudo mount -o subvol=nix,compress=zstd,noatime $ROOT_DEV /mnt/nix
sudo mount ${FORMAT_PART}p1 /mnt/boot

sudo mkdir -p /mnt/home/bora
sudo cp -r nixconf /mnt/home/bora/
sudo chown -R 1000:100 /mnt/home/bora/nixconf


sudo nixos-generate-config --root /mnt --dir /tmp/nixos-config
sudo cp /tmp/nixos-config/hardware-configuration.nix /mnt/home/bora/nixconf/hosts/$HOSTNAME/


mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf


if [ "$DO_ENCRYPT" = "1" ]; then
    echo ""
    echo "IMPORTANT: Add this to hardware-configuration.nix:"
    echo 'boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/'$(sudo blkid -s UUID -o value ${FORMAT_PART}p2)'";'
    echo ""
fi


cd /mnt/home/bora/nixconf
echo "Run: sudo nixos-install --flake .#$HOSTNAME"
