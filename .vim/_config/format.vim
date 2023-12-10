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
