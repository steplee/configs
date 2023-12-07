
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
setopt share_history
setopt autopushd

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

fpath=(${ZDOTDIR} $fpath)
autoload -Uz pureTheme; pureTheme

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e
bindkey -v
export KEYTIMEOUT=1


# Use menu for completion
zmodload zsh/complist
zstyle ':completion:*' menu select
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors true


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
bindkey -M menuselect '^[[Z' reverse-menu-complete
# bash-like ctrl-u
bindkey \^U backward-kill-line
# Allow shift-tab to go backwards in menuselect
bindkey "^[[Z" reverse-menu-complete
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
#####################


# Share history in between sessions
setopt HIST_SAVE_NO_DUPS
setopt share_history
setopt hist_ignore_space
# setopt hist_verify
setopt inc_append_history

# no cd
setopt auto_cd



# Up-arrow searches histroy with current prefix
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search # Up
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search # Down
# bindkey "${terminfo[kcuu1]}" history-beginning-search-backward
# bindkey "${terminfo[kcud1]}" history-beginning-search-forward

## USE TMUX
# If not running interactively, do not do anything
# alias tmux="TERM=st-256color tmux -2"
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

# Wait for arg1 to exit (may be pid, or string of program name), then execute arg2.
waitForProcess() {
	if [ "$#" -ne 2 -a "$#" -ne 3 ]; then
		printf " - You must pass two/three args: <pid-or-program-to-wait-for> <command-to-execute> [<sleep-time>]\n"
		return 1
	fi

	sleep_time=${3:-30}
	#echo " - sleep_time ${sleep_time}"

	re='^[0-9]+$'
	if [[ $1 =~ $re ]] ; then
		echo ' - Detected input as pid.'
		pid=$1
	else
		echo ' - Detected input as program-name, using pgrep.'
		procs=$(pgrep -f $1)
		n=$(echo ${procs} | wc -w)
		echo " - input ${1}, n ${n}, procs ${procs}"
		if [[ ${n} -eq 1 ]]; then
			pid=${procs}
		elif [[ ${n} -gt 1 ]]; then
			printf ' - Too many procceses, the program name must be unique!\n'
			return 1
		elif [[ ${n} -eq 0 ]]; then
			printf " - No process with name ${1}!\n"
			return 1
		fi
	fi

	if ! [[ -d /proc/$pid ]]; then
		echo " - pid $pid didn't exist on first run, can't sleep, exiting."
		return 1
	fi

	echo " - waiting on pid $pid"

	while [[ -d /proc/${pid} ]]; do
		sleep ${sleep_time}
	done
	printf '\n - Detected change, running command now.\n\n'
	${SHELL} -c $2
	return $?
}

export GCM_CREDENTIAL_STORE=plaintext

TIMEFMT=$'
================
CPU	%P
user	%U
system	%S
total	%E'

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

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


