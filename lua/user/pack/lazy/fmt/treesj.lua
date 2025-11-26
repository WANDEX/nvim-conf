-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'Wansmer/treesj'

return {
  'Wansmer/treesj',
  -- lazy = false,
  opts = {
    use_default_keymaps = false,
    ---Cursor behavior:
    ---hold - cursor follows the node/place on which it was called
    ---start - cursor jumps to the first symbol of the node being formatted
    ---end - cursor jumps to the last symbol of the node being formatted
    ---@type 'hold'|'start'|'end'
    cursor_behavior = 'hold',
  },
  config = function(_, opts)
    require('treesj').setup(opts)
  end,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {
      mode = 'n', '<leader>aj', function()
        require('treesj').toggle()
      end, desc = 'join/split toggle', silent = true
    },
    {
      mode = 'n', '<leader>aJ', function()
        require('treesj').toggle({ split = { recursive = true } })
      end, desc = 'join/split toggle recursive', silent = true
    },
  },
}
