# 🍷 BoxWine
 
 
⚠️ **STATUS DO PROJETO: EM DESENVOLVIMENTO**
 
O BoxWine está atualmente em desenvolvimento ativo. Muitos recursos são experimentais, instáveis ou ainda não finalizados.
 
  
## 📌 About
 
**BoxWine** é um projeto experimental projetado para executar **aplicativos Windows x86/x86_64** no **Android** usando **Termux**.
 
Ele combina **Wine**, **Box64 / Box86** e diversos componentes Linux e Android em um único ambiente capaz de executar softwares Windows em dispositivos ARM.
 
O BoxWine não é um único emulador — é uma **pilha de compatibilidade complexa**.
  
## 🧩 Core Components
 
O BoxWine é construído a partir de vários componentes trabalhando juntos:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – camada de compatibilidade do Windows
 
- **Box64 / Box86** – tradução de x86/x64 para ARM
 
- **Ambiente baseado em glibc** – compatibilidade aprimorada com Linux
 
- **Termux** – espaço de usuário Linux no Android
 
- **Termux-X11** – servidor de exibição
 
- **Mesa (Zink / VirGL / Turnip)** – tradução OpenGL e Vulkan
 
- **Vulkan Loader for Android** – carregador Vulkan para Android
 
- **PulseAudio** – suporte de áudio
 
- **Input Bridge** – entrada por toque, teclado, mouse e gamepad

- **Vortek** – otimização da pilha gráfica e compatibilidade Vulkan

- **MangoHud** – sobreposição de monitoramento de desempenho (FPS, uso de GPU/CPU e estatísticas)
 

  
## 🖥️ Display & Graphics
 
 
- A saída de vídeo é gerenciada via **Termux-X11**
 
- Suporte aos modos janela e tela cheia
 
- A aceleração de hardware depende do dispositivo e da GPU
 
- Vulkan é suportado em dispositivos compatíveis
 
- A resolução é detectada automaticamente, com opções de fallback
 

  
## 🎮 Controls & Input
 
O BoxWine suporta vários métodos de entrada:
 
 
- Controles por tela sensível ao toque
 
- Teclado e mouse físicos
 
- Gamepads externos
 
- **Input Bridge** para mapear toque para teclado/mouse
 

 
O Input Bridge é **necessário** para controles por toque confortáveis.
  
## 📱 Minimum System Requirements
 
 
⚠️ Estes são **requisitos mínimos**. Hardware mais potente é altamente recomendado.
 
 
 
- **SoC:** Qualcomm Snapdragon 655 ou equivalente
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** mínimo de 3 GB (recomendado 4 GB+)
 
- **Android:** Android 10 ou superior
 
- **GPU:** Adreno com suporte a Vulkan (recomendado)
 
- **Armazenamento:** 6–8 GB de espaço livre
 

 
Dispositivos mais fracos podem apresentar travamentos ou desempenho muito baixo.
  
## 📦 Installation
 
### 1. Instale os aplicativos necessários - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Abra o Termux e execute:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. Inicie o BoxWine
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- O Wine pode ser instalado ou removido via **Manage Packages**
 
- A seleção de container Wine está disponível no menu principal
 
- Wine Mono, Gecko, DXVK, Turnip e VirGL podem ser instalados pelo menu Wine
 

 
### Box86 / Box64 Dynarec
 
 
- Variáveis Dynarec podem ser configuradas no menu de configurações
 
- Menus separados para Box86 e Box64
 

 
### System Settings
 
 
- Alterar o locale do Wine
 
- Configurar o DXVK HUD
 
- Ajustar configurações do Turnip
 
- Uma resolução alternativa é usada caso a detecção do X11 falhe
 
- Usuários Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 devem ativar **A7xx flickering fix (TU_DEBUG)**
 

 
### Root Settings
 
 
- **OOM Adjuster** opcional disponível para dispositivos com root
 
- Ajuda a evitar que o Termux seja encerrado pelo sistema por falta de memória
 

  
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
 
Para desinstalar o BoxWine, utilize o menu **Backup and Restore**.
  
## ⚠️ Disclaimer
 
O BoxWine é um projeto **oficial**, porém **não é afiliado** aos desenvolvedores do WineHQ, Box64, Box86 ou Termux.
 
Use por sua própria conta e risco.
  
## 📌 Project Status
 
 
- 🚧 Desenvolvimento ativo
 
- 🧪 Projeto experimental
 
- ❌ Não pronto para produção
 

 
Feedback, testes e contribuições são bem-vindos.
  
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