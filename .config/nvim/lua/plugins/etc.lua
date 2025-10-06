return {
  {
    'kakubin/darcula',
    config = function()
      vim.cmd("colorscheme darcula")
    end
  },
  {
    'vim-scripts/vim-auto-save',
    init = function()
      vim.g.auto_save = 1
      vim.g.auto_save_in_insert_mode = 0
      vim.g.auto_save_silent = 1
    end
  },
  'easymotion/vim-easymotion',
  'tpope/vim-surround',
  {
    'osyo-manga/vim-brightest',
    init = function()
      vim.g['brightest#highlight'] = {
        group = "BrightestUnderline"
      }
    end
  },
  {
    'preservim/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDDefaultAlign = 'left'
      vim.keymap.set('n', '<C-/>', '<Plug>NERDCommenterToggle')
      vim.keymap.set('v', '<C-_>', '<Plug>NERDCommenterToggle<CR>gv')
    end
  },
}
