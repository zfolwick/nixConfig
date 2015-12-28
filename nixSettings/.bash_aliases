function ch {
  builtin cd "$@" && ls
}

alias u='cd .. && ls'
alias uu='cd ../.. && ls'
alias uuu='cd ../../.. && ls'
alias uuuu='cd ../../../.. && ls'

## make and make reg
alias posh='pushd /home/zafolw/git/monad-linux && make distclean bootstrap all shell && popd'
alias runp='pushd /home/zafolw/git/monad-linux && make test-pester && popd'

## git aliases
alias gst='git status'
alias glg='git lg'
alias guncommit='git reset --soft HEAD~1' ## reset 1 back from the previous commit.  For more, replace ~1 with ~N
alias gunstage='reset HEAD -- "$@" && git log -1 HEAD'  ##unstage a commit.  Try on a commit #
alias gbranch='git branch -a'
alias gdev='git checkout develop'

function gco {
    git checkout "$1" && glg && gst
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

# run a PowerShell script for quick testing
function psh {
    /home/zafolw/git/monad-linux/bin/powershell "$@"
}
