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

" function! rspec_local#create_spec_file(path)
"   let spec_file_path = s:rspec_local#rspec_path_from_app_file(path)
"   if filereadable(spec_file_path)
"     edit `=spec_file_path`
"     return
"   endif
" endfunction

" function! s:rspec_local#rspec_path_from_app_file(path)
"   let root = s:detect_rails_root(a:path)
" endfunction

" function! s:detect_rails_root(path)
"   " let paths = split(a:path, '/')
"   let path = ''

"   for part in split(a:path, '/')
"     let path .= '/' . part

"     if filereadable(path . '/config/application.rb')
"       return path
"     endif
"   endfor
" endfunction

" nnoremap <silent><Leader>s :<C-u>call rspec_local#create_spec_file(expand('%:p'))<CR>
