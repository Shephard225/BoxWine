# 🍷 BoxWine
 
 
⚠️ **项目状态：开发中**
 
BoxWine 当前正处于积极开发阶段。许多功能仍为实验性、不稳定或尚未完成。
 
  
## 📌 About
 
**BoxWine** 是一个实验性项目，旨在通过 **Termux** 在 **Android** 上运行 **Windows x86/x86_64 应用程序**。
 
它将 **Wine**、**Box64 / Box86** 以及多个 Linux 和 Android 组件整合到一个环境中，使 ARM 设备能够运行 Windows 软件。
 
BoxWine 不是单一模拟器 —— 而是一个**复杂的兼容性技术栈**。
  
## 🧩 Core Components
 
BoxWine 由多个组件协同构建：
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – Windows 兼容层
 
- **Box64 / Box86** – x86/x64 到 ARM 转换
 
- **glibc-based environment** – 提升 Linux 兼容性
 
- **Termux** – Android 上的 Linux 用户空间
 
- **Termux-X11** – 显示服务器
 
- **Mesa (Zink / VirGL / Turnip)** – OpenGL 与 Vulkan 转译
 
- **Vulkan Loader for Android** – Android Vulkan 加载器
 
- **PulseAudio** – 音频支持
 
- **Input Bridge** – 触控、键盘、鼠标与手柄输入支持

- **Vortek** – 图形栈与 Vulkan 兼容性优化组件

- **MangoHud** – 性能监控覆盖层（FPS、GPU/CPU 使用率与统计信息）
 

  
## 🖥️ Display & Graphics
 
 
- 显示输出由 **Termux-X11** 处理
 
- 支持窗口模式与全屏模式
 
- 硬件加速取决于设备与 GPU
 
- 在兼容设备上支持 Vulkan
 
- 分辨率自动检测，并提供备用选项
 

  
## 🎮 Controls & Input
 
BoxWine 支持多种输入方式：
 
 
- 触摸屏控制
 
- 实体键盘与鼠标
 
- 外接游戏手柄
 
- **Input Bridge** 用于将触控映射为键盘/鼠标操作
 

 
为了获得舒适的触控体验，**必须使用 Input Bridge**。
  
## 📱 Minimum System Requirements
 
 
⚠️ 以下为**最低系统要求**，强烈建议使用性能更高的设备。
 
 
 
- **SoC:** Qualcomm Snapdragon 655 或同等级处理器
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** 至少 3 GB（推荐 4 GB+）
 
- **Android:** Android 10 或更新版本
 
- **GPU:** 支持 Vulkan 的 Adreno（推荐）
 
- **Storage:** 6–8 GB 可用空间
 

 
低端设备可能会出现崩溃或性能极差的问题。
  
## 📦 Installation
 
### 1. 安装所需应用 - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. 打开 Termux 并运行：
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. 启动 BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- 可通过 **Manage Packages** 安装或删除 Wine
 
- 可在主菜单中选择 Wine 容器
 
- 可从 Wine 菜单安装 Wine Mono、Gecko、DXVK、Turnip 与 VirGL
 

 
### Box86 / Box64 Dynarec
 
 
- Dynarec 变量可在设置菜单中配置
 
- Box86 与 Box64 拥有独立菜单
 

 
### System Settings
 
 
- 更改 Wine 区域设置
 
- 配置 DXVK HUD
 
- 调整 Turnip 设置
 
- 若 X11 分辨率检测失败，将使用备用分辨率
 
- Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 用户应启用 **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- Root 设备可使用可选 **OOM Adjuster**
 
- 防止 Termux 被系统低内存机制终止
 

  
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
 
要卸载 BoxWine，请使用 **Backup and Restore** 菜单。
  
## ⚠️ Disclaimer
 
BoxWine 是一个**官方项目**，但**不隶属于** WineHQ、Box64、Box86 或 Termux 开发者。
 
使用风险自负。
  
## 📌 Project Status
 
 
- 🚧 积极开发中
 
- 🧪 实验性项目
 
- ❌ 尚未达到生产环境可用状态
 

 
欢迎反馈、测试与贡献。
  
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