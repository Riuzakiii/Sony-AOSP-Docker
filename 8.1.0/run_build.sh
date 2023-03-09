#!/bin/bash

if [ $(($(nproc) - 3)) -gt 0 ]
then
    USE_N_CPUS=$(($(nproc) - 3))
else
    USE_N_CPUS=1
fi
echo "Using $USE_N_CPUS threads"

PATH=~/bin:$PATH
USER=$(whoami)
export PATH
export USER
source build/envsetup.sh
lunch && make -j "$USE_N_CPUS"