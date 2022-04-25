#!/bin/bash
pacman -R --noconfirm archiso  # Clean Up ArchIsoFiles for a clean build
pacman -S --noconfirm --needed archiso  # Sync Iso

# If archlive folder exists, delete this folder
DIR="./archlive"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Removing archlive folder..."
  sudo rm -rf ./archlive
  echo "Done"
fi

DIR="local/repo"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Removing archlive folder..."
  sudo rm -rf local/repo
  echo "Done"
fi

DIR="aur_tmp_build_dir"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "Removing archlive folder..."
  sudo rm -rf aur_tmp_build_dir
  echo "Done"
fi

# Copy Current Iso Content to local folder
mkdir -p archlive
cp -r /usr/share/archiso/configs/releng/* ./archlive/
cd archlive

#########################
# Customize ISO #########
#########################

### Config Profile (profiledef.sh)

# Set ISO Output Name
sed -i 's/iso_name="archlinux"/iso_name="archlinux-gnome-n0raitor"/g' ./profiledef.sh

# Set ISO Volume Label
sed -i 's/iso_label="ARCH_$(date +%Y%m)"/iso_label="ARCH_GNOME_N0RAITOR_$(date +%Y%m)"/g' ./profiledef.sh

# Set Publisher
sed -i 's/iso_publisher="Arch Linux <https://archlinux.org>"/iso_publisher="N0Raitor <https://n0raitor.com>"/g' ./profiledef.sh

#####################
# Included Packages #
#####################
# Add Additional Packages to Iso Build
cat ../additional_packages >> packages.x86_64

########################
# Included Files #######
########################
cd ..

# Include archlinux-installer scripts from N0Raitor
git clone https://github.com/n0raitor/archlinux-installer.git
cp archlinux-installer ./archlive/airootfs/root/
cd archlive

########################
# Generate Local Repo ##
# For AUR Packages on ##
# ISO                 ##
########################
#cd .. # Starting from the BASE DIR of this Repository
#./create-local-aur-repo.sh
#localpath = $(pwd)
#cd archlive
#cat ../aur_packages >> packages.x86_64  # Add AUR Packages to ISO Included Packages


### Edit Pacman.conf to add local Repository for AUR Packages
#echo "[custom]" >> pacman.conf
#echo "SigLevel = Optional TrustAll" >> pacman.conf
#echo "$localpath/local/repo" >> pacman.conf

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
mkarchiso -v -w . -o ../ ./
