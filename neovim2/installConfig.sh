#!/bin/sh

dir=$(dirname -- "$( readlink -f -- "$0"; )")

if [ -d "neovim2" -a ! -h "neovim2" ]; then cd neovim2; fi

rm -f ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/lua/

cp init.lua ~/.config/nvim/
cp lua/config ~/.config/nvim/lua/ -r
cp lua/plugins ~/.config/nvim/lua/ -r

#cp -r localPlugins ~/.config/nvim/
# cp -r colors ~/.config/nvim/

# Make it NOT writable, so that the user knows
# it is more of a copy than a file.
# That way things won't get overwritten.
# Modify the init.lua in the repo, not in ~/.config!
chmod a-w ~/.config/nvim/init.lua

# Run PackerSync
#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
