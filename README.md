
# 🍷 BoxWine

<p align="center">

🌐 <b>Language / Язык</b>

<a href="README.md">🇺🇸 English</a> |
<a href="README-ru.md">🇷🇺 Русский</a> |
<a href="README-pt_BR.md">🇧🇷 Português (Brasil)</a> |
<a href="README-chinese.md">🇨🇳 中文</a> |
<a href="README-ar.md">🇸🇦 العربية</a> |
<a href="README-id.md">🇮🇩 Bahasa Indonesia</a> |
<a href="README-hi.md">🇮🇳 हिन्दी</a>

</p>

---

> ⚠️ **PROJECT STATUS: UNDER DEVELOPMENT**
>
> BoxWine is currently in active development.  
> Many features are experimental, unstable, or unfinished.

---

## 📌 About

**BoxWine** is an experimental project designed to run **Windows x86/x86_64 applications** on **Android** using **Termux**.

It combines **Wine**, **Box64 / Box86**, and multiple Linux and Android components into a single environment capable of running Windows software on ARM devices.

BoxWine is not a single emulator — it is a **complex compatibility stack**.

---

## 🧩 Core Components

BoxWine is built from many different components working together:

- **Wine (WoW64 / Wine64 / Wine32)** – Windows compatibility layer
- **Box64 / Box86** – x86/x64 to ARM translation
- **glibc-based environment** – improved Linux compatibility
- **Termux** – Linux userspace on Android
- **Termux-X11** – display server
- **Mesa (Zink / VirGL / Turnip)** – OpenGL & Vulkan translation
- **Vulkan Loader for Android**
- **PulseAudio** – sound support
- **Input Bridge** – touch, keyboard, mouse, and gamepad input

---

## 🖥️ Display & Graphics

- Display output is handled via **Termux-X11**
- Supports windowed and fullscreen modes
- Hardware acceleration depends on device and GPU
- Vulkan is supported on compatible devices
- Resolution is automatically detected, with fallback options

---

## 🎮 Controls & Input

BoxWine supports multiple input methods:

- Touchscreen controls
- Physical keyboard & mouse
- External gamepads
- **Input Bridge** for touch-to-keyboard/mouse mapping

Input Bridge is **required** for comfortable touch controls.

---

## 📱 Minimum System Requirements

> ⚠️ These are **minimum requirements**. Better hardware is strongly recommended.

- **SoC:** Qualcomm Snapdragon 655 or equivalent
- **CPU:** ARM64 (AArch64)
- **RAM:** 3 GB minimum (4 GB+ recommended)
- **Android:** Android 10 or newer
- **GPU:** Adreno with Vulkan support (recommended)
- **Storage:** 6–8 GB free space

Low-end devices may experience crashes or very poor performance.

---

## 📦 Installation

### 1. Install required applications - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
### 2. Open Termux and run:

```bash
curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1
chmod +x ~/boxwine-install.sh
bash ~/boxwine-install.sh
```

### 3. Start BoxWine

```bash
boxwine
```

---

## ⚙️ Configuration

### Wine
- Wine can be installed or removed via **Manage Packages**
- Wine container selection is available in the main menu
- Wine Mono, Gecko, DXVK, Turnip, and VirGL can be installed from Wine menu

### Box86 / Box64 Dynarec
- Dynarec variables can be configured via settings menu
- Separate menus for Box86 and Box64

### System Settings
- Change Wine locale
- Configure DXVK HUD
- Adjust Turnip settings
- Fallback resolution is used if X11 resolution detection fails
- Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 users should enable **A7xx flickering fix (TU_DEBUG)**

### Root Settings
- Optional **OOM Adjuster** available for rooted devices
- Helps prevent Termux from being killed by low memory killer

---

## 🖥️ Termux-X11 Recommended Settings

- Display resolution mode: **Exact**
- Display resolution: **1280x720**
- Reseed screen while keyboard is open: **OFF**
- Fullscreen on device display: **ON**
- Force landscape orientation: **ON**
- Hide display cutout: **ON**
- Show additional keyboard: **OFF**
- Prefer scancodes when possible: **ON**

---

## ❌ Uninstall

To uninstall BoxWine, use the **Backup and Restore** menu.

---

## ⚠️ Disclaimer

BoxWine is an **official** project.  
It is **not affiliated** with WineHQ, Box64, Box86, or Termux developers.

Use at your own risk.

---

## 📌 Project Status

- 🚧 Active development
- 🧪 Experimental
- ❌ Not production-ready

Feedback, testing, and contributions are welcome.

---

## ❤️ Credits

[glibc-packages](https://github.com/termux-pacman/glibc-packages)

[Box64](https://github.com/ptitSeb/box64)

[Box86](https://github.com/ptitSeb/box86)

[DXVK](https://github.com/doitsujin/dxvk)

[DXVK-ASYNC](https://github.com/Sporif/dxvk-async)

[DXVK-GPLASYNC](https://gitlab.com/Ph42oN/dxvk-gplasync)

[VKD3D](https://github.com/lutris/vkd3d)

[D8VK](https://github.com/AlpyneDreams/d8vk)

[Termux-app](https://github.com/termux/termux-app)

[Termux-X11](https://github.com/termux/termux-x11)

[Wine](https://github.com/Kron4ek/Wine-builds)

[Turnip-driver](https://github.com/K11MCH1/AdrenoToolsDriver)

[Mesa](https://docs.mesa3d.org/license.html)






