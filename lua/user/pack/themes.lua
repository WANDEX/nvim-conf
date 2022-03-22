-- themes configuration, lazy-load & etc.
--
-- NOTE: require('user.themes') inside packer.startup() to simply source this file

-- packadd package_name as a string argument
local add_pack = function(package_name)
  vim.validate{package_name={package_name, 'string'}}
  -- silent! to suppress error message if package is not yet installed
  vim.cmd('silent! packadd ' .. package_name)
end

local use = require('packer').use

use {
  'nekonako/xresources-nvim',
  setup = add_pack('xresources-nvim'),
  cmd={'colorscheme xresources'},
}

use {
  'jeffkreeftmeijer/vim-dim', -- OLD -> ONLY! notermguicolors (Xresources) consistent term colors w invers
  config = function()
    -- FIXME why notermguicolors not sets?
    vim.o.termguicolors = false
    vim.cmd('set notermguicolors')
  end,
  setup = add_pack('vim-dim'),
  cmd={'colorscheme dim'},
}

use {
  'catppuccin/nvim',
  as = 'catppuccin',
  setup = add_pack('catppuccin'),
  cmd={'colorscheme catppuccin'},
}

use {
  'tanvirtin/monokai.nvim',
  setup = add_pack('monokai.nvim'),
  cmd={'colorscheme monokai', 'colorscheme monokai_pro', 'colorscheme monokai_soda'},
}

use {
  'EdenEast/nightfox.nvim',
  setup = add_pack('nightfox.nvim'),
  cmd={'colorscheme nightfox', 'NightfoxLoad'}, -- style :NightfoxLoad <fox>
}

use {
  'sainnhe/sonokai',
  config = function()
    -- FIXME why termguicolors not sets?
    vim.o.termguicolors = true
  end,
  setup = add_pack('sonokai'),
  cmd={'colorscheme sonokai'},
}
