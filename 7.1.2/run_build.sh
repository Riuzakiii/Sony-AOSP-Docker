#!/bin/bash
PATH=~/bin:$PATH
USER=$(whoami)
export PATH
export USER
source build/envsetup.sh
lunch aosp_f8331-userdebug && make -j 16