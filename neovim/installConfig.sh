#!/bin/sh

rm ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim
# Make it NOT writable, so that the user knows
# it is more of a copy than a file.
# That way things won't get overwritten.
# Modify the init.lua in the repo, not in ~/.config!
chmod a-w ~/.config/nvim/init.lua