local vim = vim
local Plug = vim.fn['plug#']

vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

vim.call('plug#begin')
Plug('joshdick/onedark.vim')
Plug('vim-airline/vim-airline')
Plug('vim-airline/vim-airline-themes')
vim.call('plug#end')

vim.cmd('silent! colorscheme onedark')

-- vim.g.airline.extensions.tabline.formatter = 'default'
