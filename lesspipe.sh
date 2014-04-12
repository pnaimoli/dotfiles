case "$1" in
   # add all extensions you want to handle here
   *.awk|*.groff|*.java|*.js|*.m4|*.php|*.pl|*.pm|*.pod|*.sh|\
   *.ad[asb]|*.asm|*.inc|*.[ch]|*.[ch]pp|*.[ch]xx|*.cc|*.hh|\
   *.lsp|*.l|*.pas|*.p|*.xml|*.xps|*.xsl|*.axp|*.ppd|*.pov|\
   *.diff|*.patch|*.py|*.rb|*.sql|*.ebuild|*.eclass)
      pygments-main/pygmentize "$1" ;;
   *.conf)
      pygments-main/pygmentize -l ini "$1" ;;
   *.sched)
      pygments-main/pygmentize -f 256 -O style=monokai "$1" ;;
   *) exit 0;;
esac
