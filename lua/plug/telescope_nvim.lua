-- configuration for the plugin "nvim-telescope/telescope.nvim"

local use = require('packer').use
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
  },
}

local tel = require('telescope')
local actions = require('telescope.actions')

tel.setup{
  defaults = {
    mappings = { -- Global remapping
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-e>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.complete_tag,
        ["<C-l>"] = actions.close,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-e>"] = actions.move_selection_previous,
        ["<C-l>"] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

tel.load_extension('fzf') -- fzf-native
