"Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

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

"augroup delete space
"  autocmd!
"  autocmd BufWritePre * :%s/\s\+$//e
"augroup END

" auto reload .vimrc
"augroup source-vimrc
"  autocmd!
"  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
"  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
"augroup END

set clipboard+=unnamed

set number
syntax on
let mapleader = "¥<Space>"
inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk

" dein.plugin manager================================
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add(s:dein_repo_dir)
  "document
  call dein#add('vim-jp/vimdoc-ja')
  "style
  call dein#add('doums/darcula')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  call dein#add('scrooloose/nerdtree')

  "fzf brewを使ってインストールされている場合
  call dein#add('/usr/local/opt/fzf')
  call dein#add('junegunn/fzf.vim')

  call dein#add('airblade/vim-gitgutter')
  "call dein#add('prabirshrestha/vim-lsp')
  "call dein#add('mattn/vim-lsp-settings')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
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

"plugin config
"vim-auto-save
let g:auto_save = 1

