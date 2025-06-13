-- 'folke/which-key.nvim' spec

return {
  'folke/which-key.nvim',
  version = '*',
  event = 'VeryLazy',
  ---@class which-key.Opts
  opts = {
    preset = 'classic',
    delay = 800,
    notify = true, -- TODO: toggle after updates | show a warning when issues were detected with your mappings
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

      { "<C-k>", desc = "[LSP] signature help" }, -- LSP - just a label. don't create any mappings
      { "gD", desc = "[LSP] declaration" },
      { "gd", desc = "[LSP] definition" },
      { "gi", desc = "[LSP] implementation" },
      { "gr", desc = "[LSP] references" },
      { "[d", desc = "[LSP] prev diag" },
      { "]d", desc = "[LSP] next diag" },

      { "<leader>l",  group = "lsp" },
      { "<leader>lD",  desc = "type definition" },
      { "<leader>la",  desc = "action" },
      { "<leader>le",  desc = "show/enter line diag" },
      { "<leader>lf",  desc = "formatting" },
      { "<leader>lh",  desc = "hover" },
      { "<leader>ll",  desc = "list diag" },
      { "<leader>lr",  desc = "rename" },
      { "<leader>lw",  group = "workspace" },
      { "<leader>lwa",  desc = "add workspace folder" },
      { "<leader>lwl",  desc = "list workspace folders" },
      { "<leader>lwr",  desc = "remove workspace folder" },

      { "<leader>M", group = "Magit" },
      { "<leader>Mh", "<cmd>call magit#show_magit('h')<CR>", desc = "hrz" },
      { "<leader>Mo", "<cmd>call magit#show_magit('c')<CR>", desc = "only" },
      { "<leader>Mv", desc = "vrt" }, -- magit cannot unbind def mapping

      { "<leader>N", group = "Neogit" },
      { "<leader>NS", "<cmd>lua require('neogit').open({ kind = 'split_above' })<CR>", desc = "split above" },
      { "<leader>Nc", "<cmd>lua require('neogit').open({ 'commit' })<CR>", desc = "commit" },
      { "<leader>Ns", "<cmd>lua require('neogit').open({ kind = 'split' })<CR>", desc = "split below" },
      { "<leader>Nt", "<cmd>lua require('neogit').open({ kind = 'tab' })<CR>", desc = "tab" },
      { "<leader>Nv", "<cmd>lua require('neogit').open({ kind = 'vsplit' })<CR>", desc = "vsplit" },

      { "<leader>T", group = "Telescope" },
      { "<leader>TB", "<cmd>lua require'telescope.builtin'.buffers{}<CR>", desc = "buffers w preview" },
      { "<leader>TD", ":lua require'telescope.builtin'.live_grep({search_dirs={ '', }})<C-Left><C-Left><Right>", desc = "grep in list of dirs" },
      { "<leader>TF", "<cmd>lua require'telescope'.extensions.file_browser.file_browser{ hidden=false, respect_gitignore=false, }<CR>", desc = "Filesystem" },
      { "<leader>TS", "<cmd>SessionSearch<CR>", desc = "Session" },
      { "<leader>Tb", "<cmd>Telescope buffers theme=dropdown previewer=false border=false<CR>", desc = "buffers" },
      { "<leader>Tc", "<cmd>lua require'telescope.builtin'.grep_string{}<CR>", desc = "grep under Cursor at cwd" },
      { "<leader>Td", "<cmd>Telescope diagnostics<CR>", desc = "diagnostics" },
      { "<leader>Tf", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", desc = "find file at cwd" },
      { "<leader>Tg", "<cmd>lua require'telescope.builtin'.live_grep{}<CR>", desc = "grep at cwd" },
      { "<leader>To", "<cmd>lua require'telescope.builtin'.live_grep{ grep_open_files=true }<CR>", desc = "grep Opened files" },
      { "<leader>Tt", "<cmd>Telescope tele_tabby list theme=dropdown previewer=false border=false<CR>", desc = "tabs" },
      { "<leader>Tv", group = "vim" },
      { "<leader>TvC", "<cmd>lua require'telescope.builtin'.colorscheme{}<CR>", desc = "colorscheme" },
      { "<leader>TvH", "<cmd>lua require'telescope.builtin'.highlights{}<CR>", desc = "Highlights" },
      { "<leader>TvT", "<cmd>lua require'telescope.builtin'.current_buffer_tags{}<CR>", desc = "tags buf" },
      { "<leader>Tvc", "<cmd>lua require'telescope.builtin'.command_history{}<CR>", desc = "command history" },
      { "<leader>Tvf", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", desc = "fuzzy find buf" },
      { "<leader>Tvh", "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", desc = "help tags" },
      { "<leader>Tvk", "<cmd>Telescope keymaps<CR>", desc = "keymaps" },
      { "<leader>Tvm", "<cmd>lua require'telescope.builtin'.man_pages{}<CR>", desc = "man pages" },
      { "<leader>Tvo", "<cmd>lua require'telescope.builtin'.vim_options{}<CR>", desc = "options vim edit" },
      { "<leader>Tvp", "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", desc = "prev opened files" },
      { "<leader>Tvr", "<cmd>lua require'telescope.builtin'.registers{}<CR>", desc = "registers" },
      { "<leader>Tvs", "<cmd>lua require'telescope.builtin'.search_history{}<CR>", desc = "search history" },

      { -- translate normal mode
        mode = { "n" },
        { "<leader>t", group = "trans" },
        { "<leader>t!l", "<cmd>normal V<CR> | :'<,'>TranslateW!<CR>", desc = "line" },
        { "<leader>t!r", "<cmd>normal V<CR> | :'<,'>TranslateR!<CR>", desc = "replace line" },
        { "<leader>t!w", "<cmd>TranslateW!<CR>", desc = "word" },
        { "<leader>tl", "<cmd>normal V<CR> | :'<,'>TranslateW<CR>", desc = "line" },
        { "<leader>tr", "<cmd>normal V<CR> | :'<,'>TranslateR<CR>", desc = "replace line" },
        { "<leader>tw", "<cmd>TranslateW<CR>", desc = "word" },
      },

      { -- translate visual mode
        mode = { "v" },
        { "<leader>t", group = "trans" },
        { "<leader>t!r", ":'<,'>TranslateR!<CR>", desc = "replace" },
        { "<leader>t!w", ":'<,'>TranslateW!<CR>", desc = "window" },
        { "<leader>tr",  ":'<,'>TranslateR<CR>",  desc = "replace" },
        { "<leader>tw",  ":'<,'>TranslateW<CR>",  desc = "window" },
      },

      { "<leader>x",  group = "xtab" },
      { "<leader>xb", group = "buf" },
      { "<leader>xs", group = "ses" },
      { "<leader>xt", group = "tab" },

      { "<localleader>z", group = "zen" },
      { "<localleader>zA", "<cmd>TZAtaraxis l10 r10 t3 b1<CR>", desc = "Ataraxis wide" },
      { "<localleader>zc", "<cmd>TZAtaraxis<CR>", desc = "centered" },
      { "<localleader>zf", "<cmd>TZFocus<CR>", desc = "focus" },
      { "<localleader>zm", "<cmd>TZMinimalist<CR>", desc = "minimalist" },
    }, -- END spec
  },
}
