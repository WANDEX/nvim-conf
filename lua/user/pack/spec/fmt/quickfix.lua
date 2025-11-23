-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'stevearc/quicker.nvim'

return {
  'stevearc/quicker.nvim',
  -- lazy = false,
  ft = 'qf',
  ---@module 'quicker'
  ---@type quicker.SetupOptions
  opts = {
    keys = {
      {
        '>',
        function()
          require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  config = function(_, opts)
    require('quicker').setup(opts)
  end,
  keys = {
    {
      mode = 'n', '<leader>Lq', function()
        require('quicker').toggle()
      end, desc = 'qToggle', silent = true
    },
    {
      mode = 'n', '<leader>Ll', function()
        require('quicker').toggle({ loclist=true })
      end, desc = 'lToggle', silent = true
    },
  },
}
