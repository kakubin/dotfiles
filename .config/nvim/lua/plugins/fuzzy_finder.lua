return {
  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    config = function()
      vim.keymap.set('n', 'ff', ':GFiles<CR>')
      vim.keymap.set('n', 'fs', ':GFiles?<CR>')
      vim.keymap.set('n', 'fb', ':Buffers<CR>')
      vim.keymap.set('n', 'fl', ':Lines<CR>')
      vim.keymap.set('n', 'fr', ':Rg<CR>')
      vim.g.fzf_layout = {
        window = {
           width = 0.9,
           height = 0.7,
        },
      }
    end,
  }
}
