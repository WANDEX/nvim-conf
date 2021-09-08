-- lazy-load configuration for the plugin "Pocco81/TrueZen.nvim"

local use = require('packer').use
use {
  'Pocco81/TrueZen.nvim',
  config = function()
    require("true-zen").setup{
      modes = {
        ataraxis = {
          ideal_writing_area_width = { 80, 150, 0.53 },
        },
      },
    }
  end,
  cmd={'TZMinimalist', 'TZFocus', 'TZAtaraxis'},
}
