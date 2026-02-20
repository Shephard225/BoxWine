# 🍷 BoxWine

⚠️ **حالة المشروع: قيد التطوير**

BoxWine حالياً في مرحلة تطوير نشطة. العديد من الميزات تجريبية أو غير مستقرة أو غير مكتملة بعد.

## 📌 حول المشروع

**BoxWine** هو مشروع تجريبي تم إنشاؤه لتشغيل **تطبيقات Windows x86/x86_64** على **Android** باستخدام **Termux**.

يقوم بدمج **Wine** و **Box64 / Box86** والعديد من مكونات Linux وAndroid داخل بيئة واحدة تسمح بتشغيل برامج Windows على أجهزة ARM.

BoxWine ليس محاكيًا واحدًا — بل هو **حزمة توافق معقدة**.

## 🧩 المكونات الأساسية

يتكون BoxWine من عدة مكونات تعمل معًا:

- **Wine (WoW64 / Wine64 / Wine32)** – طبقة توافق Windows

- **Box64 / Box86** – ترجمة x86/x64 إلى ARM

- **بيئة مبنية على glibc** – توافق أفضل مع Linux

- **Termux** – بيئة مستخدم Linux على Android

- **Termux-X11** – خادم العرض

- **Mesa (Zink / VirGL / Turnip)** – ترجمة OpenGL و Vulkan

- **Vulkan Loader for Android** – محمل Vulkan لنظام Android

- **PulseAudio** – دعم الصوت

- **Input Bridge** – إدخال اللمس ولوحة المفاتيح والفأرة وأذرع التحكم

- **Vortek** – تحسين توافق Vulkan وحزمة الرسوميات

- **MangoHud** – طبقة عرض لمراقبة الأداء (FPS واستخدام GPU/CPU والإحصائيات)

## 🖥️ العرض والرسوميات

- يتم التعامل مع إخراج العرض عبر **Termux-X11**

- دعم وضع النوافذ ووضع الشاشة الكاملة

- يعتمد تسريع العتاد على الجهاز ووحدة GPU

- دعم Vulkan على الأجهزة المتوافقة

- يتم اكتشاف الدقة تلقائياً مع خيارات احتياطية

## 🎮 التحكم والإدخال

يدعم BoxWine عدة طرق إدخال:

- التحكم عبر شاشة اللمس

- لوحة مفاتيح وفأرة فعلية

- أذرع تحكم خارجية

- **Input Bridge** لربط اللمس بلوحة المفاتيح والفأرة

يُعد **Input Bridge ضرورياً** للحصول على تحكم لمس مريح.

## 📱 الحد الأدنى لمتطلبات النظام

⚠️ هذه هي **الحد الأدنى من المتطلبات** ويوصى بشدة باستخدام عتاد أفضل.

- **SoC:** Qualcomm Snapdragon 655 أو ما يعادله

- **CPU:** ARM64 (AArch64)

- **RAM:** حد أدنى 3GB (يوصى بـ 4GB أو أكثر)

- **Android:** Android 10 أو أحدث

- **GPU:** Adreno مع دعم Vulkan (موصى به)

- **Storage:** مساحة فارغة 6–8GB

قد تتعرض الأجهزة الضعيفة لانهيارات أو أداء منخفض جداً.

## 📦 التثبيت

### 1. تثبيت التطبيقات المطلوبة
- [Termux](https://f-droid.org/repo/com.termux_118.apk)
- [Termux-X11](https://raw.githubusercontent.com/olegos2/mobox/main/components/termux-x11.apk)
- [Input Bridge](https://raw.githubusercontent.com/olegos2/mobox/main/components/inputbridge.apk)

### 2. افتح Termux ونفّذ:

`curl -fsSL https://raw.githubusercontent.com/Shephard225/BoxWine/main/installation.sh -o ~/boxwine-install.sh || exit 1   chmod +x ~/boxwine-install.sh   bash ~/boxwine-install.sh`

### 3. تشغيل BoxWine

`boxwine`

## ⚙️ الإعداد

### Wine

- يمكن تثبيت أو إزالة Wine عبر **Manage Packages**

- اختيار حاوية Wine متاح في القائمة الرئيسية

- يمكن تثبيت Wine Mono وGecko وDXVK وTurnip وVirGL من قائمة Wine

### Box86 / Box64 Dynarec

- يمكن ضبط متغيرات Dynarec من قائمة الإعدادات

- قوائم منفصلة لـ Box86 وBox64

### إعدادات النظام

- تغيير لغة Wine

- إعداد DXVK HUD

- ضبط إعدادات Turnip

- استخدام دقة احتياطية إذا فشل اكتشاف دقة X11

- يجب على مستخدمي Snapdragon 8 Gen 1 / 8+ Gen 1 / 7+ Gen 2 تفعيل **A7xx flickering fix (TU_DEBUG)**

### إعدادات الروت

- توفر أداة **OOM Adjuster** اختيارية للأجهزة المروّتة

- تساعد في منع إغلاق Termux بواسطة النظام عند انخفاض الذاكرة

## 🖥️ إعدادات Termux-X11 الموصى بها

- Display resolution mode: **Exact**

- Display resolution: **1280x720**

- Reseed screen while keyboard is open: **OFF**

- Fullscreen on device display: **ON**

- Force landscape orientation: **ON**

- Hide display cutout: **ON**

- Show additional keyboard: **OFF**

- Prefer scancodes when possible: **ON**

## ❌ إزالة التثبيت

لإزالة BoxWine استخدم قائمة **Backup and Restore**.

## ⚠️ إخلاء المسؤولية

BoxWine مشروع **غير مرتبط رسمياً** بمطوري WineHQ أو Box64 أو Box86 أو Termux.

الاستخدام على مسؤوليتك الخاصة.

## 📌 حالة المشروع

- 🚧 تطوير نشط

- 🧪 مشروع تجريبي

- ❌ غير جاهز للاستخدام الإنتاجي

نرحب بالملاحظات والاختبارات والمساهمات.

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