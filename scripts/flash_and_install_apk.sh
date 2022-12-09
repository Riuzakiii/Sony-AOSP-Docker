#!/bin/bash

APK=$1
IMG_FOLDER=$2
OEM_IMG=$3

echo "Rebooting in flash mode"
sudo adb reboot bootloader
sudo adb kill-server

while [[ -z $(fastboot devices) ]] ; do
    sleep 1
    echo "Waiting for reboot in flash mode"
done

echo "Flashing imgs"
fastboot flash oem "${OEM_IMG}"
fastboot flash boot "${IMG_FOLDER}"/boot.img
fastboot flash recovery "${IMG_FOLDER}"/recovery.img
fastboot flash system "${IMG_FOLDER}"/system.img
fastboot flash vendor "${IMG_FOLDER}"/vendor.img
fastboot flash userdata "${IMG_FOLDER}"/userdata.img
echo "Rebooting..."
fastboot reboot

echo "Waiting for device to reboot ..."
adb wait-for-device
# because adb might be launched before APK service
# https://stackoverflow.com/questions/3634041/detect-when-android-emulator-is-fully-booted
echo "Waiting for end of boot animation"
while [[ ! $(adb shell getprop init.svc.bootanim) = "stopped" ]] ; do
    sleep 1
done
echo "Installing APK..."
sudo adb install "${APK}"
