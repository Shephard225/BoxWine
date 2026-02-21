#!/data/data/com.termux/files/usr/bin/bash
set -e

PREFIX="/data/data/com.termux/files/usr"
ROOT="$PREFIX/glibc"
WORK="$HOME/.boxwine"
TMP="$WORK/tmp"
LOG="$WORK/install.log"
BIN="$PREFIX/bin/boxwine"

mkdir -p "$WORK" "$TMP"
exec > >(tee -a "$LOG") 2>&1

clear

# ===== UI FUNCTIONS =====
line() { printf "\033[1;36m──────────────────────────────────────────────────────\033[0m\n"; }
title() {
clear
line
printf "\033[1;36m              BOXWINE ULTRA INSTALLER              \033[0m\n"
line
printf "\n"
}
ok() { printf "\033[1;32m✔ %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m➜ %s\033[0m\n" "$1"; }
fail() { printf "\033[1;31m✖ %s\033[0m\n" "$1"; exit 1; }

title

warn "Preparing storage..."
termux-setup-storage >/dev/null 2>&1 || true
sleep 1
ok "Storage ready"

warn "Checking internet..."
curl -s --head https://github.com >/dev/null || fail "No internet"
ok "Internet OK"

warn "Checking RAM..."
RAM=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
[ "$RAM" -lt 1800 ] && fail "Minimum 2GB RAM required ($RAM MB detected)"
ok "RAM: ${RAM}MB"

warn "Checking disk space..."
FREE=$(df "$PREFIX" | tail -1 | awk '{print int($4/1024)}')
[ "$FREE" -lt 3000 ] && fail "Not enough space (${FREE}MB free)"
ok "Free space: ${FREE}MB"

warn "Updating Termux..."
pkg update -y >/dev/null
pkg upgrade -y >/dev/null
ok "System updated"

warn "Installing required packages..."
pkg install -y curl wget tar dialog xz unzip proot >/dev/null
ok "Packages installed"

# ===== PREFIX SELECT =====
dialog --clear --menu "Select Prefix Type" 12 60 2 \
1 "glibc (recommended)" \
2 "ajay" 2> "$TMP/prefix" || exit 1

P=$(cat "$TMP/prefix")
rm -f "$TMP/prefix"

if [ "$P" = "1" ]; then
  ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-glibc-boxwine.tar.xz"
else
  ROOTFS_URL="https://github.com/Shephard225/BoxWine/releases/download/emu-files/rootfs-ajay-boxwine.tar.xz"
fi

title
warn "Downloading rootfs..."
ROOTFS_FILE="$TMP/rootfs.tar.xz"
curl -L --fail -o "$ROOTFS_FILE" "$ROOTFS_URL" || fail "Download failed"
xz -t "$ROOTFS_FILE" || fail "Archive corrupted"
ok "Rootfs downloaded"

warn "Installing rootfs..."
rm -rf "$ROOT"
mkdir -p "$ROOT"
tar -xJf "$ROOTFS_FILE" -C "$ROOT" || fail "Extraction failed"
rm -f "$ROOTFS_FILE"
ok "Rootfs installed"

# ===== WINE =====
if [ "$P" = "1" ]; then

dialog --clear --menu "Select Wine Version" 15 60 2 \
1 "Wine 10.19 Staging WOW64" \
2 "Wine 10.19 Staging" 2> "$TMP/wine" || exit 1

W=$(cat "$TMP/wine")
rm -f "$TMP/wine"

if [ "$W" = "1" ]; then
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64-wow64.tar.xz"
else
URL="https://github.com/Kron4ek/Wine-Builds/releases/download/10.20/wine-10.19-staging-amd64.tar.xz"
fi

title
warn "Downloading Wine..."
WINE_FILE="$TMP/wine.tar.xz"
curl -L --fail -o "$WINE_FILE" "$URL" || fail "Wine download failed"
xz -t "$WINE_FILE" || fail "Wine archive corrupted"

warn "Installing Wine..."
tar -xJf "$WINE_FILE" -C "$ROOT" --strip-components=1 || fail "Wine extraction failed"
rm -f "$WINE_FILE"
ok "Wine installed"
fi

# ===== FINAL CHECK =====
[ -d "$ROOT/bin" ] || fail "Installation failed"

cat > "$BIN" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
export BOXWINE_ROOT="$ROOT"
export PATH="\$BOXWINE_ROOT/bin:\$BOXWINE_ROOT/usr/bin:\$PATH"
exec "\$BOXWINE_ROOT/bin/boxwine" "\$@"
EOF

chmod +x "$BIN"

title
printf "\033[1;32mBOXWINE INSTALLED SUCCESSFULLY\033[0m\n\n"
printf "\033[1;33mRun with:\033[0m boxwine\n\n"