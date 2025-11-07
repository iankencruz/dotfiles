return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup {
      -- your configuration here
      aliases = {
        ['svelte'] = 'html',
      },
    }
  end,
}
