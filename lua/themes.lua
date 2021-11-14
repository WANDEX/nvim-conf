-- themes configuration, lazy-load & etc.
--
-- example on how to add package before it's lazy-loaded in Packer:
-- setup = function()
--   vim.cmd('packadd Catppuccino.nvim')
-- end,
-- ... keys that imply lazy-loading and imply opt = true

local use = require('packer').use

local cmd = vim.cmd

local add_pack = function(package_name)
  -- packadd package_name as a string argument
  vim.validate{package_name={package_name, 'string'}}
  cmd('packadd ' .. package_name)
end

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
  'Pocco81/Catppuccino.nvim',
  setup = add_pack('Catppuccino.nvim'),
  cmd={
    'colorscheme catppuccin',
  },
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

