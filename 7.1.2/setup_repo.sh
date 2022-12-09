#!/bin/bash

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
repo init --repo-branch=repo-1 -u https://android.googlesource.com/platform/manifest -b android-7.1.2_r36
if [ ! -d ".repo/local_manifests" ] 
then 
    cd .repo
    git clone https://github.com/sonyxperiadev/local_manifests
    cd local_manifests
    git checkout android-7.1.2_r36
    git branch --set-upstream-to=origin/android-7.1.2_r36
    git reset --hard origin/android-7.1.2_r36
    cd ../..
    repo sync
fi
./repo_update.sh
