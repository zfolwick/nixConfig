function ch {
  builtin cd "$@" && ls
}

alias u='cd .. && ls'
alias uu='cd ../.. && ls'
alias uuu='cd ../../.. && ls'
alias uuuu='cd ../../../.. && ls'
alias ls='ls --color=auto'
alias ll='ls -a'
alias grep='grep --color -n'

## git aliases and functions
alias gst='git status'
alias glg='git log --oneline --graph'
alias guncommit='git reset --soft HEAD~1' ## reset 1 back from the previous commit.  For more, replace ~1 with ~N
alias gunstage='reset HEAD -- "$@" && git log -1 HEAD'  ##unstage a commit.  Try on a commit #
alias gbranch='git branch -a'
alias gdev='git checkout develop'

function gco {
    git checkout "$1" && glg && gst
}

function glb {
    git log --no-merges --oneline --format="%C(auto) %h %s" $1..
}

function gcob {
    git checkout -b "$1" && glg
}

function gcm {
   git add "$1" && git commit -m "$2" && glg && gst
}

function gpush {
    git push "$1" "$2" && glg && gst
}

##text editor aliases
function v {
    vim "$@"
}

function e {
    emacs "$@"
}


export WHOME="/mnt/c/Users/zfolw/"
export EDITOR="vim"  # for ctrl-x ctrl-e
