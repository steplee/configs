
alias ls='ls --color=auto'

alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

setopt HIST_SAVE_NO_DUPS

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

fpath=(${ZDOTDIR} $fpath)
autoload -Uz pureTheme; pureTheme

bindkey -e
bindkey -v
export KEYTIMEOUT=1

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Allow caret
setopt NO_NOMATCH
# Allow ctrl-s
setopt flowcontrol

#####################
# Enable these shorcuts even in vim mode
# These are just restoring emacs like 'bindkey -e' behaviour
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line
bindkey '^r' history-incremental-search-backward
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey "^D" delete-char-or-list
bindkey "^X*" expand-word
bindkey "^XG" list-expand
bindkey "^Xg " list-expand
bindkey "^M" accept-line
bindkey "^J" accept-line
bindkey "^O" accept-line-and-down-history
bindkey "^K" kill-line
bindkey "^X^K" kill-buffer
bindkey "^U" kill-whole-line
bindkey "^X^B" vi-match-bracket
bindkey "^X^O" overwrite-mode
bindkey "^V" quoted-insert
bindkey "^T" transpose-chars
bindkey "^Y" yank
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
bindkey "^X^N" infer-next-history
bindkey "^P" up-line-or-history
bindkey "^H" backward-delete-char
bindkey "^W" backward-kill-word
# bash-like ctrl-u
bindkey \^U backward-kill-line
#####################

export GCM_CREDENTIAL_STORE=plaintext

export PATH="$PATH:/usr/local/cuda/bin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

swapFile() {
	mv $1 $1.tmp
	mv $2 $1
	mv $1.tmp $2
}

# source /path/to/my/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

