# AOSP_Docker
Build Sony AOSP using Docker and flash it. 

WARNING : I'm not responsible for any issues arising from the use of this repository, use it only if you understand what it does and what are the risks.

1. First, unlock your device bootloader
https://developer.sony.com/develop/open-devices/get-started/unlock-bootloader
On the Xperia XZ (f8331) this involves activating the unlocked bootloader in the Developper settings,
then using the IMEI, getting the unlock code from the web page above, and finally use `fastboot oem unlock 0xyourcode`
2. Select a folder depending on the version of android you want to build
3. Follow the README in the folder
4. You will then have a shell inside the container
5. First run `../setup_repo.sh` in the /home/android folder(you should be there by default). You will have to choose your device, for instance "aosp_f8331-userdebug" for the Xperia XZ(f8331).
This will take a lot of space (200go), but after that you will have all the Android code and SONY's code to build AOSP
6. Run `../run_build.sh` to start building Android. This uses 16 cores, you can use less cores if that's too much by changin run_build.sh and rebuilding the docker image.

Some issues that might arise during build and some solutions (WARNING : i take not responsibility, you might have to redownload and rebuild everything)

ex : file missing to build a target (goldfish for instance), the following could help you solve this issue
- `repo forall -c "git reset --hard"` will erase any changes you might have done to the source by mistake
- `cd .repo/local_manifests && git reset --hard` will erase any changes you might have done to sony manifests by mistake, you could also check that you are on the right branch
- `make clean && rm -r out` this will remove all the build artefacts, but you will have to start the build again
- `rm -R build` this will remove the generated build system, you will have to use `../setup_repo.sh` again

I had to use some of those when building AOSP in the container, the build was going fine until some minor issues arised that were solved using some of the above commands.

7. Use `./scripts/flash_and_install_apk.sh APK.apk IMGFOLDER OEM.img` to flash the images you just built and install an APK, automatically.  
 You can find the OEM image here https://developer.sony.com/develop/open-devices/downloads/software-binaries.  
 The .img you built should be in "androidfolder/out/target/product/prettyNameOfYourDevice".


I recommend you read SONY's tutorial for AOSP here https://developer.sony.com/develop/open-devices/guides/aosp-build-instructions/ if something is not working properly, you can also create an issue.

NOTE : I had issues flashing the OEM (Vendor) .img ("Command not allowed" when using "fastboot flash oem myimg.img"). This was solved by flashing the latest firmware with Sony's flashtool (Windows only unfortunately). The firmware is different from the ROM you are flashing (the .img) https://en.wikipedia.org/wiki/Firmware. 

