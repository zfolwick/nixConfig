function ch {
  builtin cd "$@" && ls
}

function mkd {
  mkdir -pv "$@" && cd "$@"
}

alias u='cd .. && ls'
alias uu='cd ../.. && ls'
alias uuu='cd ../../.. && ls'
alias uuuu='cd ../../../.. && ls'
alias ls='ls --color=auto'
alias ll='ls -a'
alias grep='grep --color -n'

## git aliases and functions
function glb {
  if [[ -z $* ]]; then
    echo "need branch name as an argument to compare to";
    return;
  fi
  git log --no-merges --oneline --format="%C(auto) %h %s" $1..
}

function gco {
    git checkout "$1" && glb && gst
}

function gcob {
    git checkout -b "$1" && glb
}

function gcm {
   git add "$1" && git commit -m "$2" && glb && gst
}

function gpush {
    git push "$1" "$2" && glb && gst
}

alias gst='git status'
alias glg='git log --oneline --graph'
alias guncommit='git reset --soft HEAD~1' ## reset 1 back from the previous commit.  For more, replace ~1 with ~N
alias gunstage='reset HEAD -- "$@" && git log -1 HEAD'  ##unstage a commit.  Try on a commit #
alias gbranch='git branch -a'
alias gdev='git checkout develop'

##text editor aliases
function v {
    vim "$@"
}

function e {
    emacs "$@"
}

UNAME=$( command -v uname)

case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
    linux*)
  printf 'linux\n'
    ;;
  darwin*)
  printf 'darwin\n'
  # macOS OSX
    function tree {
      /usr/local/bin/tree -shC
    }
    ;;
  msys*|cygwin*|mingw*)
  # or possible 'bash on windows'
  printf 'windows\n'
    ;;
  nt|win*)
    printf 'windows\n'
    # ubuntu via WSL Windows Subsystem for Linux
    export WHOME="/mnt/c/Users/zfolw/"
    ;;
  *)
  printf 'unknown\n'
    ;;
esac


export EDITOR="vim"  # for ctrl-x ctrl-e
