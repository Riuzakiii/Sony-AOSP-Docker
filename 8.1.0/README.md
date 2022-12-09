https://developer.sony.com/develop/open-devices/guides/aosp-build-instructions/build-aosp-nougat-7-1-2

1. Build the image using `docker build -t android-8.1.0_r52 --build-arg USERID=yourUserID .`. Replace yourUserID by the ID (you can get it using `less /etc/passwd | grep $(whoami)` for instance). This way, you wont have an ownership issue between the user in the container and your user if you change the files directly.
2. Run the container using `docker run -it --mount type=bind,source=whereYouWantToBuildAndroidAbsolute,target=/home/android android-8.1.0_r52`
Replace "whereYouWantToBuildAndroidAbsolute" by the absolute path to the folder where you build Android (you should have around 200go available)
3. Run `../setup_repo.sh` if you want to setup/sync the android repo and the sony local_manifests. Should be done the first time at least.
4. Run `../run_build.sh` everytime you want to build

https://developer.sony.com/develop/open-devices/downloads/software-binaries for the vendor image (oem)
