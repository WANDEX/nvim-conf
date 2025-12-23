-- AUTHOR: 'WANDEX/nvim-conf'

return {

  { 'NMAC427/guess-indent.nvim' }, -- detect tabstop and shiftwidth automatically

  { 'windwp/nvim-autopairs', enabled = false, event = 'InsertEnter', config = true },

  {
    'saecki/live-rename.nvim',
    lazy = false,
    opts = {
      scratch_register = 'l',
      keys = {
        submit = {
          { {'n', 'i', 'v'}, '<cr>' },
          { {'n', 'i'}, '<C-y>' },
        },
        cancel = {
          { 'n', '<esc>' },
          { 'n', 'q' },
          { 'n', '<C-l>' },
        },
      },
      hl = {
          -- current = 'CurSearch',
          -- others = 'Search',
          current = 'LRED',
          others  = 'DRED',
      },
    },
    config = function(_, opts)
      require('live-rename').setup(opts)
    end,
  },

}
