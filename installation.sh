#!/data/data/com.termux/files/usr/bin/bash
set -e

PREFIX="/data/data/com.termux/files/usr"
PATH="$PREFIX/bin:$PATH"
ROOT="$PREFIX/glibc"
BIN="$PREFIX/bin/boxwine"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"

mkdir -p "$WORK" "$TMP" "$ROOT"

clear_screen() { clear; }

banner() {
clear
printf "\033[1;36m╔══════════════════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║                        BOXWINE ULTRA INSTALLER               ║\033[0m\n"
printf "\033[1;36m║                Advanced Emulator Environment Setup           ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════════════════════════════╝\033[0m\n\n"
}

line() {
printf "\033[1;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n"
}

spinner() {
pid=$!
spin='-\|/'
i=0
while kill -0 $pid 2>/dev/null; do
i=$(( (i+1) %4 ))
printf "\r\033[1;33m[%c] Processing...\033[0m" "${spin:$i:1}"
sleep .1
done
printf "\r\033[1;32m✔ Done\033[0m\n"
}

install_one() {
NAME="$1"
shift
printf "\033[1;33m→ %s\033[0m\n" "$NAME"
apt install -y "$@" >/dev/null 2>&1 &
spinner
}

check_internet() {
curl -s https://google.com >/dev/null || {
printf "\033[1;31mNo internet connection\033[0m\n"
exit 1
}
}

check_space() {
REQ=3500
FREE=$(df -m "$PREFIX" | tail -1 | awk '{print $4}')
if [ "$FREE" -lt "$REQ" ]; then
printf "\033[1;31mNot enough space: %s MB free (need %s MB)\033[0m\n" "$FREE" "$REQ"
exit 1
fi
}

arch_detect() {
ARCH=$(uname -m)
printf "\033[1;36mDetected architecture: %s\033[0m\n" "$ARCH"
sleep 1
}

download_extract() {
URL="$1"
FILE=$(basename "$URL")
curl -L "$URL" -o "$TMP/$FILE" >/dev/null 2>&1 &
spinner
tar -xJf "$TMP/$FILE" -C "$ROOT"
rm -f "$TMP/$FILE"
}

create_cmd() {
cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export BOXWINE_ROOT="$ROOT"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF
chmod +x "$BIN"
}

banner
line
printf "\033[1;33mPreparing Termux storage...\033[0m\n"
termux-setup-storage & sleep 4 >/dev/null 2>&1
while [ ! -d "$HOME/storage" ]; do sleep 1; done

line
printf "\033[1;33mUpdating system...\033[0m\n"
apt update >/dev/null 2>&1 &
spinner
apt upgrade -y >/dev/null 2>&1 &
spinner

check_internet
check_space
arch_detect

line
printf "\033[1;36mInstalling Core Tools\033[0m\n"
install_one "wget" wget
install_one "curl" curl
install_one "git" git
install_one "nano" nano
install_one "htop" htop
install_one "dialog" dialog
install_one "tar" tar
install_one "xz-utils" xz-utils
install_one "unzip" unzip
install_one "p7zip" p7zip
install_one "proot" proot
install_one "tsu" tsu
install_one "file" file
install_one "which" which

line
printf "\033[1;36mInstalling Graphics Stack\033[0m\n"
install_one "mesa" mesa
install_one "mesa-zink" mesa-zink
install_one "vulkan-loader" vulkan-loader
install_one "vulkan-tools" vulkan-tools
install_one "mesa-vulkan-icd-freedreno" mesa-vulkan-icd-freedreno
install_one "virglrenderer-android" virglrenderer-android
install_one "virglrenderer-mesa-zink" virglrenderer-mesa-zink
install_one "libdrm" libdrm

line
printf "\033[1;36mInstalling Display System\033[0m\n"
install_one "termux-x11-nightly" termux-x11-nightly
install_one "xwayland" xwayland
install_one "xorg-xhost" xorg-xhost
install_one "xorg-xrandr" xorg-xrandr
install_one "xorg-xsetroot" xorg-xsetroot

line
printf "\033[1;36mInstalling Audio System\033[0m\n"
install_one "pulseaudio" pulseaudio
install_one "alsa-utils" alsa-utils

line
printf "\033[1;36mInstalling Development Tools\033[0m\n"
install_one "clang" clang
install_one "make" make
install_one "cmake" cmake
install_one "binutils" binutils
install_one "python" python
install_one "python-tkinter" python-tkinter
install_one "hashdeep" hashdeep
install_one "neofetch" neofetch

clear_screen
banner

dialog --menu "Select Prefix Type" 12 60 2 \
1 "glibc-prefix (recommended)" \
2 "ajay-prefix" 2> "$TMP/prefix"

P=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$P" = "1" ]; then
printf "\033[1;33mDownloading glibc rootfs...\033[0m\n"
download_extract "https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz"

dialog --menu "Select Wine Version" 18 70 4 \
1 "Wine 10.19 Staging amd64 wow64" \
2 "Wine 10.19 Staging amd64" \
3 "Wine 10.19 TKG amd64 wow64" \
4 "Wine 10.19 TKG amd64" 2> "$TMP/wine"

W=$(cat "$TMP/wine")
rm -f "$TMP/wine"

case "$W" in
1) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64-wow64.tar.xz" ;;
2) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64.tar.xz" ;;
3) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64-wow64.tar.xz" ;;
4) URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-tkg-amd64.tar.xz" ;;
esac

printf "\033[1;33mDownloading Wine...\033[0m\n"
download_extract "$URL"

else
printf "\033[1;33mDownloading ajay rootfs...\033[0m\n"
download_extract "https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz"
fi

create_cmd

clear_screen
printf "\033[1;36m╔════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║              BOXWINE INSTALLED SUCCESSFULLY   ║\033[0m\n"
printf "\033[1;36m╚════════════════════════════════════════════════╝\033[0m\n\n"
printf "\033[1;33mRun emulator with:\033[0m boxwine\n\n"
