#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PREFIX="/data/data/com.termux/files/usr"
ROOT="$PREFIX/glibc"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"
BIN="$PREFIX/bin/boxwine"

mkdir -p "$WORK" "$TMP"

line() { printf "\033[1;36m══════════════════════════════════════════════════════\033[0m\n"; }
title() {
clear
line
printf "\033[1;36m                BOXWINE INSTALLER                \033[0m\n"
line
printf "\n"
}
ok()   { printf "\033[1;32m✔ %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m➜ %s\033[0m\n" "$1"; }
fail() { printf "\033[1;31m✖ %s\033[0m\n" "$1"; exit 1; }

install_group() {
GROUP_NAME="$1"
shift
warn "Installing $GROUP_NAME..."
for pkg in "$@"; do
    pkg install -y "$pkg"
done
ok "$GROUP_NAME installed"
}

download() {
curl -L --fail --progress-bar -o "$2" "$1"
[ -f "$2" ] || fail "Download failed"
}

title
export DEBIAN_FRONTEND=noninteractive

warn "Requesting storage permission..."
termux-setup-storage
sleep 4
while [ ! -d "$HOME/storage/shared" ]; do
warn "Waiting for storage permission..."
sleep 3
done
ok "Storage ready"

warn "Updating system..."
apt-get clean
apt-get update -y
apt-get -y --with-new-pkgs -o Dpkg::Options::="--force-confdef" upgrade
ok "System updated"

line

install_group "Repositories" \
x11-repo root-repo glibc-repo

install_group "Base system" \
bash which file coreutils findutils grep sed gawk util-linux procps less tree \
curl wget aria2 git openssh rsync \
zip unzip p7zip tar gzip bzip2 xz-utils

install_group "Development stack" \
clang make cmake ninja pkg-config \
binutils lld autoconf automake libtool m4 \
patchelf gdb strace

install_group "Libraries" \
openssl ca-certificates libcurl libnghttp2 \
zlib bzip2 xz-utils \
libpng libjpeg-turbo libtiff libwebp \
sqlite libffi libxml2 libxslt readline ncurses

install_group "Audio stack" \
pulseaudio alsa-lib alsa-utils openal-soft

install_group "Minimal graphics stack" \
mesa mesa-demos xwayland xorg-xrandr libx11 libxext libxrender

install_group "Extra tools" \
hashdeep tsu dos2unix inetutils net-tools dialog

line
sleep 2
clear
title

warn "Checking glibc..."
if [ -d "$ROOT" ]; then
ok "glibc directory detected"
else
warn "glibc not installed yet"
fi

sleep 2
line

dialog --clear --menu "Select Prefix Type" 12 60 2 \
1 "glibc (recommended)" \
2 "ajay" 2> "$TMP/prefix" || exit 1

P=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$P" = "1" ]; then
ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar"
else
ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar"
fi

title
warn "Downloading rootfs..."
ROOTFS_FILE="$TMP/rootfs.tar"
download "$ROOTFS_URL" "$ROOTFS_FILE"
ok "Rootfs downloaded"

warn "Installing rootfs..."
rm -rf "$ROOT"
mkdir -p "$ROOT"
tar -xf "$ROOTFS_FILE" -C "$ROOT"
rm -f "$ROOTFS_FILE"
ok "Rootfs installed"

if [ "$P" = "1" ]; then

dialog --clear --menu "Select Wine Version" 15 60 2 \
1 "Wine 9.3 Vanilla WOW64" \
2 "Wine-ge-custom 8-25 (Box86)" 2> "$TMP/wine" || exit 1

W=$(cat "$TMP/wine")
rm -f "$TMP/wine"

if [ "$W" = "1" ]; then
URL="https://github.com/Shephard225/BoxWine/releases/download/emu-wine/wine-9.3-vanilla-wow64.tar.xz"
else
URL="https://github.com/Shephard225/BoxWine/releases/download/emu-wine/wine-ge-custom-8-25.tar.xz"
fi

title
warn "Downloading Wine..."
WINE_FILE="$TMP/wine.tar.xz"
download "$URL" "$WINE_FILE"
ok "Wine downloaded"

warn "Installing Wine..."
tar -xJf "$WINE_FILE" -C "$ROOT" --strip-components=1
rm -f "$WINE_FILE"
ok "Wine installed"

fi

warn "Creating launcher..."

cat > "$BIN" << EOF
#!/data/data/com.termux/files/usr/bin/bash

PREFIX="/data/data/com.termux/files/usr"
ROOT="\$PREFIX/glibc"

export BOX64_PATH="\$ROOT/bin"
export BOX64_LD_LIBRARY_PATH="\$ROOT/lib:\$ROOT/lib64"
export BOX64_DYNAREC=1
export BOX64_DYNAREC_BIGBLOCK=1
export BOX64_MAXCPU=8

exec "\$ROOT/bin/box64" "\$ROOT/bin/wine" "\$@"
EOF

chmod +x "$BIN"
ok "Launcher created"