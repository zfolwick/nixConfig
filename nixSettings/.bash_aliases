# git aliases to make git easier to work with
alias glg='git log --decorate --graph --oneline'
alias gst='git status'
alias guncommit='git reset --soft HEAD~1' ## reset 1 back from the previous commit.  For more, replace ~1 with ~N
alias gunstage='reset HEAD -- "$@" && git log -1 HEAD'  ##unstage a commit.  Try on a commit #
alias gbranch='git branch -a'

function gcheckout {
    git checkout "$1" && glg
}

function gcm {
   git add "$1" && git commit -m "$2" && glg
}

# editor aliases
alias v='vim $@'
alias e='emacs $@'

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
