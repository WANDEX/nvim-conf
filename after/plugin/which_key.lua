-- configuration for the plugin "folke/which-key.nvim"

local ok, wk = pcall(require, 'which-key')
if not ok then
  return
end

wk.setup {
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 50, -- how many suggestions should be shown in the list?
    },
    presets = {
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- disable default bindings help on <c-w> -> because default keys are remapped
    },
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
}

-- window mappings (because default keys are remapped)
wk.register({ ["<C-W>"] = {
  name = "window",
  ["+"] = "Increase height",
  ["-"] = "Decrease height",
  ["="] = "Equally high and wide",
  [">"] = "Increase width",
  ["<"] = "Decrease width", -- bug? - it's not showing.
  ["|"] = "Max out the width",
  ["<C-N>"] = "New empty buffer window",

  ["h"] = "Go to the left window",
  ["n"] = "Go to the down window",
  ["e"] = "Go to the up window",
  ["i"] = "Go to the right window",

  ["H"] = "Move window to the left",
  ["N"] = "Move window to the down",
  ["E"] = "Move window to the up",
  ["I"] = "Move window to the right",

  ["q"] = "Quit a window",
  ["s"] = "Split window",
  ["T"] = "Break out into a new tab",

  ["v"] = "Split window vertically",
  ["w"] = "Switch windows",
  ["x"] = "Swap current with next",
}, })

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

wk.register({ N = {
  name = "Neogit",
  c = { "<cmd>lua require('neogit').open({ 'commit' })<CR>", "commit" },
  s = { "<cmd>lua require('neogit').open({ kind = 'split' })<CR>", "split below" },
  S = { "<cmd>lua require('neogit').open({ kind = 'split_above' })<CR>", "split above" },
  t = { "<cmd>lua require('neogit').open({ kind = 'tab' })<CR>", "tab" },
  v = { "<cmd>lua require('neogit').open({ kind = 'vsplit' })<CR>", "vsplit" },
}, }, { prefix = "<leader>" })

wk.register({ T = {
  name = "Telescope",
  -- command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
  b = { "<cmd>Telescope buffers theme=get_dropdown previewer=false border=false<CR>", "buffers" },
  B = { "<cmd>lua require'telescope.builtin'.buffers{}<CR>", "buffers w preview" },
  c = { "<cmd>lua require'telescope.builtin'.grep_string{}<CR>", "grep under Cursor at cwd" },
  d = { ":lua require'telescope.builtin'.live_grep({search_dirs={ '', }})<C-Left><C-Left><Right>", "grep in list of dirs" },
  f = { "<cmd>lua require'telescope.builtin'.find_files{}<CR>", "find file at cwd" },
  F = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser{ hidden=false, respect_gitignore=false, }<CR>", "Filesystem" },
  g = { "<cmd>lua require'telescope.builtin'.live_grep{}<CR>", "grep at cwd" },
  o = { "<cmd>lua require'telescope.builtin'.live_grep{ grep_open_files=true }<CR>", "grep Opened files" },
  S = { "<cmd>SearchSession<CR>", "Session" },
  t = { "<cmd>Telescope tele_tabby list theme=get_dropdown previewer=false border=false<CR>", "tabs" },
  v = {
    name = "vim",
    C = { "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>", "colorscheme" },
    c = { "<cmd>lua require'telescope.builtin'.command_history{}<CR>", "command history" },
    f = { "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", "fuzzy find buf" },
    h = { "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", "help tags" },
    H = { "<cmd>lua require'telescope.builtin'.highlights{}<CR>", "Highlights" },
    m = { "<cmd>lua require'telescope.builtin'.man_pages{}<CR>", "man pages" },
    o = { "<cmd>lua require'telescope.builtin'.vim_options{}<CR>", "options vim edit" },
    p = { "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", "prev opened files" },
    r = { "<cmd>lua require'telescope.builtin'.registers{}<CR>", "registers" },
    s = { "<cmd>lua require'telescope.builtin'.search_history{}<CR>", "search history" },
    T = { "<cmd>lua require'telescope.builtin'.current_buffer_tags{}<CR>", "tags buf" },
    k = { "<cmd>Telescope keymaps<CR>", "keymaps" },
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

wk.register({ x = {
  name = "xtab",
  t = { name = "tab" },
  b = { name = "buf" },
  s = { name = "ses" },
}, }, { prefix = "<leader>" })

wk.register({ z = {
  name = "zen",
  A = { "<cmd>TZAtaraxis l10 r10 t3 b1<CR>", "Ataraxis wide" },
  c = { "<cmd>TZAtaraxis<CR>", "centered" },
  f = { "<cmd>TZFocus<CR>", "focus" },
  m = { "<cmd>TZMinimalist<CR>", "minimalist" },
}, }, { prefix = "<localleader>" })
