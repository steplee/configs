configs
=======

Add this to bashrc

PS1="\[\]\$(exit=\$?; if [[ \$exit == 0 ]]; then echo \"\[\033[01;              32m\]~\~S\"; else echo \"\[\033[01;31m\]~\~W \$exit\"; fi) \[\033[01;32m\]\u\[\033[01;34m\] \W \$\[\033[00m\] "
export LANG="en_US.UTF-8"
