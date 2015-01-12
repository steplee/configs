source .antigen.zsh

#antigen use oh-my-zsh

antigen bundle git

antigen bundle zsh-users/zsh-syntax-highlighting
#antigen theme XsErG/zsh-themes themes/lazyuser
antigen theme pure

antigen apply

#####



export PATH="$PATH:/home/cslee/dev/chrome/depot_tools"

alias gitLogCommits='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
