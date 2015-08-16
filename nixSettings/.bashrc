# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Load in the git branch prompt script.
. ~/.git-prompt.sh

NoColor="\e[0m"
Red="\e[0;31m"
Blue="\e[0;34m"
Yellow="\e[0;33m"
Green="\e[0;32m"
PS1="\[$Red\]\t\[$NoColor\]-\[$Blue\]\w\[$Green\]\$(__git_ps1)\[$NoColor\] $ "


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


