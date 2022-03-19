" vim-rails
function! SetUpRailsSetting()
  " nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  " nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
  autocmd!
  autocmd User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
  autocmd!
aug END

" rails locale
nnoremap <silent><Leader>l :<C-u>call rails_locale#open_locale_file_from_path(expand('%:p'))<CR>
