-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'MagicDuck/grug-far.nvim'

return {
  'MagicDuck/grug-far.nvim',
  opts = {
    -- headerMaxWidth = 80,
  },
  cmd  = { 'GrugFar', 'GrugFarWithin' },
  keys = {
    {
      mode = { 'n', 'x' }, '<leader>TGsr', function()
        local grug = require('grug-far')
        local ext = vim.bo.buftype == '' and vim.fn.expand('%:e')
        grug.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        })
      end, desc = 'Search and Replace',
    },
  },
}
