#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root using sudo!"
    exit 1
fi

USER_HOME=$(eval echo ~$SUDO_USER)

fastfetch
echo "Creating home directory folders ..."
sleep 4
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.Public"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.Templates"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/Audio"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/Documents"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/Images"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/Videos"

echo "Setting up AUR helpers ..."
pacman -Syu --noconfirm
pacman -S --noconfirm \
    cargo \
    go

cd "$USER_HOME/Downloads"
sudo -u "$SUDO_USER" git clone https://aur.archlinux.org/paru.git
cd paru
sudo -u "$SUDO_USER" makepkg -si
echo "Paru has been installed ..."
cd "$USER_HOME/Downloads"
sudo -u "$SUDO_USER" git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u "$SUDO_USER" makepkg -si
echo "Yay has been installed ..."

echo "Cloning bash theme ..."
cd "$USER_HOME"
sudo -u "$SUDO_USER" mkdir -p .bash/themes/agnoster-bash
sudo -u "$SUDO_USER" git clone https://github.com/speedenator/agnoster-bash.git .bash/themes/agnoster-bash

echo "Copying user configuration files ..."
cd "$USER_HOME/Downloads/Arch"
sudo -u "$SUDO_USER" cp -r .bashrc "$USER_HOME"
sudo -u "$SUDO_USER" cp -r .nanorc "$USER_HOME"
sudo -u "$SUDO_USER" cp -r fastfetch "$USER_HOME/.config"
sudo -u "$SUDO_USER" cp -r kitty "$USER_HOME/.config"
sudo -u "$SUDO_USER" cp -r kwalletrc "$USER_HOME/.config"
sudo -u "$SUDO_USER" cp -r mc "$USER_HOME/.config"

fastfetch -c examples/9
echo "Installing system packages ..."
sleep 4
pacman -Syu --noconfirm
pacman -S --noconfirm \
    alsa-utils \
    antimicrox \
    ark \
    audacity \
    audiotube \
    b43-fwcutter \
    bat \
    bind \
    btop \
    cmatrix \
    discord \
    dnsmasq \
    dnssec-anchors \
    dolphin \
    dosfstools \
    elisa \
    ell \
    ethtool \
    exfatprogs \
    eza \
    fastfetch \
    filelight \
    gamescope \
    gimp \
    grub-btrfs \
    gwenview \
    hdparm \
    htop \
    inotify-tools \
    isoimagewriter \
    iwd \
    kate \
    kcalc \
    kcharselect \
    kcolorchooser \
    kcolorpicker \
    kdeconnect \
    kdenlive \
    kfind \
    kio-admin \
    kitty \
    kolourpaint \
    kstars \
    ksystemlog \
    kwrite \
    lib32-mesa \
    lib32-vulkan-radeon \
    lsscsi \
    lutris \
    ly \
    mangohud \
    memtest86+-efi \
    mesa \
    mc \
    mission-center \
    mtools \
    nfs-utils \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    ntfs-3g \
    obsidian \
    okular \
    openconnect \
    openh264 \
    openvpn \
    papirus-icon-theme \
    partitionmanager \
    pipewire-alsa \
    pipewire-jack \
    pipewire-pulse \
    pipewire-session-manager \
    plasma-desktop \
    pv \
    qalculate-qt \
    qbittorrent \
    remmina \
    rpcbind \
    signal-desktop \
    sg3_utils \
    steam \
    sysfsutils \
    systemd-resolvconf \
    texlive-fontsextra \
    texlive-fontsrecommended \
    thin-provisioning-tools \
    ttf-jetbrains-mono \
    ttf-jetbrains-mono-nerd \
    timeshift \
    vlc \
    vulkan-radeon \
    vvave \
    x264 \
    xfsprogs \
    xl2tdp \
    xmlsec

fastfetch -l arch2

echo "Installing AUR packages ..."
sleep 4
sudo -u "$SUDO_USER" yay -Sua --noconfirm
sudo -u "$SUDO_USER" yay -S --noconfirm \
    bibata-cursor-theme-bin \
    bottles \
    brave-bin \
    flatseal \
    hardinfo2 \
    proton-mail-bin \
    protontricks \
    protonup-qt \
    vscodium-bin

echo "Checking for flatpak updates ..."
sudo -u "$SUDO_USER" flatpak update -y

sudo -u "$SUDO_USER" fastfetch

sleep 4
echo "Installing flatpaks from Flathub: ..."

sudo -u "$SUDO_USER" flatpak install flathub -y \
    com.jetbrains.Rider \
    io.github.shiftey.Desktop \
    com.pokemmo.PokeMMO \
    io.github.endless_sky.endless_sky \
    io.github.freedoom.Phase1 \
    net.runelite.RuneLite \
    org.openttd.OpenTTD \
    com.obsproject.Studio \
    io.github.aandrew_me.ytdn \
    com.bitwarden.desktop \
    com.geeks3d.furmark \
    com.protonvpn.www

echo "All flatpaks installed ..."
echo "Enabling ly display manager ..."
systemctl enable ly.service
echo "Setup complete!"
fastfetch -l arch3