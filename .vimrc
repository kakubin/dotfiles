" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,ucs-bom,seuc-jp,iso-2022-jp,cp932,euc-jp,sjis,utf-8 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set wildmenu
" set wildmode=list:longest
set autoread
set hidden
set mouse=a
set ttimeoutlen=150

" Indent
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
" set smarttab
set expandtab

" Search
set ignorecase
set smartcase
set wrapscan
set nowrap
set incsearch
set hlsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><ESC>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set complete=.,w,b,u,U,s,i,d,t
set completeopt& completeopt+=menuone completeopt+=noinsert completeopt-=preview
" for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
" endfor

" set laststatus
set cursorline
augroup CursorLine
  autocmd!
  autocmd InsertEnter,InsertLeave * set cursorline!
augroup END

augroup DeleteSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

augroup ReloadVimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

set clipboard=unnamedplus clipboard+=unnamed

set noswapfile
set number
set belloff=all

" fold by indent
set foldmethod=indent
set foldlevel=9

syntax on
let g:mapleader = "\<Space>"
nnoremap j gj
nnoremap k gk
nnoremap <C-w>v <C-w>v<C-w>l
nnoremap <C-w>s <C-w>s<C-w>j
nnoremap Y y$
nnoremap $ g_

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

inoremap <expr><Tab>   pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<Up>" : "\<S-Tab>"

nnoremap ,.  :<C-u>edit $MYVIMRC<CR>
nnoremap ,s. :<C-u>source $MYVIMRC<CR>

nnoremap <silent> <Leader>bp :<C-u>bprevious<CR>
nnoremap <silent> <Leader>bn :<C-u>bnext<CR>
nnoremap <silent> <C-H> :<C-u>tabprev<CR>
nnoremap <silent> <C-L> :<C-u>tabnext<CR>
nnoremap <C-B> <C-^>

cnoremap <C-p> <Up>
noremap x "_x
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'
nnoremap q: :q

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

function! s:path2project_directory_git(path) abort
  let parent = a:path

  while 1
    let path = parent . '/.git'
    if isdirectory(path) || filereadable(path)
      return parent
    endif
    let next = fnamemodify(parent, ':h')
    if next == parent
      return ''
    endif
    let parent = next
  endwhile
endfunction

function! s:fetch_absolute_path()
  let @+ = expand('%:p')
endfunction

function! s:copy_absolute_path()
  call s:fetch_absolute_path()
  echo 'Copy absolute path: ' . @+
endfunction

function! s:copy_relative_path_from_root()
  call s:fetch_absolute_path()
  let git_root = s:path2project_directory_git(@+)
  let @+ = substitute(@+, git_root, '.', 'g')
  echo 'Copy relative path: ' . @+
endfunction

" augroup MyAutoCmd
"   autocmd WinEnter <buffer> checktime
" augroup END

nmap cp  :call <SID>copy_absolute_path()<CR>
nmap cpr :call <SID>copy_relative_path_from_root()<CR>

" Make sure pasting in visual mode doesn't replace paste buffer
function! RestoreRegister()
  let @+ = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @+
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" plug section
let s:plug_manager_path = expand('$HOME/.vim/autoload/plug.vim')
if !filereadable(s:plug_manager_path)
  execute '!curl -fLo ' . s:plug_manager_path .
        \ ' --create-dirs' .
        \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" PluginManager
call plug#begin('~/.vim/plugged')

" document
Plug 'vim-jp/vimdoc-ja'
" $ brew install lynx
" $ gem install refe2 #refeをインストール
" $ bitclust setup #refeのセットアップ
Plug 'thinca/vim-ref'
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe'

" completion
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-around'
Plug 'tani/ddc-fuzzy'
Plug 'matsui54/ddc-ultisnips'

Plug 'editorconfig/editorconfig-vim'

" skk
Plug 'vim-skk/skkeleton'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'shun/ddc-vim-lsp'

" snippets
if has('python3')
  Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'

" style
Plug 'mrbigass/darcula'
Plug 'vim-airline/vim-airline'
Plug 'osyo-manga/vim-brightest'
Plug 't9md/vim-quickhl'

" Plug 'vim-airline/vim-airline-themes'
Plug 'mrbigass/vim-prettier', { 'do': 'yarn install'  }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
" Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'simeji/winresizer'

" operation
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/vim-auto-save'
Plug 'preservim/nerdcommenter'
Plug 'glidenote/memolist.vim'
Plug 'thinca/vim-quickrun'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'markonm/traces.vim'

" FZF
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" browser
Plug 'tyru/open-browser.vim'
Plug 'alpaca-tc/alpaca_github.vim'

" git
Plug 'iberianpig/tig-explorer.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" html
Plug 'mattn/emmet-vim'

" rails
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'vim-scripts/ruby-matchit'
Plug 'pocke/rbs.vim'

" vue
Plug 'posva/vim-vue'

" rust
Plug 'rust-lang/rust.vim'

" javascript
" just in case
Plug 'othree/yajs.vim'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" graphql
Plug 'jparise/vim-graphql'

" terraform
Plug 'hashivim/vim-terraform'

" go
Plug 'mattn/vim-goimports'

" latex
" Plug 'lervag/vimtex'

" markdown
Plug 'kat0h/bufpreview.vim'

" SQL
Plug 'vim-scripts/SQLUtilities'

Plug 'twitvim/twitvim'

call plug#end()

filetype plugin indent on

syntax enable
colorscheme darcula

" plugin config================================
" vim-brightest'
let g:brightest#highlight = {
      \ "group" : "BrightestUnderline"
      \ }
let g:brightest#enable_filetypes = {
      \ "_": 1,
      \ }

nmap <Space>q <Plug>(quickhl-manual-this)
xmap <Space>q <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" vim-auto-save
augroup DisableAutoSave
  au!
  autocmd BufEnter *.vue let g:auto_save = 0
  autocmd BufLeave *.vue let g:auto_save = 1
  autocmd BufEnter *.ts let g:auto_save = 0
  autocmd BufLeave *.ts let g:auto_save = 1
augroup END

nmap <C-s> :w<CR>

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

" skk
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)

call skkeleton#config({
      \ 'globalJisyo': '/usr/share/skk/SKK-JISYO.L',
      \ 'eggLikeNewline': v:true
      \ })

" ddc
call ddc#custom#patch_global('sources', ['skkeleton', 'vim-lsp', 'around', 'ultisnips'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'skkeleton': {
      \   'mark': 'skk',
      \   'matchers': ['skkeleton'],
      \   'sorters': [],
      \   'minAutoCompleteLength': 2,
      \ },
      \ 'vim-lsp': {'mark': 'LS'},
      \ 'around': {'mark': 'Around'},
      \ 'ultisnips': {'mark': 'Snip'},
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy'],
      \ }})
call ddc#custom#patch_global('filterParams', {
      \ 'converter_fuzzy': {'hlGroup': 'SpellBad'},
      \ })
call ddc#enable()

" lsp
let g:lsp_diagnostics_echo_cursor = 1
nnoremap <silent><C-J> :<C-u>LspNextDiagnostic<CR>
nnoremap <silent><C-K> :<C-u>LspPreviousDiagnostic<CR>
nnoremap <Leader>sd :<C-u>LspDefinition<CR>

augroup lsp_deno
  au!
  au BufWritePre *.ts *.tsx LspDocumentFormatSync
augroup END

" for textlint on tex. no more no less.
" augroup LspEFM
"   au!
"   autocmd User lsp_setup call lsp#register_server({
"       \ 'name': 'efm-langserver',
"       \ 'cmd': {server_info->['efm-langserver', '-c=~/.config/efm-langserver/config.yaml']},
"       \ 'allowlist': ['tex'],
"       \ })
" augroup END

" NERDTree
let g:NERDTreeShowHidden=1
nnoremap <silent><Leader>t :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$', '\.DS_Store', '__pycache__$']

" FZF
nnoremap ff :GFiles<CR>
nnoremap fs :GFiles?<CR>
nnoremap fb :Buffers<CR>
nnoremap fl :Lines<CR>
nnoremap fr :Rg<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" snippets
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
nnoremap <Leader>sn :UltiSnipsEdit<CR>

" close-tag
let g:closetag_filenames = '*.html,*.vue'

" vim-prettier
let g:prettier#autoformat_config_present = 1 " prettireの設定ファイルがあった場合、そちらを優先する

" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

" Open current file on github
nmap gO :GhFile<CR>
" Open pull request of last commit on github
nmap gP :GhPullRequestCurrentLine<CR>

" memolist
" nnoremap <Leader>mn :MemoNew<CR>
" nnoremap <Leader>mg :MemoGrep<CR>
let g:memolist_fzf = 1

" markdown
nnoremap <silent> <Leader>pm :<C-u>PreviewMarkdownToggle<CR>

" tex
" let g:vimtex_view_general_viewer = 'evince'

for file in split(glob('$HOME/.vim/_config/*.vim'), '\n')
  exe 'source' file
endfor

augroup Flutter
  au!
  autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter
augroup END
function! s:format_file() abort
  if &filetype == 'xml'
    call s:format_xml()
  elseif &filetype == 'svg'
    call s:format_xml()
  elseif &filetype == 'json'
    call s:format_json()
  else
    return
    " ggVG=
  endif
  return
endfunction

function! s:format_xml()
  %s/></>\r</g | filetype indent on | setf xml | normal gg=G
endfunction

function! s:format_json()
  echo 'not yet'
endfunction

nnoremap <silent> fmt :call <SID>format_file()<CR>
