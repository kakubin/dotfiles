-- vim.cmd('source ' .. os.getenv('HOME') .. '/.vimrc')
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.number = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 9

vim.opt.cursorline = true

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

vim.keymap.set('n', '<C-B>', '<C-^>')

vim.cmd [[
nnoremap <silent> <C-H> :<C-u>tabprev<CR>
nnoremap <silent> <C-L> :<C-u>tabnext<CR>

noremap x "_x
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
nnoremap q: :q

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

function! RestoreRegister()
  let @+ = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @+
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
]]

require('plugin')
