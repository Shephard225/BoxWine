#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PREFIX="/data/data/com.termux/files/usr"
ROOT="$PREFIX/glibc"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"
LOG="$WORK/install.log"
BIN="$PREFIX/bin/boxwine"

mkdir -p "$WORK" "$TMP"
exec > >(tee -a "$LOG") 2>&1

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

download_tar() {
curl -L --fail --progress-bar -o "$2" "$1"
[ -f "$2" ] || fail "Download failed"
}

download_xz() {
curl -L --fail --progress-bar -o "$2" "$1"
[ -f "$2" ] || fail "Download failed"
}

title
export DEBIAN_FRONTEND=noninteractive

warn "Preparing storage..."
termux-setup-storage || true
ok "Storage ready"

warn "Checking RAM..."
RAM=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
[ "$RAM" -lt 1800 ] && fail "Minimum 2GB RAM required"
ok "RAM: ${RAM}MB"

warn "Checking disk space..."
FREE=$(df "$PREFIX" | awk 'END {print int($4/1024)}')
[ "$FREE" -lt 3000 ] && fail "Not enough disk space"
ok "Free space: ${FREE}MB"

line

warn "Updating repositories..."
pkg update -y
ok "Repositories updated"

warn "Upgrading system..."
pkg upgrade -y
ok "System upgraded"

line

warn "Installing base tools..."
pkg install -y \
curl wget tar dialog xz-utils unzip proot file which sed grep coreutils \
findutils diffutils gawk bash-completion util-linux
ok "Base tools installed"

warn "Installing development stack..."
pkg install -y \
git clang make cmake ninja pkg-config \
binutils patchelf autoconf automake libtool
ok "Development stack installed"

warn "Installing graphics stack..."
pkg install -y \
mesa mesa-demos vulkan-loader vulkan-tools \
libx11 libxext libxrender libxrandr libxfixes \
libxi libxcursor libxinerama libxxf86vm \
libxkbcommon libxdamage libxcomposite \
fontconfig freetype harfbuzz
ok "Graphics stack installed"

warn "Installing audio stack..."
pkg install -y \
pulseaudio alsa-lib alsa-utils openal-soft
ok "Audio stack installed"

warn "Installing network stack..."
pkg install -y \
openssl ca-certificates libcurl nghttp2
ok "Network stack installed"

warn "Installing compatibility libraries..."
pkg install -y \
glibc-repo glibc-runner \
ncurses libandroid-glob \
zlib bzip2 xz \
libpng libjpeg-turbo \
libtiff libwebp
ok "Compatibility libraries installed"

warn "Installing extra utilities..."
pkg install -y \
htop nano vim tmux zip p7zip
ok "Extra utilities installed"

line

sleep 2
clear
title

warn "Checking glibc environment..."
if [ -d "$ROOT" ]; then
ok "glibc directory already exists"
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
download_tar "$ROOTFS_URL" "$ROOTFS_FILE"
ok "Rootfs downloaded"

warn "Installing rootfs..."
rm -rf "$ROOT"
mkdir -p "$ROOT"
tar -xf "$ROOTFS_FILE" -C "$ROOT"
rm -f "$ROOTFS_FILE"
ok "Rootfs installed"

if [ "$P" = "1" ]; then

dialog --clear --menu "Select Wine Version" 15 60 2 \
1 "Wine 10.20 Staging WOW64" \
2 "Wine 10.20 Staging" 2> "$TMP/wine" || exit 1

W=$(cat "$TMP/wine")
rm -f "$TMP/wine"

if [ "$W" = "1" ]; then
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.20-staging-amd64-wow64.tar.xz"
else
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.20-staging-amd64.tar.xz"
fi

title
warn "Downloading Wine..."
WINE_FILE="$TMP/wine.tar.xz"
download_xz "$URL" "$WINE_FILE"
ok "Wine downloaded"

warn "Installing Wine..."
tar -xJf "$WINE_FILE" -C "$ROOT" --strip-components=1
rm -f "$WINE_FILE"
ok "Wine installed"

fi

warn "Creating launcher..."
cat > "$BIN" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
ROOT="/data/data/com.termux/files/usr/glibc"
exec "$ROOT/bin/wine" "$@"
EOF

chmod +x "$BIN"
ok "Launcher created"

line
printf "\033[1;32mBOXWINE INSTALLED SUCCESSFULLY\033[0m\n\n"
printf "\033[1;33mRun with:\033[0m boxwine\n\n"