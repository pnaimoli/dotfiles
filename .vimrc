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
set timeoutlen=1000       " vvvvvvvvvv This and the line below are to make
set ttimeoutlen=0         " <Esc> in visual mode work immediately. Side Effects?
set vb                    " prevent bells from showing up
set wig=*.o,*.pyc         " Ignore these files for wildmenu completion
set wildmenu              " Better command-line completion
set wildmode=longest:list,full " Makes tab completion smarter
if exists("&wildignorecase")
    set wildignorecase        " Make tab completion case insensitive
endif
set winheight=3           " Never let a window be less than 3 lines
set winminheight=3        " Never let a window be less than 3 lines

if exists("+colorcolumn")
    "set tw=0                 " set to 80 for atl style line width
    "set wrap                  "  text wrapping w/ above
    set colorcolumn=81
endif

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

    au BufNewFile,BufRead *.{c,cpp,cc,he,h}   set ft=cpp
    au BufNewFile,BufRead *.{r,R}             set ft=r
    au BufNewFile,BufRead *.{sig,reg,freq}    set ft=config
    au BufNewFile,BufRead *.{conf,config}     set ft=config

    " Set up CPP specific autocommands
    au BufNewFile,BufRead *.{c,cpp,cc,he,h}   set ft=cpp
    au FileType c,cpp,cc,h,he setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
    " When entering a buffer, cd to the file's directory
    if isdirectory(expand('%:p:h'))
        autocmd BufEnter * silent! lcd %:p:h
        autocmd BufEnter * execute ':setlocal path=' . origpath . ',' .
\           substitute(substitute(expand('%:p:h'), '/src/.*', '/src', ''),
\                      ' ', '\\ ', 'g')
    endif

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
let g:alternateExtensions_cc = "h,h"
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

noremap <leader>w :set wrap!<CR>

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
" set cdpath=.,$HOME,$HOME/atl,$HOME/atl/src,/,/home

"Set up path to search for .h files
let origpath='.,/usr/local/include,/usr/include'
set path=origpath
" build -Ibuild/gccext -Ibuild/include -Irepo/build -Irepo/build/gccext -Irepo/build/include -I/usr/local/include

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
set background=dark       " hilight colors for a dark background
if has('gui_running')
    colorscheme advantage
    hi SpaceError guibg=#FF8800
    match SpaceError /\s\+$/
    if has("macunix")
    else
        set guifont=Fixed\ 13
    endif
else
    if has("macunix")
        set background=light
    endif
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
function! s:MyCommandT()
    set wildignore=*/conf/*,Doxygen*,linux*,fbsd8*,last*
    let srcdir = substitute(getcwd(), '/trunk\([^/]*\)/.*', '/trunk\1/', '')
    exe ":CommandT" srcdir
    set wildignore=''
endfun
noremap <silent> <leader>t :call <SID>MyCommandT()<CR>

""""""""""""""""""""""""""""""
" ====== PLUGIN OPTIONS ======
""""""""""""""""""""""""""""""

" === SyntaxAttr === "
" Displays the syntax highlighting attributes of the character under the cursor; including syntax group (and what it's linked to, if linked), foreground/background colors (name and numeric equivallent), bold, underline, etc.
noremap <leader>A :call SyntaxAttr()<CR>

" === Rainbow Parenthesis === "
noremap <leader>R :call rainbow_parenthesis#Toggle()<CR>

" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer] 
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
    if a:buffer == ''
        " No buffer provided, use the current buffer.
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        " A buffer number was provided.
        let buffer = bufnr(a:buffer + 0)
    else
        " A buffer name was provided.
        let buffer = bufnr(a:buffer)
    endif

    if buffer == -1
        echohl ErrorMsg
        echomsg "No matching buffer for" a:buffer
        echohl None
        return
    endif

    let last_buffer = bufnr('$')

    let delete_count = 0
    let n = 1
    while n <= last_buffer
        if n != buffer && buflisted(n)
            if a:bang == '' && getbufvar(n, '&modified')
                echohl ErrorMsg
                echomsg 'No write since last change for buffer'
                            \ n '(add ! to override)'
                echohl None
            else
                silent exe 'bdel' . a:bang . ' ' . n
                if ! buflisted(n)
                    let delete_count = delete_count+1
                endif
            endif
        endif
        let n = n+1
    endwhile

    if delete_count == 1
        echomsg delete_count "buffer deleted"
    elseif delete_count > 1
        echomsg delete_count "buffers deleted"
    endif

endfunction

"""""""""""""""""""""""""""""""""""""""
" ====== Better Buffer Switching ======
"""""""""""""""""""""""""""""""""""""""
function! BufSel(pattern)
    let buflist = []
    let bufcount = bufnr("$")
    let currbufnr = 1

    " assume if there's a /, then it's a path and just open it
    if (match(a:pattern, "/") > -1)
        exe ":bu " . a:pattern
        return
    endif

    while currbufnr <= bufcount
        if(buflisted(currbufnr))
            let currbufname = fnamemodify(bufname(currbufnr),":t")
            let curmatch = tolower(currbufname)
            let patmatch = tolower(a:pattern)
            if(match(curmatch, patmatch) > -1)
                call add(buflist, currbufnr)
            endif
        endif
        let currbufnr = currbufnr + 1
    endwhile
    if(len(buflist) > 1)
        for bufnum in buflist
            echo bufnum . ":      ". bufname(bufnum)
        endfor
        let desiredbufnr = input("Enter buffer number: ")
        if(strlen(desiredbufnr) != 0)
            exe ":bu ". desiredbufnr
        endif
    elseif (len(buflist) == 1)
        exe ":bu " . get(buflist,0)
    else
        echo "No matching buffers"
    endif
endfunction

command! -nargs=1 -complete=buffer Bs :call BufSel("<args>")

cabbr b Bs
cabbr bs Bs
