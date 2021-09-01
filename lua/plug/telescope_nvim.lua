-- configuration for the plugin "nvim-telescope/telescope.nvim"

local use = require('packer').use
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
  },
}

local tel = require('telescope')


