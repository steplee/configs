source ~/.zshrc_local
source ~/.antigen.zsh

EDITOR=vim


antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
#antigen theme XsErG/zsh-themes themes/lazyuser
antigen theme pure
#antigen theme gnzh

antigen apply

#####

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^u' backward-kill-line
bindkey '^r' history-incremental-search-backward
export KEYTIMEOUT=1

#####

# allows HEAD^ without escaping the caret
setopt NO_NOMATCH
# allows git log a..b
#setopt NO_EXTENDED_GLOB

# allow ctrl-s
setopt flowcontrol

#alias chrome-dev="google-chrome-stable --disable-web-security --allow-file-access-from-files --allow-file-access --allow-cross-origin-auth-prompt"

export PATH="$PATH:/usr/local/cuda/bin"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias tmux="TERM=xterm-256color tmux -2"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"

# bash-like ctrl-u
bindkey \^U backward-kill-line
alias gst="git status -uno"
source /home/slee/.nix-profile/etc/profile.d/nix.sh
# ctags tag all of /usr/include
alias ctagsinc="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include"


## USE TMUX
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2
export PATH=$HOME/local/bin:$PATH
