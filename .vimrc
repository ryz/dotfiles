" ---------------------------------
" .vimrc / 'Vim' configuration file 
" written by ryz                    
" last update: 2008-05-25 09:15
" latest changes/additions/removals:
" [+] mkview/loadview
" [=] -
" [-] -
" ---------------------------------


" ----------------
" General settings
" ----------------

filetype on " detect the type of file
set history=1000 " How many lines of history to remember
set nocompatible " dont emulate vi-behaviour
set mouse=nvi
set number " show line numbers
set cursorline
set nopaste
set shortmess=a

set hls " highlight search-pattern
set is " incremential search

" ----------------------
" theme/colors
" ----------------------

set background=dark
syntax on " syntax highlighting 
"colorscheme metacosm 

" ----------------------
" text formatting/layout
" ----------------------

set ai " autoindent
set si " smartindent
set ci 
set expandtab " use spaces in place of tabs.
set tabstop=8 " number of spaces for a tab.
set softtabstop=4 " number of spaces for a tab in editing operations.
set shiftwidth=4 " number of spaces for indent (>>, <<, ...)


set ruler " show the cursor position all the time 

au BufWinLeave * mkview " save fold/view state on exit
au BufWinEnter * silent loadview " silently reload saved view state

" ------------
" key bindings
" ------------

"" tabs

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
