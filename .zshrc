source ~/.zshrc_local
source ~/.antigen.zsh

#  tmux
#  If not running interactively, do not do anything
alias tmux="tmux -2"
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2

antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
#antigen theme XsErG/zsh-themes themes/lazyuser
antigen theme pure
#antigen theme gnzh

antigen apply

#####

# allows HEAD^ without escaping the caret
setopt NO_NOMATCH
# allows git log a..b
#setopt NO_EXTENDED_GLOB

alias chrome-dev="google-chrome-stable --disable-web-security --allow-file-access-from-files --allow-file-access --allow-cross-origin-auth-prompt"

export PATH="$PATH:/home/cslee/dev/chrome/depot_tools"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias gcm="git commit -m"

export PATH="$HOME/.tmuxifier/bin:$PATH"
export EDITOR="vim"

# for CMS216
alias gcc="gcc -ansi -Wall -g -O0 -Wwrite-strings -Wshadow -pedantic-errors -fstack-protector-all"
