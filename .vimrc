set wildmenu
"set wildmode=list:longest
set autoread
set hidden

"Indent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set smarttab
set expandtab

"Search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

augroup space
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

set number
syntax on
let mapleader = "¥<Space>"
inoremap <silent> jj <ESC>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

" dein.plugin manager================================
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add(s:dein_repo_dir)
  call dein#add('slim-template/vim-slim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim')
  "call dein#add('prabirshrestha/vim-lsp')
  "call dein#add('mattn/vim-lsp-settings')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('doums/darcula')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  "call dein#add('cocopon/iceberg.vim')
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('roxma/nvim-yarp')
  "call dein#add('roxma/vim-hug-neovim-rpc')
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

syntax enable
colorscheme darcula
let g:auto_save = 1
