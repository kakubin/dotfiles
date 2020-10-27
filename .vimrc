set nocompatible
set wildmenu

set expandtab
set autoindent
set smartindent
set smarttab
set softtabstop=2
set shiftwidth=2
set tabstop=2

set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

set number
let mapleader = "¥<Space>"
inoremap <silent> jj <ESC>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
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
