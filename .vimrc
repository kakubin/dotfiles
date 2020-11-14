"Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,ucs-bom,seuc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
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

set completeopt=menuone,popup
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
endfor

"set laststatus
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

augroup DeleteSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup ReloadVimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

set clipboard+=unnamed

set noswapfile

set number
syntax on
let g:mapleader = "\<Space>"
inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <C-w>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>j

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap ; :
nnoremap ,.  :<C-u>edit $MYVIMRC<CR>
"nnoremap ,s. :<C-u>source $MYVIMRC<CR>
nnoremap <Leader>git :!tig<CR>

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
  call dein#add('Yggdroot/indentLine')
  call dein#add('scrooloose/nerdtree')
  call dein#add('slim-template/vim-slim')
  "fzf brewを使ってインストールされている場合
  call dein#add('/usr/local/opt/fzf')
  call dein#add('junegunn/fzf.vim')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  "call dein#add('prabirshrestha/vim-lsp')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('vim-scripts/vim-auto-save')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('dense-analysis/ale')

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  "rails
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-endwise')
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

"plugin config================================
"vim-auto-save
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

"indentline"
"let g:indentLine_color_term =239
"let g:indentLine_color_gui = '#708090'
"let g:indentLine_char = '¦'

"ale
" 保存時のみ実行
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"NERDTree
nnoremap <silent><Leader>t :NERDTreeToggle<CR>

"FZF
nnoremap <Leader>ff :GFiles<CR>
nnoremap <Leader>fs :GFiles?<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
