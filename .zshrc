source ~/.zshrc_local
source ~/.antigen.zsh

# If not running interactively, do not do anything
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

export PATH="$PATH:~/dev/chrome/depot_tools"
export PATH="$PATH:~/.cabal/bin"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias tmux="tmux -2"
export OSSIEHOME=/var/lib/redhawk/core
export SDRROOT=/var/lib/redhawk/sdr
export PYTHONPATH=${OSSIEHOME}/lib/python
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export PATH=${OSSIEHOME}/bin:${JAVA_HOME}/bin:$PATH
export LD_LIBRARY_PATH=$OSSIEHOME/lib64:$OSSIEHOME/lib:$LD_LIBRARY_PATH
