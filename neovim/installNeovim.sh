#!/bin/bash

echo ''
echo ' - Installing fonts.'
mkdir fonts
cd fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip
unzip 3270.zip
sudo mkdir /usr/share/fonts/truetype/nerd
sudo cp *ttf /usr/share/fonts/truetype/nerd
cd ..
rm fonts -rf

echo ''
echo ' - Installing neovim appimage.'
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage
chmod u+x nvim.appimage
sudo cp nvim.appimage /usr/local/bin/nvim.appimage
sudo ln -s /usr/local/bin/nvim.appimage /usr/local/bin/nvim
sudo chmod a+rx /usr/local/bin/nvim

echo ''
echo ' - Done. Now run installConfigs.sh'
