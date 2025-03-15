vim.g.mapleader = ","

-- Disable compatibility with vi
vim.cmd('set nocompatible')

-- Search and highlighting
vim.cmd('set showmatch')
vim.cmd('set ignorecase')
vim.cmd('set hlsearch')
vim.cmd('set incsearch')

-- Tab and indentation settings
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')
vim.cmd('set expandtab')
vim.cmd('set shiftwidth=4')
vim.cmd('set autoindent')

-- Interface
vim.cmd('set number relativenumber')
vim.cmd('set mouse=a')
vim.cmd('set clipboard=unnamedplus')

-- File type support and syntax highlighting
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.cmd('filetype plugin on')

-- Optimization
vim.cmd('set ttyfast')

-- UI customization (remove background for some elements)
vim.cmd [[
    hi NonText ctermbg=none guibg=NONE
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
    hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
    hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
    hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
    hi TabLine ctermbg=None ctermfg=None guibg=None
]]

require("config.lazy")
