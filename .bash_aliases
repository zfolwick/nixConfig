#recursively bulk replace all text found in a subdirectory
function bed {
  text_to_search=$1
  text_to_change=$2
  files=$(grep -rl "${text_to_search}")
  for file in $files; do
    printf '%s\n' ",s/$text_to_search/$text_to_change/g" wq | ed -s $file
  done
  echo changed $text_to_search $text_to_change
}

# prints out the contents of a file, but when there's a third argument, pass the commands to ed.
# if these commands are line numbers, for instance "11,18p", then this will print lines 11 - 18
# to the terminal.
# e.g., cat ./scripts/my_script 11,18p
#    my content
#    some lines
#    ...
#    ...
#    ...
#    etc.
function cat {
  [[ -z $2 ]] && $(which cat) $1 && return

  sed -n "${2}" "${1}"

}

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
if [[ $(uname) ==  "Darwin" ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -a'
alias hgrep='history | grep'
#alias grep='grep --color -n'

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
alias glg='git log --oneline --graph --pretty=format:"%C(yellow)%h%d %Creset %C(cyan)%cd%C(reset) %C(yellow)%an%Creset -  %s"'
alias guncommit='git reset --soft HEAD~1' ## reset 1 back from the previous commit.  For more, replace ~1 with ~N
alias gunstage='reset HEAD -- "$@" && git log -1 HEAD'  ##unstage a commit.  Try on a commit #
alias gbranch='git branch -a'
alias gdev='git checkout develop'

##text editor aliases
function v {
    vim "$@"
}

function vf {
    vim $(fzf)
}

function e {
    emacs "$@"
}

function nv {
  nvim "$@"
}

function nf {
  nvim $(fzf)
}

function goto {
  git grep "$@"
  nv $(git grep "$@" | awk -F':' '{print $1}') +/"$@"/
}

alias g2='goto'
# Useful cheatsheet
function cht {
    curl cheat.sh/"$@"
}

function pgrep {
  ps -ef | sed -n "1p; /sed -n/d; /${1}/p"
}

alias ctags="`brew --prefix`/bin/ctags"

UNAME=$( command -v uname)

case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
    linux*)
  printf 'linux\n'
    ;;
  darwin*)
  printf 'darwin\n'
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
alias gs="git status"
