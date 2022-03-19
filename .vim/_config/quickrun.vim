" quickrun
let g:quickrun_config = {
      \ '_': { 'runner' : 'vimproc' },
      \ 'ruby.rspec': {
      \   'command': 'rspec',
      \   'exec' : 'bundle exec %c %s' },
      \
      \ 'typescript.jest': {
      \   'command': 'jest',
      \   'exec': 'yarn %c %s' },
      \ }

augroup SetFileType
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
  autocmd BufWinEnter,BufNewFile *test.ts set filetype=typescript.jest
augroup END

function QuickRunRspecCurrentLine()
  if &ft == 'ruby.rspec'
    let line = line('.')
    exec ":QuickRun -exec 'bundle exec %c %s:%o' -cmdopt " . line
  endif
endfunction
nnoremap <silent> <Leader>rr :<C-u>call QuickRunRspecCurrentLine()<CR>
nnoremap <silent> <Leader>r  :<C-u>QuickRun<CR>

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
