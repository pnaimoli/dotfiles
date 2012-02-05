if v:version < 700
  echoerr 'This .vimrc requires Vim 7 or later.'
  quit
endif

let $VIMRC = '~/.vimrc'   " for portability
set nocompatible          " use VIM as VIM, not VI

syntax on                 " enable default syntax highlighting
filetype on               " enable filetype detection

set autoread              " auto read when a file is changed outside
set background=dark       " hilight colors for a dark background
set backspace=2           " Allow backspacing over indents, line breaks, and start of insert
set guioptions-=m         " remove menu bar
set guioptions+=LlRrb     " remove scrollbars - For some reason this hack
set guioptions-=LlRrb     "  is necessary
set guioptions-=T         " remove toolbar
set hid                   " don't auto-remove hidden buffers
set history=50            " 50 commands stored in history
set hlsearch              " highlight all search pattern matches
set incsearch             " incremental search
set isk+=%,#              " none of these should be word dividers
set linebreak             " enable smart linebreaking
set matchtime=0           " prevent matching delay
set ic                    " force case-sensitive
set nu                    " show line numbers
set nomousehide           " OMG FBSD8 BUG!!!!!!!
set scrolloff=2           " keep 2 lives visible above/below the cursor
set shortmess+=IA         " suppress intro and swap file messages
set showbreak=>>          " show a > at each broken line
set showcmd               " show command on last line
set showmatch             " briefly jump to matching bracket when bracket inserted
set showmode              " show mode
set smartcase             " overrides ignorecase if uppercase used
"set tw=80                 " 80 character width
"set wrap                  "  text wrapping w/ above
set wig=*.o,*.pyc         " Ignore these files for wildmenu completion
set wildmenu              " Better command-line completion
set wildmode=longest:full " Makes tab completion smarter
set winheight=3           " Never let a window be less than 3 lines
set winminheight=3        " Never let a window be less than 3 lines

set autoindent            " indent like the last line, by default
set cindent               " indent for c syntax
set cinkeys-=0#           " I should look up what this does again
set cinoptions+=g2        " indent scope declarations by 2
set cinoptions+=h2        " indent statements after scope declarations by 2
set expandtab             " expand tabs to spaces
set shiftwidth=4          " basic indents = 4 spaces
set smarttab              " delete shifted spaces as if they were tabs
set tabstop=4             " tabs = 4 spaces

""""""""""""""""""""""""""""""""""
" ===== Auto command section =====
""""""""""""""""""""""""""""""""""
if has('autocmd')
    augroup vimrc
    au!
    " Set up CPP specific autocommands
    au FileType c,cpp,cc setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://

    au BufRead,BufNewFile *.{c,cpp,cc,he,h}   set ft=cpp
    au BufNewFile,BufRead *.{r,R}             set ft=r
    au BufNewFile,BufRead *.{sig,reg,freq}    set ft=config
    au BufNewFile,BufRead *.{conf,config}     set ft=config

    " When entering a buffer, cd to the file's directory
    autocmd BufEnter * :cd %:p:h

    " Magic!!!
    autocmd FuncUndefined * exe 'runtime autoload/' . expand('<afile>') . '.vim'

    " Auto source the vimrc file when it is saved
    au! BufWritePost [\._]vimrc source $VIMRC

    augroup END
endif

""""""""""""""""""""""""""""""""""
" ===== Fast Window Resizing =====
""""""""""""""""""""""""""""""""""
nmap + <C-W>+
nmap - <C-W>-

"""""""""""""""""""""""""""""""
" ===== Nice Window Title =====
"""""""""""""""""""""""""""""""
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif

""""""""""""""""""""""""""""""""""""""
" ===== Set up makeprg for scons =====
""""""""""""""""""""""""""""""""""""""
"set makeprg=/usr/local/bin/scons\ -j8\ -u\ \.
"function! Compile()
"    cd $HOME/training
"    make
"endfunction
"noremap <F9> :call Compile()<CR>
"imap <F9> <C-O><F9>

""""""""""""""""""""""""""""""""""""""""""""""""""
" ===== TODO: Organize this at a later point =====
""""""""""""""""""""""""""""""""""""""""""""""""""
" switch between .h and .cc file Easily
map <F2> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>
" map <F3> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>

" supress cursor blinking
" set guicursor+=a:blinkon0

" super paste
"inoremap <C-V> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
vnoremap <S-C> "+y

"nnoremap <silent> xx <Del>
"nnoremap <silent> xc xph
"nnoremap <silent> xw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>:nohlsearch<CR>
"nnoremap <silent> xb "_yiw:.s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

" Set up directories to search when cd'ing
set cdpath=.,$HOME,$HOME/atl,$HOME/atl/src,/,/home

"Set up path to search for .h files
set path=.,$HOME/projects/atl/src,$HOME/projects/atl/fbsd7/include,$HOME/projects/atrade/src

" Load filetype plugins
filetype plugin on

" Also, set our tags path to be useful
" find projects/atl/src projects/btrade/src -name "*.cc" -print -or -name "*.h" -print | etags -
set tags=$HOME/.TAGS

" easy key to pop back from looking at a tag
" noremap <silent> <C-[> :pop<CR>

" set up align =
nmap ,= :Align =<CR>
vmap ,= :Align =<CR>

"""""""""""""""""""""""""""""""""""""""
" ===== Status Line configuration =====
"""""""""""""""""""""""""""""""""""""""
set laststatus=2                           " always show a status line
set statusline=
set statusline+=%2*%-3.3n%0*               " buffer number
set statusline+=%1*%f%0*                   " filename
set statusline+=%h%5*%m%r%w%0*             " flags
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}]            " file format
set statusline+=%=                         " right align
set statusline+=%2*0x%-8B\                 " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P      " offset

""""""""""""""""""""""""""""""""""
" ===== Edit & Reload .vimrc =====
""""""""""""""""""""""""""""""""""
nmap ,s :source $VIMRC
nmap ,e :e $VIMRC

"""""""""""""""""""""""""""""""""""""""
" ===== Visually pleasing effects =====
"""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    colorscheme advantage
    hi SpaceError guibg=#FF8800
    match SpaceError /\s\+$/
    set guifont=Fixed\ 13
endif

" highlight FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
" highlight Folded      gui=italic  guifg=Black      guibg=Grey90
"highlight LineNr      gui=NONE    guifg=grey60     guibg=Grey90

" display tabs so it's easily visible
set list listchars=tab:\|_

""""""""""""""""""""""""""""""""""
" ===== Windows Style Saving =====
""""""""""""""""""""""""""""""""""
map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
imap <c-s> <c-o><c-s>

""""""""""""""""""""""""""""
" ===== Switching tabs =====
""""""""""""""""""""""""""""
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"""""""""""""""""""""""""""""""""""""""""
" ===== Alternative navigation keys =====
"""""""""""""""""""""""""""""""""""""""""
set whichwrap+=<,>,[,]
map j gj
map k gk

map <up> gk
imap <up> <C-O><up>
map <down> gj
imap <down> <C-O><down>

""""""""""""""""""""""""""""""""""
" ===== Commenting utilities =====
"""""""""""""""""""""""""""""""""
map <silent> ,# :s/^/#/<CR>
map <silent> ,/ :s/^/\/\//<CR>
map <silent> ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>

"""""""""""""""""""""""""""""""""""""
" ====== Smart home navigation ======
"""""""""""""""""""""""""""""""""""""
fun! s:SmartHome()
    if col('.') != match(getline('.'), '\S')+1
        norm g^
    else
        norm g0
    endif
endfun
noremap <silent> <home> :call <SID>SmartHome()<CR>
imap <home> <C-O><home>

""""""""""""""""""""""""""
" ===== Code folding =====
""""""""""""""""""""""""""
set foldmethod=syntax

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]\(.*\)*$', '\1{', 'g')
    "if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', ' ... }\1', 'g')
      endif
    "endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

vnoremap ;bc "ey:call CalcBC()<CR>
function! CalcBC()
  let has_equal = 0
  " remove newlines and trailing spaces
  let @e = substitute (@e, "\n", "", "g")
  let @e = substitute (@e, '\s*$', "", "g")
  " if we end with an equal, strip, and remember for output
  if @e =~ "=$"
    let @e = substitute (@e, '=$', "", "")
    let has_equal = 1
  endif
  " sub common func names for bc equivalent
  let @e = substitute (@e, '\csin\s*(', "s (", "")
  let @e = substitute (@e, '\ccos\s*(', "c (", "")
  let @e = substitute (@e, '\catan\s*(', "a (", "")
  let @e = substitute (@e, "\cln\s*(", "l (", "")
  " escape chars for shell
  let @e = escape (@e, '*()')
  " run bc, strip newline
  let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
  " append answer or echo
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echo "answer = " . answer
  endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""
" ===== To save current state on exit ===== "
"""""""""""""""""""""""""""""""""""""""""""""
"au vimrc BufWinLeave ?* mkview
"au vimrc BufWinEnter ?* silent loadview

""""""""""""""""""""""""""""""
" ====== PLUGIN OPTIONS ======
""""""""""""""""""""""""""""""

" === SyntaxAttr === "
noremap ,a :call SyntaxAttr()<CR>

" === Rainbow Parenthesis === "
command! Rain :call rainbow_parenthesis#Toggle()

" === SuperTab
" http://www.vim.org/scripts/script.php?script_id=1643
" Use the tab key to do insert completion
" let g:SuperTabDefaultCompletionTypeDiscovery = "&omnifunc:<C-X><C-O>,&completefunc:<C-X><C-U>"

" === OmniCppComplete
" http://www.vim.org/scripts/script.php?script_id=1520
" Complete symbol names using tags database
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" === TagList
" http://vim-taglist.sourceforge.net/
" Source code browser that shows tags in a source file
"let Tlist_Auto_Highlight_Tag = 1
"let Tlist_Auto_Open = 0
"let Tlist_Show_One_File = 1
"let Tlist_Display_Prototype = 1
"noremap <silent> <F10> :TlistToggle<CR>

" === MiniBufExpl
" http://vim.sourceforge.net/scripts/script.php?script_id=159
" Show open buffers along the top to enable quick switching of buffers
" let g:miniBufExplMapCTabSwitchWindows = 1
" let g:miniBufExplMapWindowNavVim = 1

" === Source Explorer
"let g:SrcExpl_refreshTime = 300
"let g:SrcExpl_winHeight = 9
"let g:SrcExpl_updateTags = 0
"let g:SrcExpl_refreshKey = 0
"let g:SrcExpl_gobackKey = "<C-b>"
" let g:SrcExpl_searchLocalDef = 1
" // In order to Aviod conflicts, the Source Explorer should know
" // what plugins are using buffers. And you need add their bufnames
" // into the list below according to the command ":buffers!"
"  let g:SrcExpl_pluginList = [
"         \ "__Tag_List__",
"         \ "_NERD_tree_",
"         \ "-MiniBufExplorer-",
"         \ "Source_Explorer"
"    \ ]

"nmap <F11> :SrcExplToggle<CR>

" === NERDTree
" http://www.vim.org/scripts/script.php?script_id=1658
" File system explorer
"noremap <silent> <F12> :NERDTreeToggle $HOME/atl/src<CR>
"let NERDTreeWinPos = "right"

" === Toggle_words
"imap <C-T> <C-O>:ToggleWord<CR>
"nmap <C-T> :ToggleWord<CR>
"vmap <C-T> <ESC>:ToggleWord<CR>

" ======== Other helpful plugins without customization ========
" a.vim - switches between .cc and .h files
" cscope_maps.vim - CScope mappings
" doxygen-support.vim - doxygen comment templates
" vcscvs + vcscommand  - cvs integration
