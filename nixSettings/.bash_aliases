# git aliases to make git easier to work with
alias glg='git log --decorate --graph --oneline'
alias gst='git status'

# editor aliases
alias v='vim $@'
alias e='emacs $@ &'

# web browser
alias ff='firefox &'
alias chrome='google-chrome &'

# useful bash navigation aliases and functions
alias u='cd .. && ls'
alias uu='cd ../.. && ls'
alias uuu='cd ../../.. && ls'
alias uuuu='cd ../../../.. && ls'

function ch
{
    builtin cd "$@" && ls
}
