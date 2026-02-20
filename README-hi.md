# 🍷 BoxWine
 
 
⚠️ **परियोजना स्थिति: विकासाधीन**
 
BoxWine वर्तमान में सक्रिय विकास चरण में है। कई सुविधाएँ प्रयोगात्मक, अस्थिर या अभी अधूरी हैं।
 
  
## 📌 About
 
**BoxWine** एक प्रयोगात्मक परियोजना है जिसे **Termux** का उपयोग करके **Android** पर **Windows x86/x86_64 अनुप्रयोग** चलाने के लिए बनाया गया है।
 
यह **Wine**, **Box64 / Box86**, और कई Linux व Android घटकों को एक ऐसे वातावरण में जोड़ता है जो ARM उपकरणों पर Windows सॉफ़्टवेयर चला सकता है।
 
BoxWine कोई एकल एमुलेटर नहीं है — यह एक **जटिल कम्पैटिबिलिटी स्टैक** है।
  
## 🧩 Core Components
 
BoxWine कई अलग-अलग घटकों से मिलकर बना है जो साथ मिलकर काम करते हैं:
 
 
- **Wine (WoW64 / Wine64 / Wine32)** – Windows संगतता परत
 
- **Box64 / Box86** – x86/x64 से ARM अनुवाद
 
- **glibc आधारित वातावरण** – बेहतर Linux संगतता
 
- **Termux** – Android पर Linux उपयोगकर्ता वातावरण
 
- **Termux-X11** – डिस्प्ले सर्वर
 
- **Mesa (Zink / VirGL / Turnip)** – OpenGL और Vulkan अनुवाद
 
- **Vulkan Loader for Android** – Android के लिए Vulkan लोडर
 
- **PulseAudio** – ध्वनि समर्थन
 
- **Input Bridge** – टच, कीबोर्ड, माउस और गेमपैड इनपुट

- **Vortek** – ग्राफिक्स स्टैक और Vulkan संगतता अनुकूलन

- **MangoHud** – प्रदर्शन मॉनिटरिंग ओवरले (FPS, GPU/CPU उपयोग और आँकड़े)
 

  
## 🖥️ Display & Graphics
 
 
- डिस्प्ले आउटपुट **Termux-X11** के माध्यम से संभाला जाता है
 
- विंडो और फुलस्क्रीन मोड समर्थित हैं
 
- हार्डवेयर एक्सेलेरेशन डिवाइस और GPU पर निर्भर करता है
 
- संगत डिवाइस पर Vulkan समर्थित है
 
- रिज़ॉल्यूशन स्वतः पहचान लिया जाता है, बैकअप विकल्पों के साथ
 

  
## 🎮 Controls & Input
 
BoxWine कई इनपुट विधियों का समर्थन करता है:
 
 
- टचस्क्रीन नियंत्रण
 
- भौतिक कीबोर्ड और माउस
 
- बाहरी गेमपैड
 
- **Input Bridge** टच को कीबोर्ड/माउस से मैप करने के लिए
 

 
आरामदायक टच नियंत्रण के लिए **Input Bridge आवश्यक** है।
  
## 📱 Minimum System Requirements
 
 
⚠️ ये **न्यूनतम आवश्यकताएँ** हैं। बेहतर हार्डवेयर की दृढ़ता से अनुशंसा की जाती है।
 
 
 
- **SoC:** Qualcomm Snapdragon 655 या समकक्ष
 
- **CPU:** ARM64 (AArch64)
 
- **RAM:** न्यूनतम 3 GB (4 GB+ अनुशंसित)
 
- **Android:** Android 10 या नया संस्करण
 
- **GPU:** Vulkan समर्थन वाला Adreno (अनुशंसित)
 
- **Storage:** 6–8 GB खाली स्थान
 

 
कमज़ोर डिवाइस पर क्रैश या बहुत खराब प्रदर्शन हो सकता है।
  
## 📦 Installation
 
### 1. आवश्यक ऐप्स इंस्टॉल करें - [Termux](https://f-droid.org/repo/com.termux_118.apk) - [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk) - [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)
 
### 2. Termux खोलें और चलाएँ:
 `curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh   ` 
 
### 3. BoxWine शुरू करें
 `boxwine   `  
 
## ⚙️ Configuration
 
### Wine
 
 
- Wine को **Manage Packages** के माध्यम से इंस्टॉल या हटाया जा सकता है
 
- मुख्य मेनू में Wine कंटेनर चयन उपलब्ध है
 
- Wine Mono, Gecko, DXVK, Turnip और VirGL को Wine मेनू से इंस्टॉल किया जा सकता है
 

 
### Box86 / Box64 Dynarec
 
 
- Dynarec वेरिएबल्स को सेटिंग्स मेनू से कॉन्फ़िगर किया जा सकता है
 
- Box86 और Box64 के लिए अलग मेनू
 

 
### System Settings
 
 
- Wine locale बदलें
 
- DXVK HUD कॉन्फ़िगर करें
 
- Turnip सेटिंग्स समायोजित करें
 
- यदि X11 रिज़ॉल्यूशन पहचान विफल हो जाए तो बैकअप रिज़ॉल्यूशन उपयोग होता है
 
- Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 उपयोगकर्ताओं को **A7xx flickering fix (TU_DEBUG)** सक्षम करना चाहिए
 

 
### Root Settings
 
 
- रूटेड डिवाइस के लिए वैकल्पिक **OOM Adjuster** उपलब्ध
 
- कम मेमोरी पर Termux को सिस्टम द्वारा बंद होने से बचाने में मदद करता है
 

  
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
 
BoxWine हटाने के लिए **Backup and Restore** मेनू का उपयोग करें।
  
## ⚠️ Disclaimer
 
BoxWine एक **आधिकारिक** परियोजना है, लेकिन WineHQ, Box64, Box86 या Termux डेवलपर्स से **संबद्ध नहीं** है।
 
अपने जोखिम पर उपयोग करें।
  
## 📌 Project Status
 
 
- 🚧 सक्रिय विकास
 
- 🧪 प्रयोगात्मक परियोजना
 
- ❌ उत्पादन उपयोग के लिए तैयार नहीं
 

 
प्रतिक्रिया, परीक्षण और योगदान का स्वागत है।
  
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