# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# colorful less output
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Load in the git branch prompt script.
. ~/.git-prompt.sh

# Load better file navigation using z.sh.
. ./z.sh

NoColor="\e[0m"
Red="\e[0;31m"
Blue="\e[1;34m"
Yellow="\e[0;33m"
Green="\e[0;32m"
PS1="\[$Blue\]\w\[$Green\]\$(__git_ps1)\[$NoColor\] $ "


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

#alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
clear
echo $(curl -s -H "Accept: application/json" https://icanhazdadjoke.com | jq .joke)

