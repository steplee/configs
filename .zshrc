source ~/.zshrc.local 2>&1 /dev/null
source ~/.antigen.zsh

EDITOR=vim
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme pure
antigen apply

#####

HISTSIZE=100000
SAVEHIST=100000

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

# JAVA

export JAVA_HOME=/usr/lib/jvm/java-8-oracle

##### Path setting

export PATH="$PATH:~/dev/chrome/depot_tools"
export PATH="$PATH:~/.cabal/bin"
export PATH="$PATH:/opt/idea/bin"
export PATH="$PATH:/opt/activator/"
export PATH="/home/lslee/anaconda2/bin:$PATH"
export CONDA="/home/lslee/anaconda2"

export PYTHONPATH="$PYTHONPATH:$CONDA/pkgs"

##### Aliases

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gst="git status -uno"
alias tmux="tmux -2"
alias ipy="$CONDA/bin/ipython"
alias condapy="$CONDA/bin/python"


# bash-like ctrl-u
bindkey \^U backward-kill-line


##### Haskell 
## binaries from stack & cabal
stackbin=""$HOME/.stack/snapshots/**/bin/""
#export PATH="${PATH}:`eval "echo ${stackbin}"`"
export PATH="${PATH}:${HOME}/.cabal/bin:/usr/local/share/npm/bin"
export PATH="${PATH}:${HOME}/.local/bin" # -- stack's bin


##### Tmux initialization

[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2

