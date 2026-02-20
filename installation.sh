#!/data/data/com.termux/files/usr/bin/bash

set -e

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

title

step "Updating Termux..."
pkg update -y || fail "Update failed"
pkg upgrade -y || fail "Upgrade failed"
ok "System updated"

step "Installing required packages..."
pkg install -y wget curl git tar xz unzip p7zip proot tsu termux-am patchelf hashdeep ncurses-utils which htop nano clang make cmake binutils android-tools python python-tkinter pulseaudio alsa-utils mesa mesa-zink mesa-vulkan-icd-freedreno vulkan-loader vulkan-tools vulkan-loader-android virglrenderer-android virglrenderer-mesa-zink libdrm xwayland xorg-xrandr xorg-xhost xorg-xsetroot termux-x11-nightly dialog || fail "Package installation failed"
ok "Packages installed"

GLIBC_DIR="$PREFIX/glibc"
PKG_MANAGER_DIR="$GLIBC_DIR/opt/package-manager"
mkdir -p "$PKG_MANAGER_DIR/installed"

echo
read -p "Enter GitLab Project ID: " PROJECT_ID
read -p "Enter Branch (main/master): " BRANCH
read -sp "Enter GitLab Token: " GITLAB_TOKEN
echo

wget_gitlab_pm() {

FILE_PATH="package-manager"
ENCODED_PATH=$(echo "$FILE_PATH" | sed 's/\//%2F/g')

URL="https://gitlab.com/api/v4/projects/$PROJECT_ID/repository/files/$ENCODED_PATH/raw?ref=$BRANCH"

step "Downloading package-manager..."

HTTP_CODE=$(curl -L \
  -H "PRIVATE-TOKEN: $GITLAB_TOKEN" \
  -w "%{http_code}" \
  -o "$PKG_MANAGER_DIR/package-manager" \
  "$URL")

if [ "$HTTP_CODE" != "200" ]; then
    fail "GitLab API error (HTTP $HTTP_CODE)"
fi

if [ ! -s "$PKG_MANAGER_DIR/package-manager" ]; then
    fail "Downloaded file is empty"
fi

chmod +x "$PKG_MANAGER_DIR/package-manager"
ok "Package-manager downloaded"
}

if [ -d "$GLIBC_DIR" ]; then
read -p "Existing glibc detected. Remove it? (y/n): " CONFIRM
[ "$CONFIRM" = "y" ] && rm -rf "$GLIBC_DIR" || fail "Installation aborted"
fi

wget_gitlab_pm

step "Executing package-manager..."
. "$PKG_MANAGER_DIR/package-manager" || fail "Execution failed"

sync-all || fail "Runtime sync failed"

clear
title
ok "Installation completed successfully"
echo
echo "Run with:"
echo "boxwine"
echo