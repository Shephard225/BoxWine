#!/data/data/com.termux/files/usr/bin/bash

clear

title() {
    printf "\n\033[1;36mBoxWine Emulator Installer\033[0m\n"
    printf "\033[1;90mComplete Graphics & Runtime Environment Setup\n\033[0m"
}

step() { printf "\n\033[1;34m▶ %s\033[0m\n" "$1"; }
ok() { printf "\033[1;32m✔ %s\033[0m\n" "$1"; }
fail() { printf "\033[1;31m✖ %s\033[0m\n" "$1"; exit 1; }

progress_bar() {
    for i in {1..30}; do printf "\033[1;36m#\033[0m"; sleep 0.02; done
    echo
}

title

step "Requesting storage permission..."
termux-setup-storage >/dev/null 2>&1
sleep 1
[ ! -d "$HOME/storage/shared" ] && fail "Storage permission not granted."
ok "Storage access granted."

step "Checking mirrors..."
progress_bar
pkg update -y >/dev/null 2>&1 || fail "Mirror check failed."
ok "Mirrors reachable."

step "Cleaning and updating system..."
progress_bar
apt-get clean >/dev/null 2>&1
pkg update -y >/dev/null 2>&1
pkg upgrade -y >/dev/null 2>&1
ok "System updated."

step "Installing repositories..."
progress_bar
pkg install -y root-repo x11-repo tur-repo >/dev/null 2>&1
ok "Repositories installed."

step "Installing all system packages..."
progress_bar
pkg install -y wget curl git tar xz unzip p7zip proot tsu termux-am patchelf hashdeep ncurses-utils which htop nano clang make cmake binutils android-tools python python-tkinter pulseaudio alsa-utils mesa mesa-zink mesa-vulkan-icd-freedreno vulkan-loader vulkan-tools vulkan-loader-android virglrenderer-android virglrenderer-mesa-zink libdrm xwayland xorg-xrandr xorg-xhost xorg-xsetroot termux-x11-nightly firefox mpv vlc vlc-qt gimp abiword >/dev/null 2>&1
ok "All packages installed."

sleep 1
clear
title
printf "\n\033[1;35mStage 1 Completed Successfully\033[0m\n"
sleep 1
clear
title

pkg install -y dialog >/dev/null 2>&1

GLIBC_DIR="$PREFIX/glibc"
PKG_MANAGER_DIR="$GLIBC_DIR/opt/package-manager"
mkdir -p "$PKG_MANAGER_DIR/installed"

GITLAB_TOKEN="glpat-32zjNYcypJgZVq_TWbgg6m86MQp1OmtwdHM2Cw.01.1210wi9p8"
PROJECT_ID="79662501"

wget_gitlab_pm() {
    curl -sL -H "PRIVATE-TOKEN: $GITLAB_TOKEN" \
    "https://gitlab.com/api/v4/projects/$PROJECT_ID/repository/files/package-manager/raw?ref=main" \
    -o "$PKG_MANAGER_DIR/package-manager"
    [ $? -ne 0 ] && fail "Failed to download package-manager"
    chmod +x "$PKG_MANAGER_DIR/package-manager"
}

if [ -d "$GLIBC_DIR" ]; then
    dialog --yesno "Existing glibc directory detected.\nRemove it before continuing?" 10 60
    [ $? -eq 0 ] && rm -rf "$GLIBC_DIR" || fail "Installation aborted."
fi

CHOICE=$(dialog --clear --backtitle "BoxWine Installer" --title "Select Runtime Prefix" \
--menu "Choose prefix to install:" 15 60 2 \
1 "GLIBC Prefix (Stable)" \
2 "Ajay Prefix" \
3>&1 1>&2 2>&3)
clear
[ -z "$CHOICE" ] && fail "Installation cancelled."

INSTALL_DIR="$PREFIX/boxwine"
mkdir -p "$INSTALL_DIR"

step "Installing..."
wget_gitlab_pm
ok "Package-manager ready."

. "$PKG_MANAGER_DIR/package-manager"
sync-all

clear
title
ok "Installation completed successfully."
echo
echo "To launch emulator type:"
echo "boxwine"
echo
