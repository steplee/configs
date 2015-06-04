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
export OSSIEHOME=/usr/local/redhawk/core
export SDRROOT=/var/redhawk/sdr
export PYTHONPATH=${OSSIEHOME}/lib/python
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export PATH=${OSSIEHOME}/bin:${JAVA_HOME}/bin:$PATH
export LD_LIBRARY_PATH="$OSSIEHOME/lib64:$OSSIEHOME/lib:$LD_LIBRARY_PATH:/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86_64/:/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86/"
export AMDAPPSDKROOT="/home/slee/AMDAPPSDK-3.0-0-Beta"

# bash-like ctrl-u
bindkey \^U backward-kill-line
alias gst="git status -uno"

# ctags tag all of /usr/include
alias ctagsinc="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include"

export AMDOCLLIB="/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86_64/sdk/libOpenCL.so"
export AMDOCLINCL="/home/slee/AMDAPPSDK-3.0-0-Beta/include"

#export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
