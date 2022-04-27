#!/bin/bash
LOCALUSER=norman
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
LOCALPATH=/home/norman/GitHub/archlinux-iso/

echo "############################################"
echo "######## N0Raitor ARCH ISO SCRIPT ##########"
echo "############################################"

echo ""

echo -n "REInstalling ArchISO... "
pacman -R --noconfirm archiso  &> /dev/null # Clean Up ArchIsoFiles for a clean build
pacman -S --noconfirm --needed archiso  &> /dev/null # Sync Iso
echo "Done"

# If archlive folder exists, delete this folder
DIR="./archlive"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -n "Removing archlive folder... "
  sudo rm -rf ./archlive
  echo "Done"
fi

DIR="local/repo"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -n "Removing local/repo folder... "
  sudo rm -rf local/repo
  echo "Done"
fi

DIR="aur_tmp_build_dir"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -n "Removing aur_tmp_build_dir folder... "
  sudo rm -rf aur_tmp_build_dir
  echo "Done"
fi

# Copy Current Iso Content to local folder
echo -n "cp archiso files... "
mkdir -p archlive
cp -r /usr/share/archiso/configs/releng/* ./archlive/
cd archlive
echo "Done"

#####################
# Included Packages #
#####################
# Add Additional Packages to Iso Build
cat ../additional_packages_big >> packages.x86_64

# Set Autologin enabled
sed -i 's/--autologin/--autologin root/g' ./airootfs/etc/systemd/system/getty@tty1.service.d/autologin.conf

# Set Enabled: GDM
ln -s /usr/lib/systemd/system/gdm.service airootfs/etc/systemd/system/display-manager.service

# Set Enabled: NetworkManager
ln -s /usr/lib/systemd/system/NetworkManager.service airootfs/etc/systemd/system/NetworkManager.service

# Set Enabled: Bluetooth
ln -s /usr/lib/systemd/system/bluetooth.service airootfs/etc/systemd/system/bluetooth.service

# Set Enabled: Cups / Printing
ln -s /usr/lib/systemd/system/cups.service airootfs/etc/systemd/system/cups.service

# Set Enabled: SSH
#ln -s /usr/lib/systemd/system/cups.service airootfs/etc/systemd/system/sshd.service

# Create ISO
echo "############"
echo "CREATING ISO"
echo "############"

mkarchiso -v -w . -o ../ ./
