#!/bin/bash
# 确保路径正确
export PATH=~/bin:$PATH

# 启用错误处理和调试输出
set -e
set -x

# 定义工作目录和仓库
WORK_DIR="$HOME/android/lineage"
GSI_REPO="https://github.com/phhusson/treble_experimentations.git"
MAGISK_APK_URL="https://github.com/topjohnwu/Magisk/releases/latest/download/Magisk.apk"
MAGISK_INIT_URL="https://github.com/topjohnwu/Magisk/releases/latest/download/magiskinit"

# 创建工作目录
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# 初始化 LineageOS 源码
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --depth=1

# 同步源码
repo sync -j$(nproc) --force-sync

# 克隆 GSI 配置仓库
git clone "$GSI_REPO" device/generic/gsi

# 下载 Magisk APK 和 magiskinit
mkdir -p magisk
curl -L -o magisk/Magisk.apk "$MAGISK_APK_URL"
curl -L -o magisk/magiskinit "$MAGISK_INIT_URL"

# 添加 Magisk 到 GSI
cp magisk/magiskinit device/generic/gsi/root/  # 将 magiskinit 添加到 root 目录
mkdir -p device/generic/gsi/system/priv-app/MagiskManager
cp magisk/Magisk.apk device/generic/gsi/system/priv-app/MagiskManager/MagiskManager.apk  # 将 Magisk Manager 添加为系统应用

# 修改 init.rc，添加 Magisk 服务
echo 'service magisk /system/bin/magiskinit' >> device/generic/gsi/root/init.rc
echo '    class main' >> device/generic/gsi/root/init.rc
echo '    user root' >> device/generic/gsi/root/init.rc

# 输出成功信息
echo "LineageOS 源码同步完成，并已集成 Magisk。"
