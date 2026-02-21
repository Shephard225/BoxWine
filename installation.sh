#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

PREFIX="/data/data/com.termux/files/usr"
ROOT="$PREFIX/glibc"
BIN="$PREFIX/bin/boxwine"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"
LOG="$WORK/install.log"

mkdir -p "$WORK" "$TMP"
exec > >(tee -a "$LOG") 2>&1

clear
printf "\033[1;36m╔══════════════════════════════════════════════════════╗\033[0m\n"
printf "\033[1;36m║                BOXWINE ULTRA SAFE INSTALLER         ║\033[0m\n"
printf "\033[1;36m╚══════════════════════════════════════════════════════╝\033[0m\n\n"

printf "\033[1;33m→ Preparing storage...\033[0m\n"
termux-setup-storage >/dev/null 2>&1 || true
sleep 2
echo "Storage ready"

printf "\033[1;33m→ Checking internet...\033[0m\n"
curl -s --head https://github.com >/dev/null || { echo "No internet"; exit 1; }
echo "Internet OK"

printf "\033[1;33m→ Checking RAM...\033[0m\n"
RAM=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
echo "RAM: ${RAM}MB"
[ "$RAM" -lt 1800 ] && { echo "Minimum 2GB RAM required"; exit 1; }

printf "\033[1;33m→ Checking disk space...\033[0m\n"
FREE=$(df "$PREFIX" | awk 'NR==2 {print int($4/1024)}')
echo "Free space: ${FREE}MB"
[ "$FREE" -lt 3000 ] && { echo "Not enough space"; exit 1; }

printf "\033[1;33m→ Updating Termux...\033[0m\n"
pkg update -y >/dev/null 2>&1
pkg upgrade -y >/dev/null 2>&1
echo "System updated"

install() {
  printf "   Installing %s...\n" "$1"
  pkg install -y "$1" >/dev/null 2>&1 || true
}

printf "\033[1;33m→ Installing dependencies...\033[0m\n"

for pkgname in \
wget curl git nano dialog tar unzip p7zip proot \
file which mesa vulkan-loader vulkan-tools \
pulseaudio alsa-utils clang make cmake binutils python
do
  install "$pkgname"
done

echo "Dependencies installed"

clear
dialog --menu "Select Prefix Type" 12 60 2 \
1 "glibc-prefix (recommended)" \
2 "ajay-prefix" 2> "$TMP/prefix" || exit 1

P=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$P" = "1" ]; then
  ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz"
else
  ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz"
fi

ROOTFS_FILE="$TMP/rootfs.tar.xz"

printf "\033[1;33m→ Downloading rootfs...\033[0m\n"
curl -L --fail -o "$ROOTFS_FILE" "$ROOTFS_URL" || { echo "Download failed"; exit 1; }

[ -s "$ROOTFS_FILE" ] || { echo "Archive empty"; exit 1; }
xz -t "$ROOTFS_FILE" || { echo "Archive corrupted"; exit 1; }

rm -rf "$ROOT"
mkdir -p "$ROOT"
tar -xJf "$ROOTFS_FILE" -C "$ROOT" || { echo "Extraction failed"; exit 1; }
rm -f "$ROOTFS_FILE"

[ -d "$ROOT/bin" ] || { echo "Installation failed"; exit 1; }

cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export BOXWINE_ROOT="$ROOT"
export PATH="\$BOXWINE_ROOT/bin:\$BOXWINE_ROOT/usr/bin:\$PATH"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF

chmod +x "$BIN"

clear
printf "\033[1;32mBOXWINE INSTALLED SUCCESSFULLY\033[0m\n\n"
printf "\033[1;33mRun with:\033[0m boxwine\n\n"