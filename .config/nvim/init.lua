-- vim.cmd('source ' .. os.getenv('HOME') .. '/.vimrc')
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.number = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>')

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = " "

require('plugin')
