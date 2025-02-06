# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt='yes'
    elif [ "$(uname -s)" == 'DragonFly' -a "${TERM}" = 'screen' ]
    then
	color_prompt='yes'
    else
	color_prompt=
    fi
fi

export GIT_PS1_SHOWDIRTYSTATE=1

if [ "$color_prompt" = yes ]; then
	$(type -t __git_ps1 >/dev/null) && PS1="\[\033[32;92;40;3m\]\$(__git_ps1)\[\033[00m\]" || PS1=''

	PS1="${PS1}${debian_chroot:+($debian_chroot)}\[\033[37;97;45;01m\][\u@\h \W]\$\[\033[00m\] "
else
	$(type -t __git_ps1 >/dev/null) && PS1="\$(__git_ps1)" || PS1=''

	PS1="${PS1}${debian_chroot:+($debian_chroot)}[\u@\h \W]\$ "
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # Midnight Commander doesn't understand this:
##    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias xfontsel="xfontsel -sampleUCS '0123456789
ABCDEFGHIJKLMNOPQRSTUVWXYZ
abcdefghijklmnopqrstuvwxyz
АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
абвгдеёжзийклмнопрстуфхцчшщъыьэюя'"
alias rdesktop='rdesktop -0 -N -x lan -r sound:local -r lspci -r clipboard:PRIMARYCLIPBOARD'
alias gqview='geeqie'
alias gitex='gitext.sh'
alias smartcvs='smartcvs.sh'
alias smartgit='/usr/share/smartgit/bin/smartgit.sh'
alias slack='(xhost +SI:localuser:ihateslack; sudo -u ihateslack ~ihateslack/bin/slack; xhost -SI:localuser:ihateslack)'
alias drracket='LC_CTYPE=en_US.UTF-8 drracket'
alias xterm-img='xterm-img -common'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# mc, Gentoo only
if [ -e /usr/libexec/mc/mc.sh ]
then
	. /usr/libexec/mc/mc.sh
fi

# sci-electronics/alliance, Gentoo only
if [ -e /etc/alliance.env ]
then
	. /etc/alliance.env
fi

##chrome_flags+=' --disable-remote-fonts'
##chrome_flags+=' --proxy-server=http://localhost:3128'
chrome_flags+=' --high-dpi-support=1'
chrome_flags+=' --force-device-scale-factor=1'

for browser in 'chromium' 'google-chrome' 'gooogle-chrome-stable' 'iridium-browser' 'opera' 'vivaldi' 'vivaldi-stable'
do
	alias ${browser}="${browser}${chrome_flags}"
done

unset chrome_flags

if [ "$(locale charmap)" = 'UTF-8' ]
then
	(fortune lorquotes 2>/dev/null || fortune) | cowsay
else
	# Not really necessary except for Cygwin. Debian 9 seems to
	# re-encode the messages properly.
	##fortune lorquotes | iconv -f UTF-8 -t $(locale charmap)
	(fortune lorquotes 2>/dev/null || fortune) | cowsay
fi

# ble.sh, required for atuin to work.
if [[ -f "${HOME}/.local/share/blesh/ble.sh" ]]
then
	. "${HOME}/.local/share/blesh/ble.sh"
fi
