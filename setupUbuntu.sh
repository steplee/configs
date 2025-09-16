#/bin/bash

cp .bashrc ~/
cp .tmux.conf ~/

sudo apt-get install git tmux

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && yes | ~/.fzf/install

bash neovim/installNeovim.sh
bash neovim3/installConfig.sh
