" =====================================================
" KEYBINDINGS (in addition to vim defaults)
" =====================================================
" <Space> = <leader>
"
" Files / fzf
"   <leader>ff       Find file
"   <leader>fg       Grep across project (needs ripgrep)
"   <leader>fb       List buffers
"
" File tree (NERDTree)
"   <leader>e        Toggle NERDTree
"
" Misc
"   <leader><space>  Clear search highlight
" =====================================================

" Basic settings
set nocompatible
let mapleader = " "

" Search
set showmatch
set ignorecase
set hlsearch
set incsearch

" Tabs / indentation
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent

" Interface
set number relativenumber
set ttyfast

" Filetype + syntax
filetype plugin indent on
syntax on

" -----------------------------------------------------
" Plugins (vim-plug)
" Auto-install vim-plug on first run
" -----------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nordtheme/vim'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Colorscheme (silent — first run before plugins are installed)
silent! colorscheme nord

" Transparent backgrounds
hi NonText ctermbg=NONE guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=NONE ctermfg=NONE guibg=NONE

" -----------------------------------------------------
" Keybindings
" -----------------------------------------------------

" Misc
nnoremap <leader><space> :nohlsearch<CR>

" File tree (NERDTree)
nnoremap <leader>e :NERDTreeToggle<CR>

" Files / fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
