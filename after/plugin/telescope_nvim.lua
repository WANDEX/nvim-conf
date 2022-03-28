-- configuration for the plugin "nvim-telescope/telescope.nvim"

local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local actions = require('telescope.actions')

telescope.setup {
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
    tele_tabby = {
      use_highlighter = true,
    },
  },
}

telescope.load_extension 'fzf' -- fzf-native
telescope.load_extension 'file_browser'
