return {
  'honza/vim-snippets',
  {
    'SirVer/ultisnips',
    dependencies = {
      'honza/vim-snippets',
    },
    config = function()
      vim.g['UltiSnipsExpandTrigger'] = '<c-e>'
      vim.g['UltiSnipsJumpForwardTrigger'] = '<c-b>'
      vim.g['UltiSnipsJumpBackwardTrigger'] = '<c-z>'
      vim.keymap.set('n', '<Leader>sn', ':UltiSnipsEdit<CR>', { buffer = true })
    end,
  },
}
