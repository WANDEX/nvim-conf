-- configuration for the plugin "folke/which-key.nvim"

local use = require('packer').use
use 'folke/which-key.nvim'

local wk = require('which-key')

-- wk.setup {
-- }

-- add
wk.register({ a = {
  name = "add",
  [";"] = { "<cmd>norm $a;<CR>", "$a;" },
}, }, { prefix = "<leader>" })

wk.register({ c = {
  name = "comment",
}, }, { prefix = "<leader>" })

-- delete
wk.register({ d = {
  name = "delete/diff",
  d = { "<cmd>bd!<CR>", "buffer delete" },
  W = { "Whitespace strip" },
}, }, { prefix = "<leader>" })

wk.register({ h = {
  name = "hunk",
}, }, { prefix = "<leader>" })

wk.register({ L = {
  name = "List",
}, }, { prefix = "<leader>" })

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

-- translate normal mode
wk.register({ t = {
  name = "trans",
  ["w"]  = { "<cmd>TranslateW<CR>", "word" },
  ["!w"] = { "<cmd>TranslateW!<CR>", "word" },
  ["l"]  = { "<cmd>normal V<CR> | :'<,'>TranslateW<CR>",  "line" },
  ["!l"] = { "<cmd>normal V<CR> | :'<,'>TranslateW!<CR>", "line" },
  ["r"]  = { "<cmd>normal V<CR> | :'<,'>TranslateR<CR>",  "replace line" },
  ["!r"] = { "<cmd>normal V<CR> | :'<,'>TranslateR!<CR>", "replace line" },
}, }, { prefix = "<leader>", mode = "n" })

-- translate visual mode
wk.register({ t = {
  name = "trans",
  ["w"]  = { ":'<,'>TranslateW<CR>",  "window" },
  ["!w"] = { ":'<,'>TranslateW!<CR>", "window" },
  ["r"]  = { ":'<,'>TranslateR<CR>",  "replace" },
  ["!r"] = { ":'<,'>TranslateR!<CR>", "replace" },
}, }, { prefix = "<leader>", mode = "v" })

