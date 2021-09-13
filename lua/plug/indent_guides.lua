-- configuration for the plugin "lukas-reineke/indent-blankline.nvim"

local use = require('packer').use
use {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    -- XXX(1): temp fix for bug only with set termguicolors, with notermguicolors all ok.
    -- (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
    vim.wo.colorcolumn = "99999" -- XXX temp fix:(1) remove me later!
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

