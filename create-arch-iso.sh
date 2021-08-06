#!/bin/bash
pacman -R --noconfirm archiso  # Clean Up ArchIsoFiles for a clean build
pacman -S --noconfirm --needed archiso  # Sync Iso

# If archlive folder exists, delete this folder
DIR="./archlive"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Remove archlive folder"
  rm -rf ./archlive
fi

# Copy Current Iso Content to local folder
mkdir -p archlive
cp -r /usr/share/archiso/configs/releng/* ./archlive/
cd archlive



cat ../additional_packages >> packages.x86_64  # Add Additional Packages to Iso Build

# Set Enabled: GDM
ln -s /usr/lib/systemd/system/gdm.service airootfs/etc/systemd/system/display-manager.service

# Set Enabled: NetworkManager
ln -s /usr/lib/systemd/system/NetworkManager.service airootfs/etc/systemd/system/NetworkManager.service

# Set Enabled: Bluetooth
ln -s /usr/lib/systemd/system/bluetooth.service airootfs/etc/systemd/system/bluetooth.service

# Set Enabled: Cups / Printing
ln -s /usr/lib/systemd/system/cups.service airootfs/etc/systemd/system/cups.service

# Create ISO
mkarchiso -v -w . -o ../ ./
