set nocompatible

syntax enable
set backspace=indent,eol,start
set number relativenumber
"The default leader is \, but comma is mutch better
let mapleader = ','	
"No damn bells!
set noerrorbells visualbell t_vb=
"Automatically write the file when switching buffers.
set autowriteall
"Set our desired authocompletion matching.
set complete=.,w,b,u
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set dir-=.
set dir+=/tmp
set shell=bash
"Set global clipboard
"set clipboard=unnamed
set clipboard+=unnamedplus

"------------Visuals-------------"
set background=dark
set t_CO=256				"Useful for Terminal Vim
"set guifont=MonacoB\ Italic\ 10
"set guifont=Operator\Mono\ weight=330\ 10
"set guifont=Inconsolata\ LGC\ Medium\ Italic\ 10
"set guifont=Inconsolata\ LGC\ Medium\ 10
set guifont=Fira\ Mono\ for\ Powerline\ Italic\ 10
set linespace=13
set guioptions-=e			"We don`t want Gui tabs.

set guioptions-=l			"Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
"set guioptions-=m
"set guioptions-=T guioptions-=m                                "hide tool and menu bar

"Get rid of ugly split borders.
hi vertsplit guifg=bg guibg=bg

"------------Search-------------"
set hlsearch
set incsearch
set ignorecase

"------------Split Management-------------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"------------Mappings-------------"

"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

nmap vs :vsplit<CR>
nmap sp :split<CR>
"------------Plugins-------------"


" Notes and Tips
" - Press 'zz' to instantly center the line where cursor is located.
" - 'tn' - next tag, 'tp' - previous tag, 'ts' - all matches
" - '<C-]> - where method was defined, <C-^> - to previous location
" - :Gsearch , then :s/Find/Replace, select in visual mode, Greplace, :wo - to save all files