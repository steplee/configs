#!/bin/bash

sudo apt-get install clangd

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/local/bin/ && sudo ln -s /usr/local/bin/nvim.appimage /usr/local/bin/nvim

sh -c 'curl -fLo /home/slee/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo " - Start nvim and run :PlugInstall, and :TSUpdate"
