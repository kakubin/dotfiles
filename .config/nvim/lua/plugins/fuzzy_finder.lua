return {
  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      vim.cmd [[
      nnoremap ff :GFiles<CR>
      nnoremap fs :GFiles?<CR>
      nnoremap fb :Buffers<CR>
      nnoremap fl :Lines<CR>
      nnoremap fr :Rg<CR>
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
      ]]
    end,
  }
}
