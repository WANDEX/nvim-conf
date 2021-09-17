-- configuration for the statusline plugins:
-- "glepnir/galaxyline.nvim"

local use = require('packer').use
local sep = '.' -- os specific path separator

-- statusline dir to use
local statusline = 'galaxyline'
-- statusline theme dir name
local theme = 'nerd'
-- statusline init file path
statusline_init = table.concat({'stat', statusline, theme, 'init'}, sep)

if ( statusline == 'galaxyline' ) then
  use { -- galaxyline
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function()
      require(statusline_init)
    end,
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  }
end
