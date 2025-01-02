#!/bin/bash
LOCALUSER=norman
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
LOCALPATH=/home/norman/Dokumente/GitHub/archlinux-iso/
done_aur_repo_name="packages_in_repo"
done_aur_repo_file_exists=0
create_minimal=0

echo "############################################"
echo "######## N0Raitor ARCH ISO SCRIPT ##########"
echo "############################################"

echo ""

# Input validation
if [ $# -eq 0 ]
then
    echo "No Arguments supplied, exiting..."
    exit 0

else
    if [ $1 = "--big" ]
    then
        echo "Starting \"Big Aur Repo\" Mode"
        create_minimal=0
    elif [ $1 = "--minimal" ]
    then
        echo "Starting \"Minimal Aur Repo\" Mode"
        create_minimal=1
    else
        echo "Invalid Arguments, exiting ..."
        exit 0
    fi
fi
if [ -f "$done_aur_repo_name" ]
then
    echo "$done_aur_repo_name exists."
    done_aur_repo_file_exists=1
fi

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

# Copy Current Iso Content to local folder
echo -n "cp archiso files... "
mkdir -p archlive
cp -r /usr/share/archiso/configs/releng/* ./archlive/
cd archlive
echo "Done"

#########################
# Customize ISO #########
#########################

### Config Profile (profiledef.sh)

# Set ISO Output Name
if [ $create_minimal = 1 ]
then
    sed -i 's/iso_name="archlinux"/iso_name="archlinux-gnome-min-n0raitor"/g' ./profiledef.sh
else
    sed -i 's/iso_name="archlinux"/iso_name="archlinux-gnome-big-n0raitor"/g' ./profiledef.sh
fi

# Set ISO Volume Label
if [ $create_minimal = 1 ]
then
    sed -i 's/iso_label="ARCH_$(date +%Y%m)"/iso_label="ARCH_GNOME_MIN_N0RAITOR_$(date +%Y%m)"/g' ./profiledef.sh
else
    sed -i 's/iso_label="ARCH_$(date +%Y%m)"/iso_label="ARCH_GNOME_BIG_N0RAITOR_$(date +%Y%m)"/g' ./profiledef.sh
fi

# Set Publisher
sed -i 's/iso_publisher="Arch Linux <https://archlinux.org>"/iso_publisher="N0Raitor <https://n0raitor.com>"/g' ./profiledef.sh

#####################
# Included Packages #
#####################
if [ $create_minimal = 1 ]
then
    cat ../additional_packages >> packages.x86_64
else
    cat ../additional_packages_big >> packages.x86_64
fi
# Add Additional Packages to Iso Build
if [ $done_aur_repo_file_exists = 0 ]
then
    cat ../$done_aur_repo_name >> packages.x86_64
fi

########################
# Included Files #######
########################
cd ..

# Include archlinux-installer scripts from N0Raitor
echo -n "Cloning \"Archlinux-Installer\" by N0Raitor... "
git clone https://github.com/n0raitor/archlinux-installer.git &> /dev/null
cp -r archlinux-installer ./archlive/airootfs/root/
rm -rf archlinux-installer
echo "Done"
cd archlive

### Edit Pacman.conf to add local Repository for AUR Packages
echo "[custom]" >> pacman.conf
echo "SigLevel = Optional TrustAll" >> pacman.conf
echo "Server = file://${LOCALPATH}local/repo" >> pacman.conf

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
