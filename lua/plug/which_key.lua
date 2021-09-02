-- configuration for the plugin "folke/which-key.nvim"

local use = require('packer').use
use 'folke/which-key.nvim'

local wk = require('which-key')

-- wk.setup {
-- }

-- add
wk.register({ a = {
  name = "add/alt",
  t = { "<cmd>ToggleAlternate<CR>", "toggle alt bool" }, -- FIXME does not work for some reason...
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
  v =  "vrt", -- magit cannot unbind def mapping
}, }, { prefix = "<leader>" })

wk.register({ T = {
  name = "Telescope",
  -- command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
  b = { "<cmd>Telescope buffers theme=get_dropdown previewer=false<CR>", "buffers" },
  B = { "<cmd>lua require'telescope.builtin'.buffers{}<CR>", "buffers w preview" },
  c = { "<cmd>lua require'telescope.builtin'.grep_string{}<CR>", "grep under Cursor at cwd" },
  d = { ":lua require'telescope.builtin'.live_grep({search_dirs={ '', }})<C-Left><C-Left><Right>", "grep in list of dirs" },
  f = { "<cmd>lua require'telescope.builtin'.find_files{}<CR>", "find file at cwd" },
  F = { "<cmd>lua require'telescope.builtin'.file_browser{}<CR>", "Filesystem" },
  g = { "<cmd>lua require'telescope.builtin'.live_grep{}<CR>", "grep at cwd" },
  o = { "<cmd>lua require'telescope.builtin'.live_grep{ grep_open_files=true }<CR>", "grep Opened files" },
  S = { "<cmd>SearchSession<CR>", "Session" },
  t = { "<cmd>Telescope tele_tabby list theme=get_dropdown<CR>", "tabs" },
  v = {
    name = "vim",
    C = { "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>", "colorscheme" },
    c = { "<cmd>lua require'telescope.builtin'.command_history{}<CR>", "command history" },
    f = { "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", "fuzzy find buf" },
    h = { "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", "help tags" },
    m = { "<cmd>lua require'telescope.builtin'.man_pages{}<CR>", "man pages" },
    o = { "<cmd>lua require'telescope.builtin'.vim_options{}<CR>", "options vim edit" },
    p = { "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", "prev opened files" },
    r = { "<cmd>lua require'telescope.builtin'.registers{}<CR>", "registers" },
    s = { "<cmd>lua require'telescope.builtin'.search_history{}<CR>", "search history" },
    T = { "<cmd>lua require'telescope.builtin'.current_buffer_tags{}<CR>", "tags buf" },
  },
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

