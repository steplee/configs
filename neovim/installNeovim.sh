#!/bin/bash

echo ' - Installing ag and ripgrep'
sudo apt-get install silversearcher-ag
isUbuntu16=$( lsb_release -a | grep 'Ubuntu 16' | wc -l )
isUbuntu18=$( lsb_release -a | grep 'Ubuntu 18' | wc -l )
if [[ $isUbuntu16 -eq "1" || $isUbuntu18 -eq "1" ]]; then
	sudo snap install ripgrep
else
	sudo apt-get install ripgrep
fi

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
