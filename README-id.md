# 🍷 BoxWine
 
 
⚠️ **STATUS PROYEK: DALAM PENGEMBANGAN**
 
BoxWine saat ini berada dalam tahap pengembangan aktif. Banyak fitur masih bersifat eksperimental, tidak stabil, atau belum selesai.
 
  
## 📌 About
 
**BoxWine** adalah proyek eksperimental yang dirancang untuk menjalankan **aplikasi Windows x86/x86_64** di **Android** menggunakan **Termux**.
 
Proyek ini menggabungkan **Wine**, **Box64 / Box86**, serta berbagai komponen Linux dan Android ke dalam satu lingkungan yang mampu menjalankan perangkat lunak Windows pada perangkat ARM.
 
BoxWine bukan satu emulator tunggal — melainkan **tumpukan kompatibilitas yang kompleks**.
  
## 🧩 Core Components
 
BoxWine dibangun dari berbagai komponen yang bekerja bersama:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – lapisan kompatibilitas Windows
 
- **Box64 / Box86** – translasi x86/x64 ke ARM
 
- **glibc-based environment** – kompatibilitas Linux yang ditingkatkan
 
- **Termux** – ruang pengguna Linux di Android
 
- **Termux-X11** – server tampilan
 
- **Mesa (Zink / VirGL / Turnip)** – translasi OpenGL dan Vulkan
 
- **Vulkan Loader for Android** – loader Vulkan untuk Android
 
- **PulseAudio** – dukungan audio
 
- **Input Bridge** – input sentuh, keyboard, mouse, dan gamepad

- **Vortek** – optimasi stack grafis dan kompatibilitas Vulkan

- **MangoHud** – overlay pemantauan performa (FPS, penggunaan GPU/CPU, dan statistik)
 

  
## 🖥️ Display & Graphics
 
 
- Output tampilan ditangani melalui **Termux-X11**
 
- Mendukung mode jendela dan layar penuh
 
- Akselerasi perangkat keras bergantung pada perangkat dan GPU
 
- Vulkan didukung pada perangkat yang kompatibel
 
- Resolusi dideteksi secara otomatis dengan opsi cadangan
 

  
## 🎮 Controls & Input
 
BoxWine mendukung berbagai metode input:
 
 
- Kontrol layar sentuh
 
- Keyboard dan mouse fisik
 
- Gamepad eksternal
 
- **Input Bridge** untuk pemetaan sentuhan ke keyboard/mouse
 

 
Input Bridge **wajib digunakan** untuk kontrol sentuh yang nyaman.
  
## 📱 Minimum System Requirements
 
 
⚠️ Ini adalah **persyaratan minimum**. Perangkat keras yang lebih kuat sangat disarankan.
 
 
 
- **SoC:** Qualcomm Snapdragon 655 atau setara
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** minimal 3 GB (disarankan 4 GB+)
 
- **Android:** Android 10 atau lebih baru
 
- **GPU:** Adreno dengan dukungan Vulkan (disarankan)
 
- **Storage:** 6–8 GB ruang kosong
 

 
Perangkat kelas rendah mungkin mengalami crash atau performa yang sangat rendah.
  
## 📦 Installation
 
### 1. Instal aplikasi yang diperlukan - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Buka Termux dan jalankan:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. Jalankan BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- Wine dapat diinstal atau dihapus melalui **Manage Packages**
 
- Pemilihan container Wine tersedia di menu utama
 
- Wine Mono, Gecko, DXVK, Turnip, dan VirGL dapat diinstal dari menu Wine
 

 
### Box86 / Box64 Dynarec
 
 
- Variabel Dynarec dapat dikonfigurasi melalui menu pengaturan
 
- Menu terpisah untuk Box86 dan Box64
 

 
### System Settings
 
 
- Mengubah locale Wine
 
- Mengonfigurasi DXVK HUD
 
- Menyesuaikan pengaturan Turnip
 
- Resolusi cadangan digunakan jika deteksi resolusi X11 gagal
 
- Pengguna Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 harus mengaktifkan **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- **OOM Adjuster** opsional tersedia untuk perangkat yang sudah root
 
- Membantu mencegah Termux dihentikan oleh sistem karena kekurangan memori
 

  
## 🖥️ Termux-X11 Recommended Settings
 
 
- Display resolution mode: **Exact**
 
- Display resolution: **1280x720**
 
- Reseed screen while keyboard is open: **OFF**
 
- Fullscreen on device display: **ON**
 
- Force landscape orientation: **ON**
 
- Hide display cutout: **ON**
 
- Show additional keyboard: **OFF**
 
- Prefer scancodes when possible: **ON**
 

  
## ❌ Uninstall
 
Untuk menghapus BoxWine, gunakan menu **Backup and Restore**.
  
## ⚠️ Disclaimer
 
BoxWine adalah proyek **resmi**, namun **tidak berafiliasi** dengan pengembang WineHQ, Box64, Box86, atau Termux.
 
Gunakan dengan risiko Anda sendiri.
  
## 📌 Project Status
 
 
- 🚧 Pengembangan aktif
 
- 🧪 Proyek eksperimental
 
- ❌ Belum siap untuk produksi
 

 
Umpan balik, pengujian, dan kontribusi sangat diterima.
  
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
 
[Wine](https://wiki.winehq.org/Licensing)
 
[wine-ge-custom](https://github.com/GloriousEggroll/wine-ge-custom)
 
[Mesa](https://docs.mesa3d.org/license.html)
 
[mesa-zink-11.06.22](https://github.com/alexvorxx/mesa-zink-11.06.22)
 
[Mesa-VirGL](https://github.com/alexvorxx/Mesa-VirGL)