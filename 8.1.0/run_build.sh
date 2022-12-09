#!/bin/bash
PATH=~/bin:$PATH
USER=$(whoami)
export PATH
export USER
source build/envsetup.sh
lunch && make -j 16