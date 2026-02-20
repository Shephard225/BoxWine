# 🍷 BoxWine
 
 
⚠️ **СТАТУС ПРОЕКТА: В РАЗРАБОТКЕ**
 
BoxWine в настоящее время находится в активной разработке. Многие функции являются экспериментальными, нестабильными или незавершёнными.
 
  
## 📌 About
 
**BoxWine** — это экспериментальный проект, предназначенный для запуска **Windows x86/x86_64 приложений** на **Android** с использованием **Termux**.
 
Он объединяет **Wine**, **Box64 / Box86** и множество компонентов Linux и Android в единую среду, способную запускать программное обеспечение Windows на ARM-устройствах.
 
BoxWine — это не один эмулятор — это **сложный стек совместимости**.
  
## 🧩 Core Components
 
BoxWine построен из множества различных компонентов, работающих совместно:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – слой совместимости Windows
 
- **Box64 / Box86** – трансляция x86/x64 в ARM
 
- **glibc-based environment** – улучшенная совместимость с Linux
 
- **Termux** – пользовательское Linux-пространство на Android
 
- **Termux-X11** – сервер отображения
 
- **Mesa (Zink / VirGL / Turnip)** – трансляция OpenGL и Vulkan
 
- **Vulkan Loader for Android** – загрузчик Vulkan для Android
 
- **PulseAudio** – поддержка звука
 
- **Input Bridge** – ввод с сенсора, клавиатуры, мыши и геймпада

- **Vortek** – оптимизация графического стека и совместимости Vulkan

- **MangoHud** – оверлей мониторинга производительности (FPS, нагрузка GPU/CPU и статистика)
 

  
## 🖥️ Display & Graphics
 
 
- Вывод изображения осуществляется через **Termux-X11**
 
- Поддерживаются оконный и полноэкранный режимы
 
- Аппаратное ускорение зависит от устройства и GPU
 
- Vulkan поддерживается на совместимых устройствах
 
- Разрешение определяется автоматически с резервными вариантами
 

  
## 🎮 Controls & Input
 
BoxWine поддерживает несколько способов управления:
 
 
- Сенсорное управление
 
- Физическая клавиатура и мышь
 
- Внешние геймпады
 
- **Input Bridge** для сопоставления касаний с клавиатурой/мышью
 

 
Input Bridge **обязателен** для комфортного сенсорного управления.
  
## 📱 Minimum System Requirements
 
 
⚠️ Это **минимальные требования**. Настоятельно рекомендуется более мощное оборудование.
 
 
 
- **SoC:** Qualcomm Snapdragon 655 или аналог
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** минимум 3 ГБ (рекомендуется 4 ГБ+)
 
- **Android:** Android 10 или новее
 
- **GPU:** Adreno с поддержкой Vulkan (рекомендуется)
 
- **Storage:** 6–8 ГБ свободного места
 

 
На слабых устройствах возможны вылеты или очень низкая производительность.
  
## 📦 Installation
 
### 1. Установите необходимые приложения - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Откройте Termux и выполните:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. Запуск BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- Wine можно устанавливать или удалять через **Manage Packages**
 
- Выбор контейнера Wine доступен в главном меню
 
- Wine Mono, Gecko, DXVK, Turnip и VirGL можно установить из меню Wine
 

 
### Box86 / Box64 Dynarec
 
 
- Переменные Dynarec можно настраивать через меню настроек
 
- Отдельные меню для Box86 и Box64
 

 
### System Settings
 
 
- Изменение локали Wine
 
- Настройка DXVK HUD
 
- Настройка параметров Turnip
 
- Используется резервное разрешение, если определение разрешения X11 не удалось
 
- Пользователям Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 следует включить **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- Дополнительный **OOM Adjuster** доступен для устройств с root-правами
 
- Помогает предотвратить закрытие Termux системой при нехватке памяти
 

  
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
 
Чтобы удалить BoxWine, используйте меню **Backup and Restore**.
  
## ⚠️ Disclaimer
 
BoxWine — **официальный** проект. Он **не связан** с разработчиками WineHQ, Box64, Box86 или Termux.
 
Используйте на свой риск.
  
## 📌 Project Status
 
 
- 🚧 Активная разработка
 
- 🧪 Экспериментальный проект
 
- ❌ Не готов к продакшен-использованию
 

 
Отзывы, тестирование и вклад в разработку приветствуются.
  
## ❤️ Credits
 
[glibc-packages](https://github.com/termux-pacman/glibc-packages)
 
[Box64](https://github.com/ptitSeb/box64)
 
[Box86](https://github.com/ptitSeb/box86)
 
[DXVK](https://github.com/doitsujin/dxvk)
 
[DXVK-ASYNC](https://github.com/Sporif/dxvk-async)
 
[DXVK