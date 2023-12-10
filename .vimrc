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

" set laststatus
set cursorline
augroup CursorLine
  autocmd!
  autocmd InsertEnter,InsertLeave * set cursorline!
augroup END

augroup DeleteSpace
  au!
  autocmd BufEnter * call s:delete_trailing_space()
augroup END

function! s:delete_trailing_space()
  if &filetype != 'gitcommit'
    augroup DeleteSpace
      autocmd!
      autocmd BufWritePre * :%s/\s\+$//e
    augroup END
  endif
endfunction

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
Plug 'Shougo/ddc-ui-native'
Plug 'Shougo/ddc-around'
Plug 'tani/ddc-fuzzy'
Plug 'matsui54/ddc-ultisnips'

" fuzzy finder
Plug 'Shougo/ddu.vim'

"" ui
Plug 'Shougo/ddu-ui-ff'
"" source
Plug 'Shougo/ddu-source-file_rec'
Plug 'shun/ddu-source-rg'
"" filter
Plug 'Shougo/ddu-filter-matcher_substring'
"" kind
Plug 'Shougo/ddu-kind-file'

Plug 'editorconfig/editorconfig-vim'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'shun/ddc-vim-lsp'

" snippets
if has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'thomasfaingnaert/vim-lsp-snippets'
  Plug 'thomasfaingnaert/vim-lsp-ultisnips'
endif
Plug 'honza/vim-snippets'

" style
Plug 'kakubin/darcula'
Plug 'vim-airline/vim-airline'
Plug 'osyo-manga/vim-brightest'
Plug 't9md/vim-quickhl'
Plug 'google/vim-jsonnet'

Plug 'kakubin/vim-prettier', { 'do': 'yarn install'  }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
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
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

" ddc
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'ultisnips'])
call ddc#custom#patch_global('sourceOptions', {
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

nnoremap gi :LspDefinition<CR>
nnoremap gh :LspHover<CR>

augroup lsp_deno
  au!
  au BufWritePre *.ts *.tsx LspDocumentFormatSync
augroup END


" NERDTree
let g:NERDTreeShowHidden=1
nnoremap <silent><Leader>t :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$', '\.DS_Store', '__pycache__$']


" fuzzy finder
" call ddu#custom#patch_global(#{
"     \   ui: 'ff',
"     \   sourceParams : #{
"     \     rg : #{
"     \       args: ['--column', '--no-heading', '--color', 'never'],
"     \     },
"     \   },
"     \   },
"     \   kindOptions: #{
"     \     file: #{
"     \       defaultAction: 'open',
"     \     },
"     \   }
"     \ })
call ddu#custom#patch_global({
    \   'ui': 'ff',
    \   'uiParams': {
    \     'ff': {
    \       'startFilter': v:true,
    \     }
    \   },
    \   'sources': [
    \     {
    \       'name': 'file_rec',
    \       'params': #{
    \          path: expand("%")
    \       }
    \     }
    \   ],
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   },
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

nnoremap FF :call ddu#start()<CR>

function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction
autocmd FileType ddu-ff call s:ddu_my_settings()

function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
endfunction
autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()

nnoremap ff :GFiles<CR>
nnoremap fs :GFiles?<CR>
nnoremap fb :Buffers<CR>
nnoremap fl :Lines<CR>
" fzf.vimの定義でhiddenが入っていないので被せでオプション追加を再定義
" https://github.com/junegunn/fzf.vim/blob/1e054c1d075d87903647db9320116d360eb8b024/plugin/fzf.vim#L63C65-L63C216
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
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

" markdown
nnoremap <silent> <Leader>pm :<C-u>PreviewMarkdownToggle<CR>

" tex
" let g:vimtex_view_general_viewer = 'evince'

for file in split(glob('$HOME/.vim/_config/*.vim'), '\n')
  exe 'source' file
endfor
