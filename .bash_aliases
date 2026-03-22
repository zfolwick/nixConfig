echo "sourcing aliases..."

func_lint () {
  FUNCTION_NAME="${FUNCNAME[0]}"
  description () {
    echo "Check functions missing <func>_description and/or <func>_usage"
  }

  usage () {
    echo "usage: $FUNCTION_NAME path/to/script.sh"
    echo 
    echo "Returns:
    [func-name] [0|1] [0|1]"
    echo "Where the first column after the function name represents whether it has a description (0 for no, 1 for yes)"
    echo "and the second column after the function name represents whether a usage function is defined (0 = no, 1 = yes)"
  }
  
  if [[ $# -lt 1 ]]; then
    usage
    return 1
  fi
  
  script=$1
  
  # Load the script so its functions are in the environment
  # shellcheck disable=SC1090
  . "$script"
  
  funcs=()
  
  # If you have lf, use it to list functions
  if lf "$1">/dev/null 2>&1; then
    while IFS= read -r f; do
      [[ -n "$f" ]] && funcs+=( "$f" ) 
    done < <(lf "$1")
  else
    # Fallback: use declare -F
    while IFS= read -r f; do
      [[ -n "$f" ]] && funcs+=( "$f" )
    done < <(bash -c ". "$1" > /dev/null; declare -F | \awk '{print \$3}'")
  fi

  missing=0
  
  for f in "${funcs[@]}"; do
    local line="$f"

    if type "$f" | grep "function description ()" > /dev/null; then
      line="$line 1"
    else
      line="$line 0"
    fi
  
    if type "$f" | grep "function usage ()" > /dev/null; then
      line="$line 1"
    else
      line="$line 0"
    fi
  done



  unset FUNTION_NAME
  # exit non-zero if anything missing
  if (( missing > 0 )); then
    return 1
  fi
}

lf () {
  description () {
    echo "lists the functions in bash file"
  }

  usage () {
    cat << EOF
Usage:
lf FILENAME
EOF
  }

  [[ "$#" -eq 0 ]] && echo "need a filename" && description && usage && return 1

  bash -c ". "$1" > /dev/null; declare -F | \awk '{print \$3}'"
}

shebang() {
  description () {
    echo "adds a shebang \"#!/usr/bin/env bash\" to the first line of a file"
  }

  usage () {
    echo "shebang [bash|c|go|node] FILENAME"
    echo
    echo "FILENAME:"
    echo   "#!/usr/bin/env bash"
    echo 
    echo "This does not add any other text to the file. All it does is prepend the shebang line."
  }

  [[ "$#" -eq 0 ]] && description && usage && return 1

  SCRIPT_LANG="$1"
  FILE="$2"
  [[ ! -x $FILE ]] && EXISTS="false"

  set -e

  case $SCRIPT_LANG in
    bash)
      if [ "$EXISTS" == "false" ] || [ ! -s "$FILE" ]; then
        echo '#!/usr/bin/env bash' > "$FILE"
      else 
        gsed -i '1i \#!/usr/bin/env bash' "$FILE"
      fi
      ;;
    c)
      if [ "$EXISTS" == "false" ] || [ ! -s "$FILE" ]; then
        echo '//usr/bin/env gcc "$0" -o /tmp/a; /tmp/a "$@"; exit $?' > "$FILE"
      else 
        gsed -i '1i \//usr/bin/env gcc "$0 -o /tmp/a; /tmp/a "$@"; exit $?' "$FILE"
      fi
      ;;
    go)
      if [ "$EXISTS" == "false" ] || [ ! -s "$FILE" ]; then
        echo '/*usr/bin/env go run "$0" "$@"; exit $? #*/' > $FILE
      else 
        gsed -i '1i \/*usr/bin/env go run "$0" "$@"; exit $? #*/' "$FILE"
      fi
      ;;
    node)
      if [ "$EXISTS" == "false" ] || [ ! -s "$FILE" ]; then
        echo '#!/usr/bin/env node' > "$FILE"
      else 
        gsed -i '1i \#!/usr/bin/env node' "$FILE"
      fi
      ;;
  esac

}
alias sb='shebang'

wifi() {

  info() {
    cat << EOF
interact with wifi in a simple way, because I hate how slow the mac is to bring up the stupid dialog box.
EOF
}

  usage() {
    cat << EOF

      -h|--help               This menu
      -n|--network-name       Set the network name for the wifi
      -s|--show-password      Set whether to show the password
      -c|--change-password    Sets whether to change the password

Usage:
  wifi --change-password "new-password" --network-name "floopy-derp"

  wifi --show-password --network-name "floopy-derp"
EOF
}
  
  if [ "$#" -eq 0 ]; then
    echo "need parameters"
    usage
    return 
  fi
local WIFI_NETWORK_NAME=""
local SHOW_PASSWD=""
local CHANGE_PASSWD=""
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -n|--network-name)
        shift
        WIFI_NETWORK_NAME="$1"
        shift
        ;;
      -s|--show-password)
        SHOW_PASSWD="true"
        shift
        ;;
      -c|--change-password)
        CHANGE_PASSWD="true"
        shift
        NEW_PASSWD="$1"
        shift
        ;;
      -h|--help)
        info
        usage
        return
        ;;
        *)
        echo "Unknown arg: $1"
        return
        ;;
      esac
  done

  [[ -z $WIFI_NETWORK_NAME ]] && echo "need a wifi network name" && usage && return

  if [[ -n $SHOW_PASSWD ]] && [ $SHOW_PASSWD == "true" ]; then
    if [ "$(uname -a | cut -f 1 -d' ')" == "Darwin" ]; then
      security find-generic-password -wa "$WIFI_NETWORK_NAME"
    fi

    return
  fi

  if [[ -n $CHANGE_PASSWD ]] && [ $CHANGE_PASSWD == "true" ]; then
    if [ "$(uname -a | cut -f 1 -d' ')" == "Darwin" ]; then
      # 1. Delete old password from Keychain (replace "NetworkName" with your Wi-Fi name)
      security delete-generic-password -D "AirPort network password" -a "$WIFI_NETWORK_NAME" > /dev/null
  
      # 2. Connect to the network (prompts for new password, or use networksetup)
      networksetup -setairportnetwork en0 "$WIFI_NETWORK_NAME" "$NEW_PASSWD"
    fi
  fi

}

function c2r {
    #https://unix.stackexchange.com/questions/84951/copy-markdown-input-to-the-clipboard-as-rich-text
    pbpaste | pandoc -sf markdown+smart --template=custom-template.rtf -t rtf | pbcopy
}

function rot13 {
  tr 'A-Za-z' 'N-ZA-Mn-za-m'
}
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

  local method_discovered
  method_discovered=$($(which grep) -n "$PATTERN(" "$FILENAME")
  local start_line
  start_line=$(echo "$method_discovered" | cut -d':' -f 1)

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
  alias ls='/bin/ls'
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
    git checkout "$1" && glb main && gst
}

function gcob {
    git checkout -b "$1" && glb main
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
alias gs="git status"
alias gssh="ssh-keygen -t ed25519 -C 'zfolwick@gmail.com'"

##text editor aliases
function v {
    vim "$@"
}

function vf {
    vim $(fzf)
}

function e {
  case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
      linux*)
    printf 'emacs alias not implemented for linux\n'
      ;;
    darwin*)
      /opt/homebrew/bin/emacs "$@"
    ;;
    msys*|cygwin*|mingw*)
    # or possible 'bash on windows'
    printf 'emacs alias not implemented for windows-adjacent bash implementations\n'
      ;;
    nt|win*)
      printf 'emacs alias not implement for windows OS\n'
      # ubuntu via WSL Windows Subsystem for Linux
      export WHOME="/mnt/c/Users/zfolw/"
      ;;
    *)
    printf 'unknown OS\n'
      ;;
  esac
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

# Keep this in case it's useful. It does nothing right now, but jeepers it's been helpful.
# case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
#     linux*)
#   printf 'linux\n'
#     ;;
#   darwin*)
#   printf 'darwin\n'
#   ;;
#   msys*|cygwin*|mingw*)
#   # or possible 'bash on windows'
#   printf 'windows\n'
#     ;;
#   nt|win*)
#     printf 'windows\n'
#     # ubuntu via WSL Windows Subsystem for Linux
#     export WHOME="/mnt/c/Users/zfolw/"
#     ;;
#   *)
#   printf 'unknown\n'
#     ;;
# esac


export EDITOR="vim"  # for ctrl-x ctrl-e

ws() { curl -s https://zfolwick.github.io/$1 | xq 
}

wstxt() { curl -s "$1" | xq -x '*/body/*[not(self::script)]'
}
echo done
