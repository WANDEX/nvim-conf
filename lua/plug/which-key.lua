-- configuration for the plugin "folke/which-key.nvim"

local use = require('packer').use
use 'folke/which-key.nvim'

local wk = require('which-key')

-- wk.setup {
-- }

-- LSP - just a label. don't create any mappings
wk.register({ ["gD"] = "[LSP] declaration" })
wk.register({ ["gd"] = "[LSP] definition" })
wk.register({ ["gi"] = "[LSP] implementation" })
wk.register({ ["gr"] = "[LSP] references" })
wk.register({ ["<C-k>"] = "[LSP] signature help" })
wk.register({ ["[d"] = "[LSP] prev diag" })
wk.register({ ["]d"] = "[LSP] next diag" })
wk.register({ l = {
  name = "lsp",
  a = { "action" },
  D = { "type definition" },
  e = { "show/enter line diag" },
  f = { "formatting" },
  h = { "hover" },
  l = { "list diag" },
  r = { "rename" },
  w = {
    name = "workspace",
    a = { "add workspace folder" },
    l = { "list workspace folders" },
    r = { "remove workspace folder" },
  },
}, }, { prefix = "<leader>" })

wk.register({ M = {
  name = "Magit",
  h = { "<cmd>call magit#show_magit('h')<CR>", "hrz" },
  o = { "<cmd>call magit#show_magit('c')<CR>", "only" },
  v = { "<cmd>call magit#show_magit('v')<CR>", "vrt" },
}, }, { prefix = "<leader>" })

