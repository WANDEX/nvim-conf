-- themes configuration, lazy-load & etc.
--
-- NOTE: require('user.themes') inside packer.startup() to simply source this file

-- XXX: NOT WORKS ANYMORE - obsolete function signature!
-- packadd package_name as a string argument
-- local add_pack = function(package_name)
--   vim.validate{package_name={package_name, 'string'}}
--   -- silent! to suppress error message if package is not yet installed
--   vim.cmd('silent! packadd ' .. package_name)
-- end

local use = require('packer').use

use {
  'nekonako/xresources-nvim',
}

use {
  'tanvirtin/monokai.nvim',
}

use {
  'sainnhe/sonokai',
  config = function()
    vim.cmd('let g:sonokai_transparent_background = 2')
  end,
}

use {
  'catppuccin/nvim',
  as     = 'catppuccin',
  config = function()
    require('catppuccin').setup{
      transparent_background = true,
    }
  end,
}

use {
  'EdenEast/nightfox.nvim',
  config = function()
    require('nightfox').setup{
      options = {
        transparent = true,      -- Disable setting background
      },
    }
  end,
}

