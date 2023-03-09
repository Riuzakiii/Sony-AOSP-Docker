#!/bin/bash

export CROSS_COMPILE="/home/android/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

if [ $(($(nproc) - 3)) -gt 0 ]
then
    USE_N_CPUS=$(($(nproc) - 3))
else
    USE_N_CPUS=1
fi
echo "Using $USE_N_CPUS threads"

if [ ! -d "kernel" ]
then
    git clone https://github.com/sonyxperiadev/kernel
    cd kernel
    git checkout aosp/LA.UM.5.7.r1
    git pull
else
    echo "... Checking out Sony kernel repo"
    cd kernel
    git checkout aosp/LA.UM.5.7.r1
    git pull
fi

make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE aosp_tone_kagura_defconfig
make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE -j "$USE_N_CPUS"

echo "... Copying into device/sony/common-kernel/kernel-"

cp "arch/arm64/boot/Image.gz-dtb" "../device/sony/common-kernel/kernel-dtb-kagura"

