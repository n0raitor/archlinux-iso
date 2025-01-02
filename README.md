# ArchLinux-ISO
Creates a custom and updated arch iso with GNOME live desktop (and archlinux-installer script)

There are two versions of the ISO
1. Small / Minimal Version (default)
2. Big Version (-big): Includes lots of Live Software

# Prebuild ISOs
Feel free to get Prebuild ISOs on SourceForge

[![Download ArchLinux Live ISO Prebuild](https://a.fsdn.com/con/app/sf-download-button)](https://sourceforge.net/projects/archlinux-live-iso-prebuild/files/latest/download)

[![Download ArchLinux Live ISO Prebuild](https://img.shields.io/sourceforge/dt/archlinux-live-iso-prebuild.svg)](https://sourceforge.net/projects/archlinux-live-iso-prebuild/files/latest/download)



# Packages Included
## GNOME
### Minimal
#### BASIC
```
networkmanager
network-manager-applet
xf86-video-qxl
xf86-video-intel
xf86-video-nouveau
xf86-video-amdgpu
xf86-input-synaptics
xorg
intel-ucode
amd-ucode

# GNOME
gdm
gnome
gnome-tweaks

# GNOME Dropdown Terminal
guake
nautilus-terminal

# Must haves
ffmpegthumbnailer
fastjar

# Video Player
celluloid

# Firewall
ufw
ufw-extras
gufw

# Codex
gst-plugins-base
gst-plugins-good
gst-plugins-ugly
gst-libav

# Browser
chromium
firefox

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

# Encryption
veracrypt

font-manager
gparted

# Misc
vim
reflector
nano
pacman-contrib
git
usbutils
dialog
powertop
rsync
net-tools
openssh
xdg-user-dirs
os-prober
bash-completion
wireless_tools
wpa_supplicant

# Audio
alsa-plugins
alsa-utils
pulseaudio
pulseaudio-alsa
```
#### AUR
```
timeshift
balena-etcher
```
### BIG
#### BASIC
```
networkmanager
network-manager-applet
bluez
bluez-utils
cups
xf86-video-qxl
xf86-video-intel
xf86-video-nouveau
xf86-video-amdgpu
xf86-input-synaptics
xorg
intel-ucode
amd-ucode

# GNOME
gdm
gnome
gnome-tweaks
gnome-extra
gnome-appfolders-manager
gnome-applets
gnome-break-timer
gnome-firmware
gnome-flashback
gnome-icon-theme-extras
gnome-latex
gnome-mplayer
gnome-packagekit
gnome-panel
gnome-passwordsafe
gnome-pie
gnome-podcasts
gnome-shell-extension-appindicator
gnome-shell-extension-gtile
gnome-subtitles
gnome-tour

# GNOME Dropdown Terminal
guake
nautilus-terminal


# GNOME misc Apps (TBA)

# CD/DVD Burning Software
brasero

# Video Converter
handbrake

# E-Mail Client
evolution
thunderbird
thunderbird-i18n-eu
thunderbird-i18n-de
thunderbird-i18n-en-us

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
fastjar

# Image Manipulation
gimp
darktable

# 3D Dev
blender

# Video Player
celluloid
vlc

# Firewall
ufw
ufw-extras
gufw

# Video Editor
kdenlive
openshot

# Music Editor
audacity

# Codex
gst-plugins-base
gst-plugins-good
gst-plugins-ugly
gst-libav

# Browser
chromium
firefox

# Office
libreoffice-still
hunspell
hunspell-en_us
hunspell-de
mythes
mythes-en
mythes-de
aspell
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

# Encryption
veracrypt

# E-Books
calibre

# Feed
gfeeds

# Sys
# baobab  # Memory Analyzer
# gufw    # Firewall Gui
font-manager
gparted

# Misc
vim
reflector
nano
pacman-contrib
git
usbutils
dialog
powertop
rsync
net-tools
openssh
xdg-user-dirs
os-prober
qbittorrent
bash-completion
wireless_tools
wpa_supplicant
python-pip
ipython
nitroshare

# Audio
alsa-plugins
alsa-utils
pulseaudio
pulseaudio-alsa
pulseaudio-bluetooth

# Printing
cups
ghostscript
cups-pdf
hplip

# Fonts
ttf-bitstream-vera
ttf-dejavu
ttf-liberation
adobe-source-sans-pro-fonts
#ttf-anonymous-pro
ttf-droid
ttf-ubuntu-font-family
ttf-roboto
ttf-roboto-mono
ttf-font-awesome
ttf-fira-code
cantarell-fonts
```
#### AUR
```
ttf-hackgen
ttf-gentium-basic
ttf-ms-fonts
flat-remix
flat-remix-gtk
flat-remix-gnome
sweet-cursors-theme-git
timeshift
brave-bin
gitkraken
zoom
slack-desktop
handbrake
jdownloader2
ida-free
kazam
```
## Build ISO

CAUTION: This Script will reinstall the ArchIso Package. Make sure to backup your ArchIso Data, if you are working with them

### Edit  Variables
#### On create-arch-iso.sh / create-arch-iso-big.sh / test-packages-valid.sh
Edit this Variables to get the scripts work on your mashine:
* LOCALPATH
* LOCALUSER

### Get Execution Privileges
```bash
chmod +x create-arch-iso.sh
chmod +x create-local-aur-repo.sh
chmod +x rm_repo_of_aur.sh
```

### Create AUR Local Repository
Make sure to create a Repo with the AUR Packages (*create-local-aur-repo.sh*) before you run the create scripts, otherwise the aur packages would not be added to the iso.
Use the following commands to create a aur-local-repo for the *minimal* or the *big* ISO.

```bash
./create-local-aur-repo.sh --minimal
./create-local-aur-repo.sh --big
```
Use the *--update* as a second parameter, to reset the existing repo and create all aur packages reguarding to the minimal or big edition from source.

Use this for Debug Information:
```bash
./create-local-aur-repo.sh --minimal --update --debug
./create-local-aur-repo.sh --big --update --debug
```
**TIPP: You my need to install missing dependencies using *sudo pacman -S <packagename>*.**

**NOTE:** I highly recommend this argument, if you want to create a minimal and a big one.
After you created the "Big" ISO and its AUR Local Repo, use the *--minimal --update* Arguments on the Create Local Aur Repo Script to reset the repo to just use the the minimal aur packages in the minimal iso creation process. This is essential, because the script will install all package names in the repo (file *packages_in_repo*, if it exists) for the target iso. There is no *minimal* or *big* repo edition at this time. This has disc space and redundancy reasons.

### Run the Creation Script as Root
```
./create-arch-iso.sh --minimal
```
or
```
./create-arch-iso.sh --big
```

## Testing
To Test, if all BASIC Packages are available to get installed on the ISO, use this script:
```
sudo ./test-packages-valid.sh
```
If the Progress Lines appear, use CTRL+C to quit the Test. All Packages should be available at this stage.

## Note
I will update this iso build over time to work for future isos.

Feel free to add Issues, if you get errors or if you found bugs.
