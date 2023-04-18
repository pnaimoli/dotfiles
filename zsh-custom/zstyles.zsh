zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# https://unix.stackexchange.com/a/567805
# Prevent http:// gopher:// ftp:// etc... from appearing when you
# tab-complete "open".
zstyle ':completion:*:*:open:*' tag-order '!urls'
