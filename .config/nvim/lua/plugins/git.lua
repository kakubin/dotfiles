return {
  'airblade/vim-gitgutter',
  { 
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', 'gd', ':Gvdiffsplit<CR>')
      vim.keymap.set('n', 'gb', ':Git blame<CR>')
    end
  },
  { 
    'iberianpig/tig-explorer.vim',
    config = function() 
      vim.keymap.set('n', '<Leader>gt', ':TigOpenProjectRootDir<CR>')
    end
  },
}
