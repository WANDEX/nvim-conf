-- configuration for the git related plugins

local use = require('packer').use
use {
  'jreybert/vimagit',
  'tpope/vim-fugitive',
}

use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
  }
}

require('gitsigns').setup()
