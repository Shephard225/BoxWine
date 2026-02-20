#!/data/data/com.termux/files/usr/bin/bash
set -e

PREFIX="/data/data/com.termux/files/usr"
PATH="$PREFIX/bin:$PATH"
GLIBC_DIR="$PREFIX/glibc"
BIN="$PREFIX/bin/boxwine"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"

mkdir -p "$WORK" "$TMP" "$GLIBC_DIR"

ui() {
clear
printf "\033[1;36m╔══════════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║                     BOXWINE SETUP                   ║\033[0m\n"
printf "\033[1;36m║        Advanced Emulator Environment Installer      ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════════════════════╝\033[0m\n\n"
}

bar() {
printf "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n"
}

install_pkg() {
NAME="$1"
shift
printf "\033[1;33m→ Installing %s...\033[0m\n" "$NAME"
apt install -y "$@" >/dev/null 2>&1
printf "\033[1;32m✔ %s installed\033[0m\n\n" "$NAME"
sleep 0.3
}

check_space() {
REQ=3000
FREE=$(df -m "$PREFIX" | tail -1 | awk '{print $4}')
if [ "$FREE" -lt "$REQ" ]; then
printf "\033[1;31mNot enough space: %s MB free. Required: %s MB\033[0m\n" "$FREE" "$REQ"
exit 1
fi
}

ui
bar
printf "\033[1;33mPreparing Termux environment...\033[0m\n"
termux-setup-storage & sleep 4 &>/dev/null

while [ ! -d "$HOME/storage" ]; do
printf "\033[1;31mGrant storage permission in Termux settings...\033[0m\n"
sleep 2
done

bar
printf "\033[1;33mUpdating system...\033[0m\n"
apt update >/dev/null 2>&1
apt upgrade -y >/dev/null 2>&1
printf "\033[1;32m✔ System updated\033[0m\n\n"

check_space

bar
printf "\033[1;36mInstalling Core Packages\033[0m\n"
install_pkg "wget" wget
install_pkg "curl" curl
install_pkg "git" git
install_pkg "nano" nano
install_pkg "htop" htop
install_pkg "dialog" dialog
install_pkg "tar" tar
install_pkg "xz-utils" xz-utils
install_pkg "unzip" unzip
install_pkg "p7zip" p7zip
install_pkg "proot" proot
install_pkg "tsu" tsu
install_pkg "which" which
install_pkg "file" file

bar
printf "\033[1;36mInstalling Graphics Stack\033[0m\n"
install_pkg "mesa" mesa
install_pkg "mesa-zink" mesa-zink
install_pkg "vulkan-loader" vulkan-loader
install_pkg "vulkan-tools" vulkan-tools
install_pkg "mesa-vulkan-icd-freedreno" mesa-vulkan-icd-freedreno
install_pkg "virglrenderer-android" virglrenderer-android
install_pkg "virglrenderer-mesa-zink" virglrenderer-mesa-zink
install_pkg "libdrm" libdrm

bar
printf "\033[1;36mInstalling X11 Environment\033[0m\n"
install_pkg "termux-x11-nightly" termux-x11-nightly
install_pkg "xwayland" xwayland
install_pkg "xorg-xhost" xorg-xhost
install_pkg "xorg-xrandr" xorg-xrandr
install_pkg "xorg-xsetroot" xorg-xsetroot

bar
printf "\033[1;36mInstalling Audio System\033[0m\n"
install_pkg "pulseaudio" pulseaudio
install_pkg "alsa-utils" alsa-utils

bar
printf "\033[1;36mInstalling Development Tools\033[0m\n"
install_pkg "clang" clang
install_pkg "make" make
install_pkg "cmake" cmake
install_pkg "binutils" binutils
install_pkg "python" python
install_pkg "python-tkinter" python-tkinter
install_pkg "hashdeep" hashdeep

clear
ui
bar
printf "\033[1;32mEnvironment Ready\033[0m\n\n"

dialog --menu "Select Prefix Type" 12 50 2 \
1 "glibc-prefix (recommended)" \
2 "ajay-prefix" 2> "$TMP/prefix"

PREFIX_CHOICE=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$PREFIX_CHOICE" = "1" ]; then
printf "\033[1;33mDownloading glibc rootfs...\033[0m\n"
curl -L -o "$TMP/rootfs.tar.xz" https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz
tar -xJf "$TMP/rootfs.tar.xz" -C "$GLIBC_DIR"
rm -f "$TMP/rootfs.tar.xz"

dialog --menu "Select Wine Version" 18 70 4 \
1 "Wine 10.19 Staging amd64 wow64 (stable)" \
2 "Wine 10.19 Staging amd64" \
3 "Wine 10.19 Staging TKG amd64 wow64" \
4 "Wine 10.19 Staging TKG amd64" 2> "$TMP/wine"

WINE_CHOICE=$(cat "$TMP/wine")
rm -f "$TMP/wine"

case "$WINE_CHOICE" in
1) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64-wow64.tar.xz" ;;
2) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64.tar.xz" ;;
3) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64-wow64.tar.xz" ;;
4) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64.tar.xz" ;;
esac

printf "\033[1;33mDownloading Wine...\033[0m\n"
curl -L -o "$TMP/wine.tar.xz" "$URL"
tar -xJf "$TMP/wine.tar.xz" -C "$GLIBC_DIR"
rm -f "$TMP/wine.tar.xz"

else
printf "\033[1;33mDownloading ajay rootfs...\033[0m\n"
curl -L -o "$TMP/rootfs.tar.xz" https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz
tar -xJf "$TMP/rootfs.tar.xz" -C "$GLIBC_DIR"
rm -f "$TMP/rootfs.tar.xz"
fi

cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export BOXWINE_ROOT="$GLIBC_DIR"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF

chmod +x "$BIN"

clear
printf "\033[1;36m╔══════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║        BOXWINE INSTALLED ✔          ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════╝\033[0m\n\n"
printf "\033[1;33mType:\033[0m boxwine\n\n"
