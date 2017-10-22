setopt pipefail # false | true should return false
setopt ignoreeof # Ctrl-D shouldn't close the current window
setopt menu_complete # So autocomplete automatically inserts the first result
setopt nolistbeep # No beep if there are multiple autocomplete results
setopt list_rows_first
bindkey -M menuselect '^M' .accept-line # So I don't have to hit Enter twice
                                        # after an autocomplete
