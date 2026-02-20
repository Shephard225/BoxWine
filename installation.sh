#!/data/data/com.termux/files/usr/bin/bash

PREFIX="/data/data/com.termux/files/usr"
PATH="$PREFIX/bin:$PATH"

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
termux-setup-storage
sleep 1
[ ! -d "$HOME/storage/shared" ] && fail "Storage permission not granted."
ok "Storage access granted."

step "Updating system..."
progress_bar
pkg update -y || fail "Update failed."
pkg upgrade -y || fail "Upgrade failed."
ok "System updated."

step "Installing repositories..."
progress_bar
pkg install -y root-repo x11-repo tur-repo || fail "Repo install failed."
ok "Repositories installed."

step "Installing system packages..."
progress_bar
pkg install -y wget curl git tar xz unzip p7zip proot tsu termux-am patchelf hashdeep ncurses-utils which htop nano clang make cmake binutils android-tools python python-tkinter pulseaudio alsa-utils mesa mesa-zink mesa-vulkan-icd-freedreno vulkan-loader vulkan-tools vulkan-loader-android virglrenderer-android virglrenderer-mesa-zink libdrm xwayland xorg-xrandr xorg-xhost xorg-xsetroot termux-x11-nightly dialog || fail "Package install failed."
ok "All packages installed."

sleep 1
clear
title

GLIBC_DIR="$PREFIX/glibc"
PKG_MANAGER_DIR="$GLIBC_DIR/opt/package-manager"
mkdir -p "$PKG_MANAGER_DIR/installed"

GITLAB_TOKEN="ВСТАВЬ_СВОЙ_ТОКЕН"
PROJECT_ID="79662501"
BRANCH="main"

wget_gitlab_pm() {

    FILE_PATH="package-manager"
    ENCODED_PATH=$(echo "$FILE_PATH" | sed 's/\//%2F/g')

    URL="https://gitlab.com/api/v4/projects/$PROJECT_ID/repository/files/$ENCODED_PATH/raw?ref=$BRANCH"

    HTTP_CODE=$(curl -L \
        -H "PRIVATE-TOKEN: $GITLAB_TOKEN" \
        -w "%{http_code}" \
        -o "$PKG_MANAGER_DIR/package-manager" \
        "$URL")

    if [ "$HTTP_CODE" != "200" ]; then
        fail "GitLab download failed (HTTP $HTTP_CODE)"
    fi

    if [ ! -s "$PKG_MANAGER_DIR/package-manager" ]; then
        fail "Downloaded file is empty"
    fi

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

step "Downloading package-manager from GitLab..."
wget_gitlab_pm
ok "Package-manager downloaded."

step "Executing package-manager..."
. "$PKG_MANAGER_DIR/package-manager" || fail "Execution failed."

sync-all || fail "Runtime sync failed."

clear
title
ok "Installation completed successfully."
echo
echo "Type:"
echo "boxwine"
echo