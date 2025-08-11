-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'EmilOhlsson/FloatTerm.nvim'

return {
  'EmilOhlsson/FloatTerm.nvim',
  -- commit = 'b7739e1af8c2c43550c811a3e1bb30caed8f3c06',
  lazy = false,
  opts = {
    window_config = {
      border  = 'rounded',
      title   = '[fterm]',
      title_pos = 'right',
    },
    pad_vertical   = 2,
    pad_horizontal = 0,
  },
  config = true,
  keys = {
    {
      mode = 'n', '<localleader>t', function() require('FloatTerm').toggle_window() end,
      desc = 'toggle float term',
    },
  },
}
