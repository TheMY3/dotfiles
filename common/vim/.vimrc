" Vim Configuration based on Neovim setup
" Created: March 15, 2025

" Basic Settings
set nocompatible

" Set leader key to space (matching Neovim config)
let mapleader = " "

" Search and highlighting
set showmatch
set ignorecase
set hlsearch
set incsearch

" Tab and indentation settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

" Interface
set number relativenumber

" File type support and syntax highlighting
filetype plugin indent on
syntax on
filetype plugin on

" Optimization
set ttyfast

" UI customization (remove background for some elements)
hi NonText ctermbg=NONE guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=NONE ctermfg=NONE guibg=NONE

" Custom mappings
nnoremap <Leader><space> :nohlsearch<CR>