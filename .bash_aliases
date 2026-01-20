function mgrep() {
    # method grep: this finds text matching the name given, followed by a parenthesis. Outputs until the closing parenthesis.
  if [[ $1 == *"-h"* ]]; then
    printf "%s\n" "outputs a method or function's contents to the standard output. Needs a pattern to search for and a filename."
    return
  fi

  [[ $# -lt 2 ]] && echo "needs 2 arguments: pattern and filename." && return

  local PATTERN
  PATTERN="$1"
  local FILENAME
  FILENAME="$2"
  local NL="\n"

  local method_discovered=$($(which grep) -n "$PATTERN(" "$FILENAME")
  local start_line=$(echo $method_discovered | cut -d':' -f 1)
  #echo $start_line

  local start_pattern="{"
  local end_pattern="}"
  # if the next line has a {, add it to the number of closing curlies needed.
  # then print the line and all that follow
  # if a closing curly brace is encountered, print it, then stop

# awk implementation. Looks pretty extensible.
# only start looking after the start line,, and not if you've started looking already,
# and if the search PATTERN (method name) is on the current line. then set the in range flag (ir)
# equal to 1 and set the started flag to 1. if the current line is in range and it's 
# got an ending pattern, print the line, flip in range flag off, then exit.
# otherwise, if in range, then print.
# Preserves whitespace.
# TODO: handle comments, other curlies, etc.
  awk -v sl="$start_line" \
      -v pp="$PATTERN" \
      -v sp="$start_pattern" \
      -v ep="$end_pattern" '
  NR >= sl && !started && $0 ~ pp {
      ir = 1
      started = 1
  }

  ir && $0 ~ ep {
      print
      ir = 0
      exit
  }

  ir { print }
  ' "$FILENAME"

# BASH METHOD - mostly works. Doesn't preserve leading whitespace. could be very extensible.
#   local start_pattern="{"
#   local end_pattern="}"
#   local print_flag
#   print_flag=0
#
#   local current_line_number
#   current_line_number=1
#   while IFS= read -r line; do
#       if [[ $current_line_number -lt $start_line ]]; then 
#         ((current_line_number++))
#           continue
#       fi
#
#       if [[ "$line" =~ "$start_pattern" ]]; then
#           print_flag=1
#       fi
#
#       if [[ $print_flag -eq 1 ]]; then
#           echo $line
#       fi
#
#       if [[ "$line" =~ "$end_pattern" ]]; then
#           echo $line
#           break
#       fi
#
#   done < "$FILENAME"

# gnu sed implementation.  Mostly works.
# Breaks if there's a closing curly brace. Simple, but not very extensible.
#    local end_pattern="}"
#    sed -n "$start_line,/$end_pattern/{p;/$end_pattern/{q}}" $FILENAME

}

function jgrep() {
  if [[ $1 == *"-h"* ]]; then
    printf "%s\n" "greps through a json text and then outputs the json paths that have the pattern in either the key or the value."
    return
  fi
  [[ $# -lt 2 ]] && echo "needs 2 arguments: pattern and filename." && return

  local PATTERN
  PATTERN="$1"
  local FILENAME
  FILENAME="$2"

  jq -r 'paths(scalars) as $p | "\($p | join(".")) = \(getpath($p) | @json)"' $FILENAME | $(which grep) $PATTERN
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
