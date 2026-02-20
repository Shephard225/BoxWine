
#!/data/data/com.termux/files/usr/bin/bash

clear

title() {
    printf "\n\033[1;36mBoxWine Emulator Installer\033[0m\n"
    printf "\033[1;90mComplete Graphics & Runtime Environment Setup\n\033[0m"
}

step() {
    printf "\n\033[1;34m▶ %s\033[0m\n" "$1"
}

ok() {
    printf "\033[1;32m✔ %s\033[0m\n" "$1"
}

fail() {
    printf "\033[1;31m✖ %s\033[0m\n" "$1"
    exit 1
}

progress_bar() {
    for i in {1..30}; do
        printf "\033[1;36m#\033[0m"
        sleep 0.02
    done
    echo
}

title

step "Requesting storage permission..."
termux-setup-storage
sleep 2
[ ! -d "$HOME/storage/shared" ] && fail "Storage permission not granted."
ok "Storage access granted."

step "Checking Termux mirrors..."
progress_bar
pkg update -y  || fail "Mirror check failed."
ok "Mirrors reachable."

step "Cleaning and updating system..."
progress_bar
apt-get clean
pkg update -y
pkg upgrade -y
ok "System updated."

step "Installing repositories..."
progress_bar
pkg install -y root-repo x11-repo tur-repo
ok "Repositories installed."

step "Installing base system packages..."
progress_bar
pkg install -y \
wget curl git tar xz unzip p7zip \
proot tsu termux-am \
patchelf hashdeep \
ncurses-utils which \
htop nano \
clang make cmake binutils \
android-tools \
python python-tkinter
ok "Base system ready."

step "Installing audio stack..."
progress_bar
pkg install -y pulseaudio alsa-utils
ok "Audio stack installed."

step "Installing full graphics stack..."
progress_bar
pkg install -y \
mesa mesa-zink \
mesa-vulkan-icd-freedreno \
vulkan-loader vulkan-tools vulkan-loader-android \
virglrenderer-android virglrenderer-mesa-zink \
libdrm \
xwayland \
xorg-xrandr xorg-xhost xorg-xsetroot \
termux-x11-nightly
ok "Graphics stack installed."

step "Installing additional utilities..."
progress_bar
pkg install -y firefox mpv vlc vlc-qt gimp abiword
ok "Utilities installed."

sleep 2
clear
title
printf "\n\033[1;35mStage 1 Completed Successfully\033[0m\n"
sleep 2
clear

title
printf "\n\033[1;36mProceeding to Runtime Installation...\033[0m\n"
sleep 2
clear
title

pkg install -y dialog

INSTALL_DIR="$PREFIX/boxwine"
REPO="https://github.com/Shephard225/BoxWine/releases/download/emu-files"

if [ -d "$PREFIX/glibc" ]; then
    dialog --yesno "Existing glibc directory detected.\n\nRemove it before continuing?" 10 60
    if [ $? -eq 0 ]; then
        rm -rf "$PREFIX/glibc"
    else
        clear
        fail "Installation aborted."
    fi
fi

CHOICE=$(dialog --clear \
--backtitle "BoxWine Emulator Installer" \
--title "Select Runtime Prefix" \
--menu "Choose prefix to install:" 15 60 2 \
1 "GLIBC Prefix (Stable)" \
2 "Ajay Prefix (Optimized)" \
3>&1 1>&2 2>&3)

clear
[ -z "$CHOICE" ] && fail "Installation cancelled."

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit 1

if [ "$CHOICE" = "1" ]; then
    FILE="rootfs-glibc-boxwine.tar.xz"
    RUNTIME="GLIBC Prefix"
elif [ "$CHOICE" = "2" ]; then
    FILE="ajay-prefix-boxwine.tar.xz"
    RUNTIME="Ajay Prefix"
else
    fail "Invalid selection."
fi

URL="$REPO/$FILE"

step "Downloading $RUNTIME..."
echo "Source: $URL"
echo

wget -L --show-progress "$URL" || fail "Download failed."

[ ! -f "$FILE" ] && fail "Runtime archive not found."

step "Extracting runtime..."
tar -xJf "$FILE" || fail "Extraction failed."
rm -f "$FILE"

[ ! -f "$INSTALL_DIR/boxwine" ] && fail "Executable 'boxwine' not found."

chmod +x "$INSTALL_DIR/boxwine"

cat > "$PREFIX/bin/boxwine" << EOF
#!/data/data/com.termux/files/usr/bin/bash
cd $PREFIX/boxwine
exec ./boxwine "\$@"
EOF

chmod +x "$PREFIX/bin/boxwine"

clear
title
ok "Installation completed successfully."

echo
echo "To launch emulator type:"
echo
echo "boxwine"
echo
echo