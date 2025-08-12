-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'smoka7/multicursors.nvim'

return {
  'smoka7/multicursors.nvim',
  enabled = false, -- XXX
  -- commit = '72225ea9e4443c3f4b9df91d0193e07c4ee8d382',
  dependencies = {{
    'nvimtools/hydra.nvim',
    -- commit = '8c4a9f621ec7cdc30411a1f3b6d5eebb12b469dc',
  }},
  -- version = '*',
  lazy = false,
  event = 'VeryLazy',

  opts = function(_, opts)
    opts = require('user.pack.conf.multicursors')
    return opts
  end,
  cmd  = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  keys = {
    {
      mode = { 'v', 'n' }, '<C-j>', '<cmd>MCstart<cr>',
      desc = 'MC Create a selection for selected text or word under the cursor',
    },
    {
      mode = { 'v', 'n' }, '<C-n>', '<cmd>MCunderCursor<cr>',
      desc = 'MC Select the char under the cursor and start listening for the actions.',
    },
  },
}
