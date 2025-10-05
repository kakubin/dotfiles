return {
  'vim-denops/denops.vim',
  {
    'Shougo/ddc.vim',
    dependencies = {
      'vim-denops/denops.vim',
      'Shougo/ddc-ui-native',
      'Shougo/ddc-around',
      'tani/ddc-fuzzy',
      'matsui54/ddc-ultisnips',
      'shun/ddc-vim-lsp',
    },
    config = function()
      vim.fn['ddc#custom#patch_global']({
        ui = 'native',
        sources = {
          'vim-lsp',
          'around',
          'ultisnips',
        },
        sourceOptions = {
          ['vim-lsp'] = {
            mark =  'LS',
          },
          around = {
            mark = 'Around',
          },
          ultisnips = {
            mark = 'Snip',
          },
          _ = {
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_fuzzy' },
          }
        },
        filterParams = {
          converter_fuzzy = {
            hlGroup = 'SpellBad',
          },
        },
      })
      vim.fn['ddc#enable']()
    end
  },
  'Shougo/ddc-ui-native',
  'Shougo/ddc-around',
  'tani/ddc-fuzzy',
  {
    'matsui54/ddc-ultisnips',
    dependencies = {
      'SirVer/ultisnips',
    }
  },
  {
    'shun/ddc-vim-lsp',
    dependencies = {
      'prabirshrestha/vim-lsp',
    }
  },
}
