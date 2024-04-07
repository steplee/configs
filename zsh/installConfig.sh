
mkdir -p ${HOME}/.config/zsh

sudo apt-get install zsh zsh-syntax-highlighting

cp -r zsh/.zshenv ~/.zshenv
cp -r zsh/.zshrc ~/.config/zsh/
cp -r zsh/pureTheme ~/.config/zsh/
