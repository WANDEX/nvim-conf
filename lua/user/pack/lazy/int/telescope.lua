-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-telescope/telescope.nvim'

return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  event = { 'VeryLazy' },
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
      prompt_prefix = '> ',
      selection_caret = '> ',
      entry_prefix = '  ',
      multi_icon = '<>',
      selection_strategy = 'reset',
      sorting_strategy = 'descending',
      scroll_strategy = 'cycle',
      color_devicons = true,
      winblend = 0,
      layout_strategy = 'flex',
      layout_config = {
        width = 0.9,
        height = 0.95,
        prompt_position = 'bottom',
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
          ['<M-p>'] = action_layout.toggle_preview,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-e>'] = actions.move_selection_previous,
          ['<C-p>'] = false,
          ['<C-c>'] = false,
          ['<C-l>'] = actions.close,
        },
        n = {
          ['n'] = actions.move_selection_next,
          ['e'] = actions.move_selection_previous,
          ['j'] = false,
          ['k'] = false,
          ['<C-l>'] = actions.close,
        },
      },
    }
    opts.extensions = {
      fzf = {
        fuzzy = true,                     -- false will only do exact matching
        override_generic_sorter = false,  -- override the generic sorter
        override_file_sorter = true,      -- override the file sorter
        case_mode = 'smart_case',         -- 'ignore_case' or 'respect_case' or 'smart_case'
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
  keys = {
    { "<leader>T", "", desc = "Telescope" }, -- group annotation
    { "<leader>TB", "<cmd>lua require'telescope.builtin'.buffers{}<CR>", desc = "buffers w preview" },
    { "<leader>TB", "<cmd>lua require'telescope.builtin'.buffers{}<CR>", desc = "buffers w preview" },
    -- { "<leader>TD", ":lua require'telescope.builtin'.live_grep({search_dirs={ '', }})<C-Left><C-Left><Right>", desc = "grep in list of dirs" },
    { "<leader>TF", "<cmd>lua require'telescope'.extensions.file_browser.file_browser{ hidden=false, respect_gitignore=false, }<CR>", desc = "Filesystem" },
    { "<leader>Tb", "<cmd>Telescope buffers theme=dropdown previewer=false border=false<CR>", desc = "buffers" },
    { "<leader>Tc", "<cmd>lua require'telescope.builtin'.grep_string{}<CR>", desc = "grep under Cursor at cwd" },
    { "<leader>Td", "<cmd>Telescope diagnostics<CR>", desc = "diagnostics" },
    { "<leader>Tf", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", desc = "find file at cwd" },
    { "<leader>Tg", "<cmd>lua require'telescope.builtin'.live_grep{}<CR>", desc = "grep at cwd" },
    { "<leader>To", "<cmd>lua require'telescope.builtin'.live_grep{ grep_open_files=true }<CR>", desc = "grep Opened files" },
    { "<leader>Tt", "<cmd>Telescope tele_tabby list theme=dropdown previewer=false border=false<CR>", desc = "tabs" },
    { "<leader>Tv", "", desc = "vim" }, -- group annotation
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
    { "<leader>TG", "", desc = "Generate/GrugFar" }, -- group annotation
  },
}
