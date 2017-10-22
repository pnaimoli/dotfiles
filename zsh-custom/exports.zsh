# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

export LESS='--ignore-case --hilite-unread --window=-4 --LONG-PROMPT -R -X -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...' # Use this if lesspipe.sh exists.
