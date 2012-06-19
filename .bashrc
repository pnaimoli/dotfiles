#-------------------
# stty and inputs
#-------------------

case "$-" in
*i*)
stty kill undef
bind -f ~/.inputrc
stty erase ^?
esac

#-------------------
# Options
#-------------------

set -o pipefail
shopt -s expand_aliases
shopt -s checkwinsize
shopt -s no_empty_cmd_completion

#-------------------
# Environment variables
#-------------------

export VIMDIR='~/.vim/'
export EDITOR='vim'
export CVSEDITOR='vim'
export MALLOC_OPTIONS='J'
export PYTHONDONTWRITEBYTECODE='1'
export PYTHONUNBUFFERED='1'
export LESSKEY='~/.lesskey'
export HISTIGNORE='&:[ \t]*:l:ll:history*'
export HISTTIMEFORMAT='%F %T '
export CVS_RSH="ssh"
export CLICOLOR="yes"
export LSCOLORS="DxGxFxdxCxDxDxhbadExEx";

#-------------------
# Personnal Aliases
#-------------------
alias g='grep'
alias p='pushd'
alias o='popd'
alias gub='grep --line-buffered'
alias h='history 25'
alias bc='bc -l'
alias j='jobs -l'
alias ls='ls -F'
alias la='ls -alF'
alias ll='ls -lF'
alias l='ll'
alias lll='ll'
alias llll='ll'
alias lllll='ll'
alias llllll='ll'
alias which='type -all'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias mkdir='mkdir -p'
alias R='R --no-save'
#http://askubuntu.com/questions/20530/how-can-i-find-the-location-on-the-desktop-of-a-window-on-the-command-line
alias winfo='xwininfo -id $(xprop -root | awk "/_NET_ACTIVE_WINDOW\(WINDOW\)/{print \$NF}")'
alias myxargs='tr "\n" "\0" | xargs -0'

# tailoring 'less'
alias  more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
export LESS='--ignore-case --hilite-unread  --window=-4 --LONG-PROMPT -R -X -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...' # Use this if lesspipe.sh exists.

umask 022

#--------------
# Magic
#--------------

#http://www.davidpashley.com/articles/xterm-titles-with-bash.html
#case "$TERM" in
#xterm*|rxvt*)
#    set -o functrace
#    trap 'echo -ne "\e]0;" `basename $PWD` "\007"' DEBUG
#    PS1="\e]0;\s\007$PS1"
#    ;;
#*)
#    ;;
#esac
#PROMPT_COMMAND='echo -ne "\e]0;" `basename $PWD` "\007"'

#---------------
# Shell Prompt
#---------------

red="\[\e[0;31m\]"
RED="\[\e[1;31m\]"
BLUE="\[\e[1;34m\]"
CYAN="\[\e[1;36m\]"
PURPLE="\[\e[1;35m\]"
NC="\[\e[0m\]"      # No Color

function TRAPEXIT()
{
    if [ "$TERM" == "xterm" ]
    then
        echo -e "\e[1;31mStop su'ing me!!\e[0m"
    fi
}
trap TRAPEXIT EXIT

function TRAPUSR2()
{
    source ~/.bashrc
}
trap TRAPUSR2 USR2

if [[ "$(whoami)" != "peter" ]]; then
    UNAME="\u@"
fi

export PS1="${PURPLE}[${RED}${UNAME}${CYAN}\h${PURPLE}]$NC \[\e[1;32m\]\w${NC} > "

#-----------------------------------
# File & strings related functions:
#-----------------------------------

# Find a file with a pattern in name:
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

# find pattern in a set of filesand highlight them:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function cuttail() # Cut last n lines in file, 10 by default.
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()         # swap 2 filenames around
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

