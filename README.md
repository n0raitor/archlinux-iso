# archlinux-iso
Create a custom and updated arch iso with GNOME live desktop (and optional archlinux-installer script, [later added])

# Prebuild ISOs
Feel free to get Prebuild ISOs on SourceForge

[![Download ArchLinux Live ISO Prebuild](https://a.fsdn.com/con/app/sf-download-button)](https://sourceforge.net/projects/archlinux-live-iso-prebuild/files/latest/download)

[![Download ArchLinux Live ISO Prebuild](https://img.shields.io/sourceforge/dt/archlinux-live-iso-prebuild.svg)](https://sourceforge.net/projects/archlinux-live-iso-prebuild/files/latest/download)

### Packages Included
```bash
networkmanager
network-manager-applet
bluez
bluez-utils
cups
xf86-video-qxl
xf86-video-intel
xf86-video-nouveau
xorg

# GNOME
gdm
gnome
gnome-tweaks

# CD/DVD Burning Software
brasero

# Video Converter
handbrake

# E-Mail Client
thunderbird
thunderbird-i18n-de

# Themes and Icons
arc-gtk-theme
arc-icon-theme

# Wallpaper
archlinux-wallpaper

# OpenVPN
openvpn
networkmanager-openvpn

# Must haves
ffmpegthumbnailer
raw-thumbnailer
xarchiver 
file-roller 
ark 
xwallpaper 
archivetools 
archlinux-menu 
archlinux-themes-slim 
archlinux-xdg-menu 
fastjar

# Image Manipulation
gimp

# Video Player
celluloid

# Codex
gst-plugins-base 
gst-plugins-good 
gst-plugins-ugly 

# Browser
chromium
firefox 
midori 
vivaldi 
vivaldi-ffmpeg-codecs

# Office
libreoffice-still
hunspell-en 
hunspell-de 
mythes-en 
mythes-de 
aspell-en 
aspell-de 
languagetool 
enchant
libmythes 

# File System
dosfstools
ntfs-3g 
gvfs

# Archives
zip 
unzip 
unrar 
p7zip 
lzop
```

### New integrated Packages:
* gnome-extra
* evolution (instead of Thunderbird)
* darktable (Like Lightroom but Open Source)
* blender
* vlc
* kdenlive
* audacity
* libreoffice-fresh (instead of libreoffice-still)
* veracrypt - Device Decryption / Encryption Tool
* calibre - E-Book Reader
* gfeeds - RSS Feed Reader
* gnome-firmware
* font-manager
* gparted
* vim

## Build ISO

CAUTION: This Script will reinstall the ArchIso Package. Make sure to backup your ArchIso Data, if you are working with them
```bash
# Get Execution Privileges
chmod +x ./create-arch-iso.sh 

# Run the Script as Root
sudo ./create-arch-iso.sh
```

## Note
I will update this iso build over time to work for future isos.

Feel free to add Issues, if you get errors or if you found bugs.

