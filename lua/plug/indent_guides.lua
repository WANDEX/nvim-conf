-- configuration for the plugin "lukas-reineke/indent-blankline.nvim"

local use = require('packer').use
use {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('indent_blankline').setup{
      -- exclude: TODO somehow exclude floating_windows
      -- bufname_exclude = {''},
      buftype_exclude = {'nofile', 'terminal'}, -- :se bt
      filetype_exclude = {'man', 'help', 'packer'}, -- :se ft
      char_highlight_list = {
        "IndentGuidesOdd",
        "IndentGuidesEven",
      },
      show_trailing_blankline_indent = false,
      -- show_current_context = true, -- requires treesitter!
    }
  end,
}

