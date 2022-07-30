#!/bin/bash

wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage
chmod u+x nvim.appimage
sudo cp nvim.appimage /usr/local/bin/nvim.appimage
sudo ln -s /usr/local/bin/nvim.appimage /usr/local/bin/nvim
sudo chmod a+rx /usr/local/bin/nvim
