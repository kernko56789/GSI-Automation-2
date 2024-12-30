#!/bin/bash
# 创建目录并初始化 Repo
mkdir -p android/lineage
cd android/lineage

# 初始化 LineageOS 的 Repo
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0
repo sync -j$(nproc)

# 添加 GSI 配置
git clone https://github.com/phhusson/treble_experimentations.git device/generic/gsi


3. 上传 Magisk 文件

从 Magisk Releases 页面下载 magiskinit 和 Magisk.apk。

将 magiskinit 和 Magisk.apk 添加到仓库的 magisk/ 目录。





---
