#/bin/bash

cp .bashrc ~/
cp .tmux.conf ~/
cp .config ~/.config -r

sudo apt-get install git tmux fish

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && yes | ~/.fzf/install

# Neovim
bash neovim/installNeovim.sh
bash neovim3/installConfig.sh

# Fish
chsh -c /usr/bin/fish
