if v:version < 700
  echoerr 'This .vimrc requires Vim 7 or later.'
  quit
endif

call pathogen#infect()
call pathogen#helptags()

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
set history=1000          " 1000 commands stored in history
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
set tw=0                  " set to 80 for atl style line width
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
let g:alternateExtensions_cc = "he,h"
let g:alternateExtensions_h = "cc,c"
let g:alternateExtensions_he = "cc,c"
let g:alternateRelativeFiles = 1
noremap <silent> <F2> :A<CR>

" supress cursor blinking
" set guicursor+=a:blinkon0

" super paste
"inoremap <C-V> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
vnoremap <S-C> "+y

" default is '\', I prefer ','
let mapleader=','

" wow I'm lazy
noremap ; :
noremap : ;

" be consistent with C and D
nnoremap Y y$

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" jon likes this
" nnoremap n nzz

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
nnoremap <leader>= :Align =<CR>
vnoremap <leader>= :Align =<CR>

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
nnoremap <leader>s :source $VIMRC
nnoremap <leader>e :e $VIMRC

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
noremap <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
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

" Wrapped lines goes down/up to next row, rather than next line in file.
map j gj
map k gk
map <up> k
imap <up> <C-O><up>
map <down> j
imap <down> <C-O><down>

""""""""""""""""""""""""""""""""""
" ===== Commenting utilities =====
"""""""""""""""""""""""""""""""""
noremap <silent> <leader>a :noh<CR>
" these need to be functions because ranges are not allowed with 'let' commands
fun! s:CoolComment(chars)
    let @@=@/
    exe "s@^@".a:chars."@"
    let @/=@@
endfun
fun! s:ClearComment()
    let @@=@/
    try
        exe "s@^//\\|^--\\|^> \\|^[#\"%!;]@@"
    catch
    endtry
    let @/=@@
endfun
noremap <silent> <leader># :call <SID>CoolComment("#")<CR>
noremap <silent> <leader>" :call <SID>CoolComment("\"")<CR>
noremap <silent> <leader>/ :call <SID>CoolComment("//")<CR>
noremap <silent> <leader>c :call <SID>ClearComment()<CR>

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

"""""""""""""""""""""""""""""""""""""
" ====== Abbreviations ======
"""""""""""""""""""""""""""""""""""""
" Could be in after/ftplugin/cpp.vim
iab intmain int main (int argc, char **argv) {<CR>x;<CR>return 0;<CR>}<CR><C-O>?x;<CR><Del><Del>
iab #d #define
iab #i #include <><Left>
iab #I #include ""<Left>

"""""""""""""""""""""""""""""""""""""""""""""
" ===== To save current state on exit ===== "
"""""""""""""""""""""""""""""""""""""""""""""
"au vimrc BufWinLeave ?* mkview
"au vimrc BufWinEnter ?* silent loadview

"""""""""""""""""""""""""""""""""""""""""""""
" ===== CommandT stuff ===== "
"""""""""""""""""""""""""""""""""""""""""""""
fun! s:MyCommandT()
    let srcdir = substitute(getcwd(), "/src/.*", "/src", "")
    exe ":CommandT" srcdir
endfun
noremap <silent> <leader>t :call <SID>MyCommandT()<CR>
noremap <silent> <leader>t<CR> :call <SID>MyCommandT()<CR>

""""""""""""""""""""""""""""""
" ====== PLUGIN OPTIONS ======
""""""""""""""""""""""""""""""

" === SyntaxAttr === "
" Displays the syntax highlighting attributes of the character under the cursor; including syntax group (and what it's linked to, if linked), foreground/background colors (name and numeric equivallent), bold, underline, etc.
noremap <leader>A :call SyntaxAttr()<CR>

" === Rainbow Parenthesis === "
noremap <leader>R :call rainbow_parenthesis#Toggle()<CR>


