source ~/.antigen.zsh

EDITOR=nvim


HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE

antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
#antigen theme XsErG/zsh-themes themes/lazyuser
#antigen theme pure
antigen theme blinksSLEE
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
setopt NO_NOMATCH
setopt flowcontrol

#alias chrome-dev="google-chrome-stable --disable-web-security --allow-file-access-from-files --allow-file-access --allow-cross-origin-auth-prompt"

export PATH="$PATH:/usr/local/cuda/bin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias tmux="TERM=st-256color tmux -2"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu/"

# bash-like ctrl-u
bindkey \^U backward-kill-line
alias gst="git status -uno"
# ctags tag all of /usr/include
alias ctagsinc="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include"


## USE TMUX
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
export PATH=$HOME/local/bin:$PATH

#export PATH="/home/slee/anaconda3/bin:$PATH"

export GOPATH=/usr/etc/go/path
export PATH="$PATH:$GOROOT/bin:/usr/lib/go-1.10/bin"

# Setup vim plugins
#if _has fzf && _has ag; then
#  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
#  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
#  export FZF_DEFAULT_OPTS='
#  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
#  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
#  '
#fi
function find_last () { find "${1:-.}" -type f -printf '%TY-%Tm-%Td %TH:%TM %P\n' 2>/dev/null | sort | tail -n "${2:-10}" }

function rsync2() {
  rsync -Pru $1 ${1##*/};
  rsync -Pru ${1##*/} $2;
  rm ${1##*/};
}

if [ -f "${HOME}/.zshrc.local" ]; then
	source ${HOME}/.zshrc.local
fi

swapFile() {
	mv $1 $1.tmp
	mv $2 $1
	mv $1.tmp $2
}

export GCM_CREDENTIAL_STORE=plaintext
