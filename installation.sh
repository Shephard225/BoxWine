#!/data/data/com.termux/files/usr/bin/bash
set -e

PREFIX="/data/data/com.termux/files/usr"
PATH="$PREFIX/bin:$PATH"
BOX_DIR="$HOME/.boxwine-installer"
GLIBC_DIR="$PREFIX/glibc"
BIN="$PREFIX/bin/boxwine"
TEMP="$BOX_DIR/tmp"

mkdir -p "$BOX_DIR" "$TEMP" "$GLIBC_DIR"

title() {
clear
printf "\033[1;36m╔════════════════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║                        BOXWINE INSTALLER                   ║\033[0m\n"
printf "\033[1;36m║              Complete Emulator Environment Setup           ║\033[0m\n"
printf "\033[1;36m╚════════════════════════════════════════════════════════════╝\033[0m\n\n"
}

space_check() {
REQ=2500
FREE=$(df -m "$PREFIX" | tail -1 | awk '{print $4}')
if [ "$FREE" -lt "$REQ" ]; then
dialog --msgbox "Not enough space: ${FREE}MB free\nRequired: ${REQ}MB" 8 50
exit 1
fi
}

install_block() {
NAME="$1"; shift
dialog --infobox "Installing $NAME..." 3 60
pkg install -y "$@" >/dev/null 2>&1
dialog --msgbox "$NAME installed successfully" 6 50
}

rootfs_menu() {
dialog --menu "Select prefix type" 12 50 2 \
1 "glibc-prefix (recommended)" \
2 "ajay-prefix" 2> "$TEMP/prefix"
CHOICE=$(cat "$TEMP/prefix"); rm -f "$TEMP/prefix"
}

wine_menu() {
dialog --menu "Select Wine version" 18 70 4 \
1 "Wine 10.19 Staging amd64 wow64 (stable)" \
2 "Wine 10.19 Staging amd64" \
3 "Wine 10.19 Staging TKG amd64 wow64" \
4 "Wine 10.19 Staging TKG amd64" 2> "$TEMP/wine"
WINE=$(cat "$TEMP/wine"); rm -f "$TEMP/wine"
}

download_extract() {
URL="$1"
DEST="$2"
FILE=$(basename "$URL")
dialog --infobox "Downloading $FILE ..." 3 60
curl -L "$URL" -o "$TEMP/$FILE"
dialog --infobox "Extracting $FILE ..." 3 60
tar -xJf "$TEMP/$FILE" -C "$DEST"
rm -f "$TEMP/$FILE"
}

create_command() {
cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export PATH="$PREFIX/bin:\$PATH"
export BOXWINE_ROOT="$GLIBC_DIR"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF
chmod +x "$BIN"
}

title
dialog --infobox "Preparing Termux storage..." 3 60
termux-setup-storage & sleep 4 &>/dev/null
while [ ! -d "$HOME/storage" ]; do
dialog --msgbox "Please grant storage permission in Termux settings" 7 50
sleep 2
done

space_check

install_block "Core Tools" wget curl git nano dialog tar xz unzip p7zip proot tsu
install_block "Graphics Stack" mesa mesa-zink mesa-vulkan-icd-freedreno vulkan-loader vulkan-tools virglrenderer-android virglrenderer-mesa-zink
install_block "Display System" termux-x11-nightly xwayland xorg-xhost xorg-xrandr xorg-xsetroot
install_block "Audio System" pulseaudio alsa-utils
install_block "Development Tools" clang make cmake binutils python python-tkinter hashdeep htop neofetch

clear
title
dialog --msgbox "Environment prepared successfully" 6 50

rootfs_menu

if [ "$CHOICE" = "1" ]; then
download_extract "https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz" "$GLIBC_DIR"
wine_menu
case "$WINE" in
1) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64-wow64.tar.xz" ;;
2) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64.tar.xz" ;;
3) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64-wow64.tar.xz" ;;
4) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64.tar.xz" ;;
esac
download_extract "$URL" "$GLIBC_DIR"
else
download_extract "https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz" "$GLIBC_DIR"
fi

dialog --infobox "Configuring BoxWine command..." 3 60
create_command

clear
printf "\033[1;36m╔════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║          BOXWINE INSTALLED SUCCESSFULLY   ║\033[0m\n"
printf "\033[1;36m╚════════════════════════════════════════════╝\033[0m\n\n"
printf "\033[1;33mTo start emulator type:\033[0m boxwine\n\n"
