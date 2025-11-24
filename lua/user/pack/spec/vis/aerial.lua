-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'stevearc/aerial.nvim'

return {
  {
    'preservim/tagbar', -- ctags based plugin
    enabled = false,
    keys = {
      {
        mode = 'n', '<F3>', '<cmd>TagbarToggle<CR>',
        desc = 'TagbarToggle', silent = true
      },
    },
  },

  { -- code outline window for skimming and quick navigation
    'stevearc/aerial.nvim',
    enabled = true,
    opts = {
      layout = {
        default_direction = 'prefer_left', -- Enum: prefer_right, prefer_left, right, left, float
        placement = 'edge', -- edge, window
      },
      attach_mode = 'global', -- global, window
      keymaps = {
        ['<C-n>'] = 'actions.down_and_scroll',
        ['<C-e>'] = 'actions.up_and_scroll',
        ['i'] = 'actions.tree_open',
        ['I'] = 'actions.tree_open_recursive',
        ['h'] = 'actions.tree_close',
        ['H'] = 'actions.tree_close_recursive',
      },
    },
    keys = {
      {
        mode = 'n', '<F3>', '<cmd>AerialToggle!<CR>',
        desc = 'AerialToggle!', silent = true
      },
    },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-tree/nvim-web-devicons' },
    },
  },
}
