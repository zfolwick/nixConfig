# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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

