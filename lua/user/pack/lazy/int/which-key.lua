-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'folke/which-key.nvim'

return {
  'folke/which-key.nvim',
  version = '*',
  event = { 'VeryLazy' }, -- https://github.com/folke/lazy.nvim/discussions/518
  ---@class wk.Opts
  opts = {
    preset = 'classic',
    delay = vim.opt.timeoutlen:get() * 2, --- @diagnostic disable-line undefined-field get()
    notify = true, -- show a warning when issues were detected with your mappings
    plugins = {
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 50, -- how many suggestions should be shown in the list?
      },
      presets = {
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = false, -- disable default bindings help on <c-w> -> because default keys are remapped
      },
    },
    spec = {
      { "<C-W>", group = "window" }, -- window mappings (because default keys are remapped for the colemak layout)
      { "<C-W>+", desc = "Increase height" },
      { "<C-W>-", desc = "Decrease height" },
      { "<C-W>>", desc = "Increase width" },
      { "<C-W><", desc = "Decrease width" },
      { "<C-W>|", desc = "Max out the width" },
      { "<C-W>=", desc = "Equally high and wide" },
      { "<C-W><C-N>", desc = "New empty buffer window" },

      { "<C-W>h", desc = "Go to the left window" },
      { "<C-W>n", desc = "Go to the down window" },
      { "<C-W>e", desc = "Go to the up window" },
      { "<C-W>i", desc = "Go to the right window" },

      { "<C-W>H", desc = "Move window to the left" },
      { "<C-W>N", desc = "Move window to the down" },
      { "<C-W>E", desc = "Move window to the up" },
      { "<C-W>I", desc = "Move window to the right" },

      { "<C-W>q", desc = "Quit a window" },
      { "<C-W>s", desc = "Split window" },
      { "<C-W>T", desc = "Break out into a new tab" },

      { "<C-W>v", desc = "Split window vertically" },
      { "<C-W>w", desc = "Switch windows" },
      { "<C-W>x", desc = "Swap current with next" },

      { "<leader>a", group = "add/alt" },
      { "<leader>at", "<cmd>ToggleAlternate<CR>", desc = "toggle alt val" },

      { "<leader>c", group = "comment" },

      { "<leader>d", group = "delete/diff" },
      { "<leader>dW", desc = "Whitespace strip" },
      { "<leader>dd", "<cmd>bd!<CR>", desc = "buffer delete" },

      { "<leader>h", group = "hunk" },

      { "<leader>L", group = "List/Diag/Toggle" },
      { "<leader>LD", group = "Diag" },

      { "<leader>l",  group = "lsp" },

      { "<leader>N", group = "Neogit" },
      { "<leader>NS", "<cmd>lua require('neogit').open({ kind = 'split_above' })<CR>", desc = "split above" },
      { "<leader>Nc", "<cmd>lua require('neogit').open({ 'commit' })<CR>", desc = "commit" },
      { "<leader>Ns", "<cmd>lua require('neogit').open({ kind = 'split' })<CR>", desc = "split below" },
      { "<leader>Nt", "<cmd>lua require('neogit').open({ kind = 'tab' })<CR>", desc = "tab" },
      { "<leader>Nv", "<cmd>lua require('neogit').open({ kind = 'vsplit' })<CR>", desc = "vsplit" },

      { "<leader>n", group = "nvim-tree" },

    }, -- END spec
  },
  keys = {
    {
      '<localleader>?', function()
        require('which-key').show({ global = false })
      end, desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
