# AULA M8 手机APP - Capacitor 项目

## 项目说明

这是一个基于 Capacitor 的混合应用项目，将 Web APP 打包成原生 Android APK。

## 项目结构

```
AulaM8Mobile/
├── www/                    # Web 应用代码
│   └── index.html         # 主页面（包含所有CSS和JS）
├── android/               # Android 原生项目
│   ├── app/
│   │   └── src/
│   │       └── main/
│   │           ├── AndroidManifest.xml    # 应用配置（已添加蓝牙权限）
│   │           ├── assets/public/         # Web资源
│   │           └── java/
│   ├── build.gradle
│   └── gradle/
├── capacitor.config.json  # Capacitor 配置
└── package.json

```

## 功能特性

- 🔍 **蓝牙BLE连接** - 扫描和连接AULA M8耳机
- 🎵 **10段EQ均衡器** - 7种预设 + 自定义模式
- 🎧 **ANC降噪控制** - 关闭/降噪/通透三种模式
- 💡 **LED灯光控制** - RGB颜色 + 4种灯效
- 🎮 **游戏模式** - 低延迟切换
- 🔊 **3D音效** - 虚拟环绕声
- 🎶 **音乐控制** - 播放/暂停/切歌
- ⚙️ **设备管理** - 重命名/查找/恢复出厂

## 环境要求

### 必需软件
1. **Node.js** >= 16 (已安装 ✓)
2. **Java JDK** >= 11 (已安装 ✓)
3. **Android Studio** 或 **Android SDK Command Line Tools**

### 安装 Android SDK

#### 方式1：使用 Android Studio（推荐）
1. 下载并安装 [Android Studio](https://developer.android.com/studio)
2. 打开 Android Studio，安装 SDK
3. 设置环境变量 `ANDROID_HOME` 指向 SDK 目录

#### 方式2：使用命令行工具
```bash
# 下载命令行工具
# https://developer.android.com/studio#command-tools

# 解压到 D:\Android\Sdk\cmdline-tools\latest
# 运行 sdkmanager 安装必要组件
sdkmanager "platforms;android-33"
sdkmanager "build-tools;33.0.0"
sdkmanager "platform-tools"
```

## 构建步骤

### 1. 安装依赖
```bash
cd AulaM8Mobile
npm install
```

### 2. 同步项目
```bash
npx cap sync android
```

### 3. 构建 APK

#### 方式1：使用 Android Studio
1. 打开 `android` 文件夹作为项目
2. 等待 Gradle 同步完成
3. 点击 Build → Build Bundle(s) / APK(s) → Build APK(s)

#### 方式2：使用命令行
```bash
cd android
./gradlew assembleDebug    # Linux/Mac
.\gradlew.bat assembleDebug  # Windows
```

### 4. 获取 APK
构建完成后，APK 文件位于：
```
android/app/build/outputs/apk/debug/app-debug.apk
```

## 安装到手机

### 方式1：ADB 安装
```bash
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

### 方式2：直接传输
1. 将 APK 复制到手机
2. 在手机上点击安装（需要允许未知来源安装）

## 开发调试

### 实时重新加载
```bash
npx cap run android -l --external
```

### 查看日志
```bash
adb logcat | grep Capacitor
```

### Chrome DevTools
1. 手机连接电脑，开启USB调试
2. Chrome 访问 `chrome://inspect`
3. 找到你的设备，点击 Inspect

## 蓝牙权限

应用需要以下权限（已在 AndroidManifest.xml 中配置）：
- `BLUETOOTH` - 基础蓝牙功能
- `BLUETOOTH_ADMIN` - 蓝牙管理
- `BLUETOOTH_SCAN` - 扫描设备
- `BLUETOOTH_CONNECT` - 连接设备
- `ACCESS_FINE_LOCATION` - 位置权限（蓝牙扫描需要）

## 常见问题

### 1. Gradle 下载失败
修改 `android/gradle/wrapper/gradle-wrapper.properties`：
```properties
distributionUrl=https\://mirrors.cloud.tencent.com/gradle/gradle-8.14.3-all.zip
```

### 2. SDK 位置未找到
创建 `android/local.properties`：
```properties
sdk.dir=D\:\\Android\\Sdk
```

### 3. 路径包含中文错误
已在 `gradle.properties` 中添加：
```properties
android.overridePathCheck=true
```

### 4. 蓝牙无法连接
- 确保手机蓝牙已开启
- 授予应用位置权限
- 确保耳机处于配对模式

## 发布构建

### 生成签名密钥
```bash
keytool -genkey -v -keystore aula-m8.keystore -alias aula-m8 -keyalg RSA -keysize 2048 -validity 10000
```

### 配置签名
在 `android/app/build.gradle` 中添加：
```gradle
android {
    signingConfigs {
        release {
            storeFile file("aula-m8.keystore")
            storePassword "your-password"
            keyAlias "aula-m8"
            keyPassword "your-password"
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 构建发布版
```bash
./gradlew assembleRelease
```

## 技术支持

- Capacitor 文档：https://capacitorjs.com/docs
- Bluetooth LE 插件：https://github.com/capacitor-community/bluetooth-le
- Android 开发者：https://developer.android.com

## 许可证

MIT License
