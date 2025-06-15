-- spec 'nvim-telescope/telescope.nvim'

return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  lazy = false,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'TC72/telescope-tele-tabby.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  opts = function(_, opts)
    local actions = require 'telescope.actions'
    local action_layout = require 'telescope.actions.layout'
    opts.defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      multi_icon = "<>",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      color_devicons = true,
      winblend = 0,
      layout_strategy = "flex",
      layout_config = {
        width = 0.9,
        height = 0.95,
        prompt_position = "bottom",
        horizontal = {
          preview_cutoff = 1, -- always show Preview (unless previewer = false)
          preview_width = 0.5,
        },
        vertical = {
          preview_cutoff = 1, -- always show Preview (unless previewer = false)
          preview_height = 0.45,
        },
        flex = {
          flip_columns = 140,
        },
      },
      mappings = { -- Global remapping
        i = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-e>"] = actions.move_selection_previous,
          ["<C-p>"] = false,
          ["<C-c>"] = false,
          ["<C-l>"] = actions.close,
        },
        n = {
          ["n"] = actions.move_selection_next,
          ["e"] = actions.move_selection_previous,
          ["j"] = false,
          ["k"] = false,
          ["<C-l>"] = actions.close,
        },
      },
    }
    opts.extensions = {
      fzf = {
        fuzzy = true,                     -- false will only do exact matching
        override_generic_sorter = false,  -- override the generic sorter
        override_file_sorter = true,      -- override the file sorter
        case_mode = "smart_case",         -- "ignore_case" or "respect_case" or "smart_case"
      },
      tele_tabby = {
        use_highlighter = true,
      },
    }
    return opts
  end,
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension 'fzf'          -- fzf-native
    telescope.load_extension 'file_browser'
  end,
}
