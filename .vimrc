" ---------------------------------
" .vimrc / 'Vim' configuration file 
" written by ryz                    
" last update: 2011-01-24
" latest changes/additions/removals:
" [+] backupdir, cross-os/(no)gui config
" [=] -
" [-] auto save buffer
" ---------------------------------


" General settings {{{
" ----------------

filetype on " detect the type of file
set history=1000 " How many lines of history to remember
set nocompatible " dont emulate vi-behaviour
set mouse=a " enable mouse support (all modes) 
set number " show line numbers
set cursorline " show cursor line (colorscheme dependent)
set nopaste " not in paste mode per default
set shortmess=a

set backspace=2 " make backspace work like most other apps; same as 'backspace=indent,eol,start'

set hls " highlight search-pattern
set is " incremential search

set pdev=canon4300 " printer setting

set backup " make backup files


" set backup-dirs

if has ("unix")
set backupdir=~/.vim/backup " where to put backup files
set directory=~/.vim/tmp " where to put swap (.swp) files

elseif has ("win32")
set backupdir=$TEMP " where to put backup files
set directory=$TEMP " where to put swap (.swp) files

endif

set fileformats=unix,dos,mac " support all three, in this order

" }}}

" theme/colors {{{
" ----------------------

set background=dark
syntax on " syntax highlighting 

if has ("gui_running")
    colorscheme desert " nice darkish, stadard GUI theme
    else
        colorscheme ir_black " not a standard theme?
endif

set t_Co=256

" }}}

" status bar {{{
" ----------------------

set statusline=%F%m%r%h%w\ [%{&ff}][%Y]\ [ascii=\%03.3b]\ [hex=\%02.2B]\ [pos=%04l,%04v][%p%%]\ [ln=%L] 
set laststatus=2 " always show status line 

" }}}

" folding {{{
" ----------------------
set foldenable " turn on folding
set foldmethod=marker " fold on marker

" }}}

" text formatting/layout {{{
" ----------------------

set ai " autoindent
set si " smartindent
set ci 
set expandtab " use spaces in place of tabs.
set tabstop=8 " number of spaces for a tab.
set softtabstop=4 " number of spaces for a tab in editing operations.
set shiftwidth=4 " number of spaces for indent (>>, <<, ...)


set ruler " show the cursor position all the time 

"au BufWinLeave * mkview " save fold/view state on exit
"au BufWinEnter * silent loadview " silently reload saved view state

" }}}

" key bindings {{{
" ------------

" time and date via F3

nmap <F3> a<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

" tabs

map <S-h> gT
map <S-l> gt
map tn :tabnew<CR>
map td :tabclose<CR>

" programming

" auto-insert opening and closing characters

" imap <C-F> {<CR>}<C-O>O " deprecated alternative

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap "      ""<Left>
inoremap ""     "

inoremap '      ''<Left>
inoremap ''     '

" }}}

" gui settings {{{
" ------------
if has ("gui_running")

    " everything GUI-related that was not defined earlier
    set guifont=Dina:h8:cANSI " not a standard font

endif

" EOF
