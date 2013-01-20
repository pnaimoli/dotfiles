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
shopt -s cmdhist

#-------------------
# Environment variables
#-------------------

#export BASH_ENV='~/.bashrc' # so piping to 'bash' doesn't require 'bash -l'
export VIMDIR='~/.vim/'
export EDITOR='vim'
export CVSEDITOR='vim'
export MALLOC_OPTIONS='J'
export PYTHONDONTWRITEBYTECODE='1'
export PYTHONUNBUFFERED='1'
export LESSKEY='~/.lesskey'
export HISTIGNORE='&: *:l:ll:history*:ls:cd:clear:..:...:....:p:dirs:1:2:3:4:5:6:7:8:9'
export HISTTIMEFORMAT='%F %T '
export CVS_RSH="ssh"
export CLICOLOR="yes"
export LSCOLORS="DxGxFxdxCxDxDxhbadExEx";

#-------------------
# Personnal Aliases
#-------------------
alias vi='vim'
alias sb='source ~/.bashrc'
alias g='egrep --color=auto'
alias p='popd'
alias gub='grep --line-buffered'
alias h='history 25'
alias bc='bc -l'
alias j='jobs -l'
alias ls='\ls -F'
alias la='\ls -alF'
alias ll='\ls -lF'
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
alias d='dirs -v'
alias 1='cd `dirs -l +1`; dirs -v'
alias 2='cd `dirs -l +2`; dirs -v'
alias 3='cd `dirs -l +3`; dirs -v'
alias 4='cd `dirs -l +4`; dirs -v'
alias 5='cd `dirs -l +5`; dirs -v'
alias 6='cd `dirs -l +6`; dirs -v'
alias 7='cd `dirs -l +7`; dirs -v'
alias 8='cd `dirs -l +8`; dirs -v'
alias 9='cd `dirs -l +9`; dirs -v'
alias 10='cd `dirs -l +10`; dirs -v'
alias 11='cd `dirs -l +11`; dirs -v'
alias 12='cd `dirs -l +12`; dirs -v'
alias 13='cd `dirs -l +13`; dirs -v'
alias 14='cd `dirs -l +14`; dirs -v'
alias 15='cd `dirs -l +15`; dirs -v'
alias 16='cd `dirs -l +16`; dirs -v'
alias 17='cd `dirs -l +17`; dirs -v'
alias 18='cd `dirs -l +18`; dirs -v'
alias 19='cd `dirs -l +19`; dirs -v'
alias R='R --no-save'
#http://askubuntu.com/questions/20530/how-can-i-find-the-location-on-the-desktop-of-a-window-on-the-command-line
alias winfo='xwininfo -id $(xprop -root | awk "/_NET_ACTIVE_WINDOW\(WINDOW\)/{print \$NF}")'
alias myxargs='tr "\n" "\0" | xargs -0'
alias shuf="perl -MList::Util=shuffle -e'print shuffle<>'"
alias findvis="find . \( ! -regex '.*/\..*' \)"

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

red=$'\e[0;31m'
RED=$'\e[1;31m'
BLUE=$'\e[1;34m'
CYAN=$'\e[1;36m'
PURPLE=$'\e[1;35m'
GREEN=$'\e[1;32m'
NONE=$'\e[0m'

function TRAPEXIT()
{
#    if [ "$TERM" == "xterm" ]
#    then
#        echo -e "\e[1;31mStop su'ing me!!\e[0m"
#    fi
}
trap TRAPEXIT EXIT

function TRAPUSR2()
{
    source ~/.bashrc
}
trap TRAPUSR2 USR2

if [[ "$(whoami)" != "peter" ]]; then
    UNAME=$'\u@'
fi

#export PS1="${get_exit_status}${PURPLE}[${RED}${UNAME}${CYAN}\h${PURPLE}]$NC \[\e[1;32m\]\w${NC} > "
export PS1='`if [ $? -eq 0 ];then echo -n "\[${GREEN}\]^_^";else echo -n "\[${RED}\]x_x";fi;echo -n "\[${PURPLE}\][\[${RED}\]"; if [[ "$(whoami)" != "peter" ]]; then echo -n "\[${RED}\]\u@"; fi; echo -n "\[${CYAN}\]\h\[${PURPLE}\]] \[${GREEN}\]\w\[${NONE}\] > "`'


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

function cd()
{
   MAX=20
   LEN=${#DIRSTACK[@]}

   if [ $# -eq 0 ] || [ "$1" = "-" ]; then
      builtin cd "$@"
      pushd -n $OLDPWD > /dev/null
   else
      pushd "$@" > /dev/null || return 1
   fi

   if [ $LEN -gt 1 ]; then
      for i in `jot - 1 $LEN`; do
         eval p=~$i
         if [ "$p" = "$PWD" ]; then
            popd -n +$i > /dev/null
            break
         fi
      done
   fi

   if [ $LEN -ge $MAX ]; then
      popd -n -0 > /dev/null
   fi
}

# https://chris-lamb.co.uk/2010/04/22/locating-source-any-python-module/
function cdp () {
cd "$(python -c "import sys, imp, os
path = sys.path
for i in '${1}'.split('.'): path = [imp.find_module(i,path)[1],]
path = path[0] if os.path.isdir(path[0]) else os.path.dirname(path[0])
print path")"
}
