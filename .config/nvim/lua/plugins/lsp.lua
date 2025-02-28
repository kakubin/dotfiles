return {
  {
    'prabirshrestha/vim-lsp',
    config = function()
      vim.g.lsp_diagnostics_echo_cursor = 1
      vim.keymap.set('n', '<silent><C-J>', ':<C-u>LspNextDiagnostic<CR>')
      vim.keymap.set('n', '<silent><C-K>', ':<C-u>LspPreviousDiagnostic<CR>')
      vim.keymap.set('n', '<silent>sd', ':<C-u>LspDefinition<CR>')

      vim.keymap.set('n', 'gi', ':<C-u>LspDefinition<CR>')
      vim.keymap.set('n', 'gh', ':<C-u>LspHover<CR>')
    end,
  },
  {
    'mattn/vim-lsp-settings',
    dependencies = {
      'prabirshrestha/vim-lsp',
    },
  },
  {
    'thomasfaingnaert/vim-lsp-snippets',
    dependencies = {
      'prabirshrestha/vim-lsp',
    },
  },
  {
    'thomasfaingnaert/vim-lsp-ultisnips',
    dependencies = {
      'prabirshrestha/vim-lsp',
    },
  },
}
