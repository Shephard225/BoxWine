#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PREFIX="/data/data/com.termux/files/usr"
PATH="$PREFIX/bin:$PATH"
ROOT="$PREFIX/glibc"
BIN="$PREFIX/bin/boxwine"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"
LOG="$WORK/install.log"

mkdir -p "$WORK" "$TMP" "$ROOT"
exec > >(tee -a "$LOG") 2>&1

clear
printf "\033[1;36m╔══════════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║                BOXWINE ULTRA SAFE INSTALLER         ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════════════════════╝\033[0m\n\n"

printf "\033[1;33mPreparing Termux storage...\033[0m\n"
termux-setup-storage & sleep 4 >/dev/null 2>&1
while [ ! -d "$HOME/storage" ]; do sleep 1; done

printf "\033[1;33mChecking internet...\033[0m\n"
curl -s --head https://github.com >/dev/null || { echo "No internet"; exit 1; }

RAM=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024)}')
if [ "$RAM" -lt 1800 ]; then
echo "Minimum 2GB RAM required ($RAM MB detected)"
exit 1
fi

FREE=$(df -m "$PREFIX" | tail -1 | awk '{print $4}')
if [ "$FREE" -lt 3000 ]; then
echo "Not enough space ($FREE MB free)"
exit 1
fi

printf "\033[1;33mUpdating system...\033[0m\n"
apt update -y >/dev/null 2>&1
apt upgrade -y >/dev/null 2>&1

install() {
printf "\033[1;34m→ Installing %s\033[0m\n" "$1"
apt install -y "$1" >/dev/null 2>&1
}

install wget
install curl
install git
install nano
install htop
install dialog
install tar
install xz-utils
install unzip
install p7zip
install proot
install tsu
install file
install which
install mesa
install mesa-zink
install vulkan-loader
install vulkan-tools
install mesa-vulkan-icd-freedreno
install virglrenderer-android
install virglrenderer-mesa-zink
install libdrm
install termux-x11-nightly
install xwayland
install xorg-xhost
install xorg-xrandr
install xorg-xsetroot
install pulseaudio
install alsa-utils
install clang
install make
install cmake
install binutils
install python
install python-tkinter
install hashdeep
install neofetch

retry_download() {
URL="$1"
OUT="$2"
for i in 1 2 3; do
curl -L --fail -o "$OUT" "$URL" && return 0
sleep 2
done
return 1
}

clear
dialog --menu "Select Prefix Type" 12 60 2 \
1 "glibc-prefix (recommended)" \
2 "ajay-prefix" 2> "$TMP/prefix"

P=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$P" = "1" ]; then
ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz"
else
ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz"
fi

ROOTFS_FILE="$TMP/rootfs.tar.xz"

printf "\033[1;33mDownloading rootfs...\033[0m\n"
retry_download "$ROOTFS_URL" "$ROOTFS_FILE" || { echo "Download failed"; exit 1; }

[ -s "$ROOTFS_FILE" ] || exit 1
xz -t "$ROOTFS_FILE" || { echo "Archive corrupted"; exit 1; }

rm -rf "$ROOT"
mkdir -p "$ROOT"

tar -xJf "$ROOTFS_FILE" -C "$ROOT" --preserve-permissions --same-owner || { rm -rf "$ROOT"; exit 1; }
rm -f "$ROOTFS_FILE"

if [ "$P" = "1" ]; then
dialog --menu "Select Wine Version" 18 70 2 \
1 "Wine 10.19 Staging amd64 wow64" \
2 "Wine 10.19 Staging amd64" 2> "$TMP/wine"

W=$(cat "$TMP/wine")
rm -f "$TMP/wine"

if [ "$W" = "1" ]; then
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64-wow64.tar.xz"
else
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64.tar.xz"
fi

WINE_FILE="$TMP/wine.tar.xz"

printf "\033[1;33mDownloading Wine...\033[0m\n"
retry_download "$URL" "$WINE_FILE" || exit 1
[ -s "$WINE_FILE" ] || exit 1
xz -t "$WINE_FILE" || exit 1

tar -xJf "$WINE_FILE" -C "$ROOT" --strip-components=1 || { rm -f "$WINE_FILE"; exit 1; }
rm -f "$WINE_FILE"
fi

if [ ! -d "$ROOT" ]; then
echo "Installation failed"
exit 1
fi

cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export BOXWINE_ROOT="$ROOT"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF

chmod +x "$BIN"

clear
printf "\033[1;32mBOXWINE INSTALLED SUCCESSFULLY\033[0m\n\n"
printf "\033[1;33mRun with:\033[0m boxwine\n\n"
