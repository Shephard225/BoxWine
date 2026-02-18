#!/data/data/com.termux/files/usr/bin/bash

clear

title() {
    printf "\n\033[1;36mBoxWine Emulator Installer\033[0m\n"
    printf "\033[1;90mComplete Graphics & Runtime Environment Setup\n\033[0m"
}

step() {
    printf "\n\033[1;34m%s\033[0m\n" "$1"
}

ok() {
    printf "\033[1;32m%s\033[0m\n" "$1"
}

fail() {
    printf "\033[1;31m%s\033[0m\n" "$1"
    exit 1
}

progress_bar() {
(
for i in $(seq 0 5 100); do
    echo $i
    sleep 0.03
done
) | dialog --gauge "Processing..." 8 60 0
}

title

step "Requesting storage permission..."
termux-setup-storage >/dev/null 2>&1
sleep 2
[ ! -d "$HOME/storage/shared" ] && fail "Storage permission not granted."

step "Cleaning and updating system..."
apt-get clean >/dev/null 2>&1
pkg update -y >/dev/null 2>&1
pkg upgrade -y >/dev/null 2>&1

step "Installing repositories..."
pkg install -y root-repo x11-repo tur-repo >/dev/null 2>&1

step "Installing base system packages..."
pkg install -y \
wget curl git tar xz unzip p7zip \
proot tsu termux-am \
patchelf hashdeep \
ncurses-utils which \
htop nano \
clang make cmake binutils \
android-tools \
python python-tkinter \
>/dev/null 2>&1

step "Installing audio stack..."
pkg install -y \
pulseaudio alsa-utils \
>/dev/null 2>&1

step "Installing full graphics stack..."
pkg install -y \
mesa mesa-zink \
mesa-vulkan-icd-freedreno \
vulkan-loader vulkan-tools vulkan-loader-android \
virglrenderer-android virglrenderer-mesa-zink \
libdrm \
xwayland \
xorg-xrandr xorg-xhost xorg-xsetroot \
termux-x11-nightly \
>/dev/null 2>&1

step "Installing additional utilities..."
pkg install -y \
firefox mpv vlc vlc-qt \
gimp abiword \
>/dev/null 2>&1

ok "All system packages installed."

pkg install -y dialog >/dev/null 2>&1

INSTALL_DIR="$PREFIX/boxwine"
BIN_LINK="$PREFIX/bin/boxwine"
REPO="https://github.com/Shephard225/BoxWine/releases/download/emu-files"

if [ -d "$INSTALL_DIR" ]; then
    dialog --yesno "Previous installation detected.\n\nRemove it before installing new version?" 10 60
    if [ $? -eq 0 ]; then
        rm -rf "$INSTALL_DIR"
    else
        clear
        exit 1
    fi
fi

CHOICE=$(dialog --clear \
--backtitle "BoxWine Emulator Installer" \
--title "Select Runtime Version" \
--menu "Choose runtime to install:" 15 60 2 \
1 "Standard GLIBC Runtime (Stable)" \
2 "Ajay Optimized Prefix (Experimental)" \
3>&1 1>&2 2>&3)

clear

[ -z "$CHOICE" ] && fail "Installation cancelled."

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit 1

if [ "$CHOICE" = "1" ]; then
    FILE="glibc-boxwine.tar.xz"
    RUNTIME="Standard GLIBC"
elif [ "$CHOICE" = "2" ]; then
    FILE="ajay-prefix-boxwine.tar.xz"
    RUNTIME="Ajay Optimized"
else
    fail "Invalid selection."
fi

step "Downloading $RUNTIME runtime..."
wget --show-progress "$REPO/$FILE" || fail "Download failed."

[ ! -f "$FILE" ] && fail "Runtime archive missing."

step "Extracting runtime..."
progress_bar
tar -xJf "$FILE" || fail "Extraction failed."
rm -f "$FILE"

[ ! -f "$INSTALL_DIR/start-boxwine.sh" ] && fail "Launcher file not found in archive."

chmod +x "$INSTALL_DIR/start-boxwine.sh"
ln -sf "$INSTALL_DIR/start-boxwine.sh" "$BIN_LINK"

clear
title

ok "Installation completed successfully."

echo
echo "To launch emulator type:"
echo
echo "boxwine"
echo