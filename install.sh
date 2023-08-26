#!/bin/bash

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo apt install fuse libfuse2
./nvim.appimage --appimage-extract
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
mkdir ~/.config
cp -r nvim ~/.config
rm -rf ~/nvim.appimage
rm -rf nvim.appimage
rm -rf ~/squashfs-root
