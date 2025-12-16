WIFI_SSID=""
WIFI_PWD=""
FORMAT_PART="/dev/nvme0n1"
SWAP_END="16GB"
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


git clone https://github.com/boralg/nixconf.git


sudo parted $FORMAT_PART -- mklabel gpt
sudo parted $FORMAT_PART -- mkpart ESP fat32 1MB 512MB
sudo parted $FORMAT_PART -- set 1 esp on
sudo parted $FORMAT_PART -- mkpart primary linux-swap 512MB $SWAP_END
sudo parted $FORMAT_PART -- mkpart primary $SWAP_END 100%

sudo mkfs.fat -F 32 -n boot ${FORMAT_PART}p1
sudo mkswap -L swap ${FORMAT_PART}p2
sudo mkfs.btrfs -L nixos ${FORMAT_PART}p3

sudo mount ${FORMAT_PART}p3 /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo umount /mnt

sudo mount -o subvol=root,compress=zstd,noatime ${FORMAT_PART}p3 /mnt
sudo mkdir -p /mnt/{home,nix,boot}
sudo mount -o subvol=home,compress=zstd,noatime ${FORMAT_PART}p3 /mnt/home
sudo mount -o subvol=nix,compress=zstd,noatime ${FORMAT_PART}p3 /mnt/nix
sudo mount ${FORMAT_PART}p1 /mnt/boot
sudo swapon ${FORMAT_PART}p2


sudo mkdir -p /mnt/home/bora
sudo cp -r nixconf /mnt/home/bora/
sudo chown -R 1000:100 /mnt/home/bora/nixconf


sudo nixos-generate-config --root /mnt --dir /tmp/nixos-config
sudo cp /tmp/nixos-config/hardware-configuration.nix /mnt/home/bora/nixconf/hosts/$HOSTNAME/


mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf


echo "sudo nixos-install --flake .#$HOSTNAME"
