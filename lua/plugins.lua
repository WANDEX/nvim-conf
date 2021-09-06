-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}
  use 'rmagatti/alternate-toggler' -- toggle alternate "boolean" values

  use { -- new text objects | more info: 'https://github.com/kana/vim-textobj-user/wiki'
    'kana/vim-textobj-user',    -- CORE (wont be installed with 'requires = ...')
    'kana/vim-textobj-indent',  -- ai/ii aI/iI
    'kana/vim-textobj-line',    -- al/il
    'kana/vim-textobj-entire',  -- ae/ie
    'glts/vim-textobj-comment', -- ac/ic aC
    'kana/vim-textobj-diff',    -- adh/idh
    'bps/vim-textobj-python',   -- af/if ac/ic | [pf / ]pf [pc / ]pc
  }

end)

