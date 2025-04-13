#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root using sudo!"
    exit 1
fi

USER_HOME=$(eval echo ~$SUDO_USER)

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
    breeze-gtk \
    breeze-plymouth \
    btop \
    bluedevil \
    cmatrix \
    discord \
    dnsmasq \
    dnssec-anchors \
    dolphin \
    dosfstools \
    drkonqi \
    elisa \
    ell \
    ethtool \
    exfatprogs \
    eza \
    fastfetch \
    filelight \
    flatpak-kcm \
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
    kde-gtk-config \
    kdeconnect \
    kdenlive \
    kdeplasma-addons \
    kfind \
    kgamma \
    kio-admin \
    kitty \
    kolourpaint \
    kscreen \
    ksshaskpass \
    kstars \
    ksystemlog \
    kwrite \
    kwrited \
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
    nwg-look \
    obsidian \
    okular \
    openconnect \
    openh264 \
    openvpn \
    oxygen \
    oxygen-sounds \
    papirus-icon-theme \
    partitionmanager \
    pipewire-alsa \
    pipewire-jack \
    pipewire-pulse \
    plasma-browser-integration \
    plasma-desktop \
    plasma-disks \
    plasma-firewall \
    plasma-nm \
    plasma-pa \
    plasma-sdk \
    plasma-systemmonitor \
    plasma-thunderbolt \
    plasma-workspace-wallpapers \
    plymouth-kcm \
    print-manager \
    pv \
    qalculate-qt \
    qbittorrent \
    remmina \
    rpcbind \
    signal-desktop \
    sg3_utils \
    spectacle \
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
    wacomtablet \
    x264 \
    xfsprogs \
    xl2tpd \
    xmlsec

fastfetch -c examples/9

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
    com.bitwarden.desktop \
    com.geeks3d.furmark \
    com.jetbrains.Rider \
    com.obsproject.Studio \
    com.pokemmo.PokeMMO \
    com.protonvpn.www \
    io.github.aandrew_me.ytdn \
    io.github.endless_sky.endless_sky \
    io.github.freedoom.Phase1 \
    io.github.shiftey.Desktop \
    net.runelite.RuneLite \
    org.openttd.OpenTTD

echo "All flatpaks installed ..."
echo "Enabling ly display manager ..."
systemctl enable ly.service
echo "Setup complete!"
fastfetch -l arch3