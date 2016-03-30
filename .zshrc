source ~/.zshrc_local
source ~/.antigen.zsh

EDITOR=vim
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme pure
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
#setopt NO_NOMATCH
# allows git log a..b
#setopt NO_EXTENDED_GLOB

# allow ctrl-s
setopt flowcontrol

##### Path setting

export PATH="$PATH:~/dev/chrome/depot_tools"
export PATH="$PATH:~/.cabal/bin"
export PATH="$PATH:/opt/activator"
export PATH="$PATH:/opt/idea/bin"
export PATH="$PATH:$HOME/miniconda2/bin/"

export PYTHONPATH="$PYTHONATH:$HOME/miniconda2/pkgs/"

##### Aliases


export CONDA="$HOME/miniconda2/"
alias conda-py="$HOME/miniconda2/bin/python"
alias ipy="$CONDA/bin/ipython"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gst="git status -uno"
alias tmux="TERM=xterm-256color tmux -2"


# bash-like ctrl-u
bindkey \^U backward-kill-line


##### Haskell 
## binaries from stack & cabal
stackbin=""$HOME/.stack/snapshots/**/bin/""
export PATH="${PATH}:`eval "echo ${stackbin}"`"
export PATH="${PATH}:${HOME}/.cabal/bin:/usr/local/share/npm/bin"


##### Tmux initialization

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2

