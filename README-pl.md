# 🍷 BoxWine
 
 
⚠️ **STATUS PROJEKTU: W TRAKCIE ROZWOJU**
 
BoxWine jest obecnie w aktywnej fazie rozwoju. Wiele funkcji jest eksperymentalnych, niestabilnych lub niedokończonych.
 
  
## 📌 About
 
**BoxWine** to eksperymentalny projekt zaprojektowany do uruchamiania **aplikacji Windows x86/x86_64** na **Androidzie** przy użyciu **Termux**.
 
Łączy **Wine**, **Box64 / Box86** oraz wiele komponentów Linuxa i Androida w jedno środowisko zdolne do uruchamiania oprogramowania Windows na urządzeniach ARM.
 
BoxWine nie jest pojedynczym emulatorem — to **złożony stos kompatybilności**.
  
## 🧩 Core Components
 
BoxWine składa się z wielu różnych komponentów współpracujących ze sobą:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – warstwa kompatybilności Windows
 
- **Box64 / Box86** – translacja x86/x64 na ARM
 
- **glibc-based environment** – ulepszona kompatybilność z Linuxem
 
- **Termux** – przestrzeń użytkownika Linux na Androidzie
 
- **Termux-X11** – serwer wyświetlania
 
- **Mesa (Zink / VirGL / Turnip)** – translacja OpenGL i Vulkan
 
- **Vulkan Loader for Android** – loader Vulkan dla Androida
 
- **PulseAudio** – obsługa dźwięku
 
- **Input Bridge** – obsługa dotyku, klawiatury, myszy i gamepada

- **Vortek** – optymalizacja stosu graficznego i kompatybilności Vulkan

- **MangoHud** – nakładka monitorowania wydajności (FPS, użycie GPU/CPU i statystyki)
 

  
## 🖥️ Display & Graphics
 
 
- Wyjście obrazu obsługiwane jest przez **Termux-X11**
 
- Obsługiwane są tryby okienkowy i pełnoekranowy
 
- Akceleracja sprzętowa zależy od urządzenia i GPU
 
- Vulkan jest wspierany na kompatybilnych urządzeniach
 
- Rozdzielczość jest wykrywana automatycznie z opcjami zapasowymi
 

  
## 🎮 Controls & Input
 
BoxWine obsługuje wiele metod sterowania:
 
 
- Sterowanie dotykowe
 
- Fizyczna klawiatura i mysz
 
- Zewnętrzne gamepady
 
- **Input Bridge** do mapowania dotyku na klawiaturę/mysz
 

 
Input Bridge jest **wymagany** dla komfortowego sterowania dotykowego.
  
## 📱 Minimum System Requirements
 
 
⚠️ To są **minimalne wymagania**. Zalecany jest mocniejszy sprzęt.
 
 
 
- **SoC:** Qualcomm Snapdragon 655 lub odpowiednik
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** minimum 3 GB (zalecane 4 GB+)
 
- **Android:** Android 10 lub nowszy
 
- **GPU:** Adreno z obsługą Vulkan (zalecane)
 
- **Storage:** 6–8 GB wolnego miejsca
 

 
Na słabszych urządzeniach mogą występować awarie lub bardzo niska wydajność.
  
## 📦 Installation
 
### 1. Zainstaluj wymagane aplikacje - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Otwórz Termux i uruchom:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. Uruchom BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- Wine można instalować lub usuwać przez **Manage Packages**
 
- Wybór kontenera Wine dostępny jest w głównym menu
 
- Wine Mono, Gecko, DXVK, Turnip i VirGL można zainstalować z menu Wine
 

 
### Box86 / Box64 Dynarec
 
 
- Zmienne Dynarec można konfigurować w menu ustawień
 
- Oddzielne menu dla Box86 i Box64
 

 
### System Settings
 
 
- Zmiana lokalizacji Wine
 
- Konfiguracja DXVK HUD
 
- Dostosowanie ustawień Turnip
 
- Używana jest zapasowa rozdzielczość, jeśli wykrywanie X11 nie powiedzie się
 
- Użytkownicy Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 powinni włączyć **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- Opcjonalny **OOM Adjuster** dostępny dla urządzeń z rootem
 
- Pomaga zapobiec zamykaniu Termux przez system przy niskiej ilości pamięci
 

  
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
 
Aby odinstalować BoxWine, użyj menu **Backup and Restore**.
  
## ⚠️ Disclaimer
 
BoxWine jest **oficjalnym** projektem. Nie jest **powiązany** z twórcami WineHQ, Box64, Box86 ani Termux.
 
Używasz na własne ryzyko.
  
## 📌 Project Status
 
 
- 🚧 Aktywny rozwój
 
- 🧪 Projekt eksperymentalny
 
- ❌ Nie jest gotowy do użytku produkcyjnego
 

 
Opinie, testy i wkład w rozwój są mile widziane.
  
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