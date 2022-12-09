#!/bin/bash

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
repo init --repo-branch=repo-1 -u https://android.googlesource.com/platform/manifest -b android-8.1.0_r52
if [ ! -d ".repo/local_manifests" ] 
then 
    cd .repo
    git clone https://github.com/sonyxperiadev/local_manifests
    cd local_manifests && git checkout origin/android-8.1.0_r52
    cd ../..
    repo sync
fi
./repo_update.sh
