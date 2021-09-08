-- configuration for the git related plugins

local use = require('packer').use
use {
  'tpope/vim-fugitive',
  'jreybert/vimagit', -- till neogit is not fixed
}

use {
  {'TimUntersberger/neogit', disable=true}, -- FIXME throws error if enabled
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
  },
}

require('gitsigns').setup{
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '^', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
}

-- require('neogit').setup{}
