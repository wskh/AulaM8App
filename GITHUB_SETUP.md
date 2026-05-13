# GitHub 自动构建设置指南

## 步骤 1：创建 GitHub 仓库

1. 打开 [GitHub](https://github.com) 并登录
2. 点击右上角 **+** → **New repository**
3. 填写信息：
   - **Repository name**: `AulaM8App`
   - **Description**: `AULA M8 耳机控制APP`
   - 选择 **Private** 或 **Public**
   - 不要勾选任何初始化选项

4. 点击 **Create repository**

## 步骤 2：初始化本地仓库并推送

在项目目录打开终端（Git Bash 或 PowerShell），执行以下命令：

```bash
cd "D:\1_HRD\Trae\手机APP\AulaM8Mobile"

# 初始化 Git
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: AULA M8 App v1.0.0"

# 添加远程仓库（替换 YOUR_USERNAME 为你的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/AulaM8App.git

# 推送（会要求输入GitHub用户名和密码/Token）
git push -u origin main
```

## 步骤 3：验证自动构建

1. 推送成功后，打开你的 GitHub 仓库
2. 点击 **Actions** 标签页
3. 你会看到构建任务正在运行（黄色圆点）
4. 等待约 5-10 分钟构建完成
5. 构建成功后会生成 APK 文件

## 步骤 4：下载 APK

### 方式 A：从 Actions 下载
1. 点击 **Actions** → 点击最新的 workflow 运行
2. 点击 **aula-m8-apk** artifacts
3. 点击 **Download** 下载 ZIP 文件
4. 解压后得到 `app-debug.apk`

### 方式 B：从 Release 下载（首次构建后）
1. 点击 **Releases** 标签页
2. 点击 **v1.0.0** draft release
3. 点击 **Edit** → 取消勾选 **Draft**
4. 点击 **Publish release**
5. 在 **Assets** 部分下载 APK

## 注意事项

### GitHub Token（如果推送时需要）

从 2021 年开始，GitHub 要求使用 Personal Access Token 而不是密码：

1. GitHub → Settings → Developer settings
2. Personal access tokens → Generate new token
3. 勾选 `repo` 权限
4. 生成后复制 Token
5. 推送时用户名输入 GitHub 用户名，密码输入 Token

### 常见问题

**Q: 推送被拒绝？**
```bash
# 如果提示权限问题，先移除旧的origin
git remote remove origin
# 然后重新添加
git remote add origin https://github.com/YOUR_USERNAME/AulaM8App.git
```

**Q: Actions 没有自动运行？**
- 检查 **Settings → Actions** 是否启用
- 检查 workflow 文件是否在 `.github/workflows/` 目录

**Q: 构建失败？**
- 点击 Actions 中的失败任务查看日志
- 常见问题：网络超时、依赖版本不兼容

## 自动构建流程

每次你推送代码到 main 分支，GitHub Actions 都会自动：
1. 拉取代
2. 安装 npm 依赖
3. 添加 Android 平台
4. 同步 Capacitor
5. 构建 APK
6. 上传构建产物

你只需关注代码开发，构建交给 GitHub 处理！
