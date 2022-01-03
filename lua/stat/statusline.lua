-- configuration for the statusline plugins:
-- "glepnir/galaxyline.nvim"

local use = require('packer').use
local sep = '.' -- os specific path separator

-- statusline dir to use
local statusline = 'galaxyline'
-- statusline theme dir name
local theme = 'nerv'
-- statusline init file path
local statusline_init = table.concat({'stat', statusline, theme, 'init'}, sep)
-- FIXME: ^ cannot be used

if ( statusline == 'galaxyline' ) then
  use { -- galaxyline
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function()
      statusline_init = 'stat.galaxyline.nerv.init'
      local ok, _ = pcall(require, statusline_init)
      if not ok then
        print("error with statusline")
        return
      end
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  }
end
