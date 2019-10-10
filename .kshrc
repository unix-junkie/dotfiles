# .kshrc

set -o emacs

if [ "`set -o | grep 'interactive' | awk '{print $2}'`" = 'on' ]
then
	PS1="$'\E[37;97;45;01m'[${LOGNAME}@`hostname -s` \${PWD##*/}]\\\$$'\E[00m' "
fi

alias ls='ls --color=auto'
alias ll='ls -laF'
alias l.='ll -d .*'
