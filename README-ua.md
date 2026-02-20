# 🍷 BoxWine
 
 
⚠️ **СТАТУС ПРОЄКТУ: У РОЗРОБЦІ**
 
BoxWine наразі перебуває в активній фазі розробки. Багато функцій є експериментальними, нестабільними або незавершеними.
 
  
## 📌 About
 
**BoxWine** — це експериментальний проєкт, створений для запуску **застосунків Windows x86/x86_64** на **Android** за допомогою **Termux**.
 
Він поєднує **Wine**, **Box64 / Box86** та багато компонентів Linux і Android в єдине середовище, здатне запускати програмне забезпечення Windows на пристроях ARM.
 
BoxWine — це не окремий емулятор, а **складний стек сумісності**.
  
## 🧩 Core Components
 
BoxWine складається з багатьох компонентів, що працюють разом:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – рівень сумісності Windows
 
- **Box64 / Box86** – трансляція x86/x64 у ARM
 
- **glibc-based environment** – покращена сумісність із Linux
 
- **Termux** – користувацький простір Linux на Android
 
- **Termux-X11** – сервер відображення
 
- **Mesa (Zink / VirGL / Turnip)** – трансляція OpenGL і Vulkan
 
- **Vulkan Loader for Android** – завантажувач Vulkan для Android
 
- **PulseAudio** – підтримка звуку
 
- **Input Bridge** – підтримка сенсорного керування, клавіатури, миші та геймпада

- **Vortek** – оптимізація графічного стеку та сумісності Vulkan

- **MangoHud** – накладка моніторингу продуктивності (FPS, використання GPU/CPU та статистика)
 

  
## 🖥️ Display & Graphics
 
 
- Виведення зображення здійснюється через **Termux-X11**
 
- Підтримуються віконний та повноекранний режими
 
- Апаратне прискорення залежить від пристрою та GPU
 
- Vulkan підтримується на сумісних пристроях
 
- Роздільна здатність визначається автоматично з резервними параметрами
 

  
## 🎮 Controls & Input
 
BoxWine підтримує кілька способів керування:
 
 
- Сенсорне керування
 
- Фізична клавіатура та миша
 
- Зовнішні геймпади
 
- **Input Bridge** для мапінгу дотику на клавіатуру/мишу
 

 
Input Bridge **обов’язковий** для комфортного сенсорного керування.
  
## 📱 Minimum System Requirements
 
 
⚠️ Це **мінімальні системні вимоги**. Рекомендується потужніше обладнання.
 
 
 
- **SoC:** Qualcomm Snapdragon 655 або аналог
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** мінімум 3 GB (рекомендовано 4 GB+)
 
- **Android:** Android 10 або новіше
 
- **GPU:** Adreno з підтримкою Vulkan (рекомендовано)
 
- **Storage:** 6–8 GB вільного місця
 

 
На слабких пристроях можливі збої або дуже низька продуктивність.
  
## 📦 Installation
 
### 1. Встановіть необхідні застосунки - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Відкрийте Termux і виконайте:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. Запустіть BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- Wine можна встановлювати або видаляти через **Manage Packages**
 
- Вибір контейнера Wine доступний у головному меню
 
- Wine Mono, Gecko, DXVK, Turnip і VirGL можна встановити з меню Wine
 

 
### Box86 / Box64 Dynarec
 
 
- Змінні Dynarec можна налаштовувати в меню параметрів
 
- Окремі меню для Box86 і Box64
 

 
### System Settings
 
 
- Зміна локалі Wine
 
- Налаштування DXVK HUD
 
- Регулювання параметрів Turnip
 
- Використовується резервна роздільна здатність, якщо визначення X11 не вдалося
 
- Користувачам Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 слід увімкнути **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- Опціональний **OOM Adjuster** доступний для пристроїв із root
 
- Допомагає запобігти завершенню Termux системою через нестачу пам’яті
 

  
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
 
Щоб видалити BoxWine, використовуйте меню **Backup and Restore**.
  
## ⚠️ Disclaimer
 
BoxWine є **офіційним** проєктом, але **не пов’язаний** із розробниками WineHQ, Box64, Box86 або Termux.
 
Використовуйте на власний ризик.
  
## 📌 Project Status
 
 
- 🚧 Активна розробка
 
- 🧪 Експериментальний проєкт
 
- ❌ Не готовий до використання у продакшені
 

 
Відгуки, тестування та внески вітаються.
  
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