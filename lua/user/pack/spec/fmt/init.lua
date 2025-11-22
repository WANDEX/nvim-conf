-- AUTHOR: 'WANDEX/nvim-conf'

return {

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
    keys = {
      {
        mode = 'n', '<leader>lr', function() -- overrides keymap defined in lsp/keys.lua
          require('live-rename').rename({ cursorpos = -1 })
        end, desc = '[LSP] rename-live', silent = true
      },
    },
  },

  -- { 'scrooloose/nerdcommenter' }, -- replaced by another comments plugin

  {
    'folke/ts-comments.nvim',
    lazy = false,
    opts = {},
    enabled = vim.fn.has('nvim-0.10.0') == 1,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' }, -- treesitter-parsers must be installed!
      -- { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- XXX: not sure that it is needed
    },
  },

  -- { },
}
