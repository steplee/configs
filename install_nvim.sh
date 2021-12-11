#!/bin/bash

sudo apt-get install clangd

echo ' - Installing nvim.'
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/local/bin/ && sudo ln -s /usr/local/bin/nvim.appimage /usr/local/bin/nvim

echo ' - Installing fonts.'
mkdir fonts
cd fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip
unzip 3270.zip
sudo mkdir /usr/share/fonts/truetype/nerd
sudo cp *ttf /usr/share/fonts/truetype/nerd
cd ..
rm fonts -rf

echo ' - Installing vim plugin manager.'
sh -c 'curl -fLo /home/slee/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo " - Start nvim and run :PlugInstall, and :TSUpdate"
