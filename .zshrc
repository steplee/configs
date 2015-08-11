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

alias chrome-dev="google-chrome-stable --disable-web-security --allow-file-access-from-files --allow-file-access --allow-cross-origin-auth-prompt"

export PATH="$PATH:~/dev/chrome/depot_tools"
export PATH="$PATH:~/.cabal/bin"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'

alias tmux="TERM=xterm-256color tmux -2"
export OSSIEHOME=/usr/local/redhawk/core
export SDRROOT=/var/redhawk/sdr
export PYTHONPATH=${OSSIEHOME}/lib/python
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export PATH=${OSSIEHOME}/bin:${JAVA_HOME}/bin:$PATH
export LD_LIBRARY_PATH="$OSSIEHOME/lib64:$OSSIEHOME/lib:$LD_LIBRARY_PATH:/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86_64/:/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86/:/opt/clAmdFft-1.10.321/lib64:"
export AMDAPPSDKROOT="/home/slee/AMDAPPSDK-3.0-0-Beta"

# bash-like ctrl-u
bindkey \^U backward-kill-line
alias gst="git status -uno"

# ctags tag all of /usr/include
alias ctagsinc="ctags -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include"

export SCALA_HOME="$HOME/Downloads/scala-2.11.6"
export SCALAHOME="$HOME/Downloads/scala-2.11.6"
export PATH="$PATH:$SCALA_HOME/bin"
export AMDOCLLIB="/home/slee/AMDAPPSDK-3.0-0-Beta/lib/x86_64/sdk/libOpenCL.so"
export AMDOCLINCL="/home/slee/AMDAPPSDK-3.0-0-Beta/include"

#export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

#export PATH="$PATH:/opt/altera/aocl-sdk/bin"
#export ALTERAOCLSDKLIB="/opt/altera/aocl-sdk/host/linux64/lib"
#export ALTERAOCLSDKINC="/opt/altera/aocl-sdk/host/linux64/include"

export ALTERAOCLSDKROOT="/opt/altera/13.1/hld"
#export ALTERAOCLSDKROOT="/opt/altera/aocl-sdk"
export AOCL_BOARD_PACKAGE_ROOT=$ALTERAOCLSDKROOT/board/pcie385n
export LM_LICENSE_FILE="/data/aocl_license.dat"
export PATH="$PATH:/opt/altera/13.1/hld/bin:/opt/altera/13.1/quartus/bin"
#export QUARTUS_ROOTDIR="/opt/altera/13.1/quartus"
export LD_LIBRARY_PATH=/usr/lib64:/usr/local/lib:$LD_LIBRARY_PATH:/opt/altera/13.1/hld/host/linux64/lib
#export LD_LIBRARY_PATH=/usr/lib64:/usr/local/lib:$LD_LIBRARY_PATH:/opt/altera/aocl-sdk/host/linux64/lib

export BIO_DIR="$HOME/workspace-so/bio"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/slee/workspace-so/mixin/build
export PATH="$PATH:$HOME/perf/FlameGraph"


# Haskell binaries from stack & cabal
stackbin=""$HOME/.stack/snapshots/**/bin/""
export PATH="${PATH}:`eval "echo ${stackbin}"`"
export PATH="${PATH}:${HOME}/.cabal/bin/"

## USE TMUX
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux -2
