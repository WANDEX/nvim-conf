-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-telescope/telescope.nvim'

local M = {}

--- wrapper for the telescope get_dropdown() to merge with default opts.
--- currently there is no way to set these parameters as default
--- specifically for the dropdown theme.
--- (according to the research by: WNDX | date: 2025-12-13 03:41:48 UTC)
---@param opts? table
---@return table
function M.get_dropdown(opts)
  return require('telescope.themes').get_dropdown(vim.tbl_deep_extend('force', {
    border = true,
    previewer = false,
    shorten_path = false,
    --- ref layout_config_defaults: telescope.nvim/lua/telescope/config.lua
    layout_config = {
      width  = 0.5,
      height = 0.5,
      --- when explicitly set - fixes missing borders issue when winblend=0.
      prompt_position = 'top', -- 'top', 'bottom'
    },
  }, opts or {}))
end

function M.tele_tabby()
  require('telescope').extensions.tele_tabby.list(M.get_dropdown())
end

--- call telescope extension dap function based on key.
---@param key string char
function M.dap_fn(key)
  if key == '' or nil then
    return -- guard
  end
  local dropdown_opts = {
    layout_config = {
      width  = 0.5,
      height = 0.95,
    },
  }
  local opts = M.get_dropdown(dropdown_opts)
  if key == 'b' then
    require('telescope').extensions.dap.list_breakpoints(opts)
  elseif key == 'C' then
    require('telescope').extensions.dap.configurations(opts)
  elseif key == 'c' then
    require('telescope').extensions.dap.commands(opts)
  elseif key == 'f' then
    require('telescope').extensions.dap.frames(opts)
  elseif key == 'v' then
    require('telescope').extensions.dap.variables(opts)
  else
    vim.notify(("key '%s' does not have paired command"):format(key), vim.log.levels.ERROR)
  end
end

M.spec = {
  'nvim-telescope/telescope.nvim',
  version = '*',
  event = { 'VeryLazy' },
  dependencies = {
    { 'TC72/telescope-tele-tabby.nvim' }, -- :h :tcd
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' }, -- sets vim.ui.select to telescope
    {
      'rodrigo-sys/telescope-mantoc', -- man pages extension to navigate the table of content
      commit = 'cdc052565e8896578e55146de9ee11207a90d9d5', -- XXX: just a tmp pin, without meaning
    },
    { 'TheLeoP/project.nvim' }, -- project.nvim fork: modern api, fixes for win os, etc.
  },
  opts = {
    defaults = {
      -- winblend = vim.opt.winblend or 0,
      prompt_prefix = '> ',
      selection_caret = '> ',
      entry_prefix = '  ',
      multi_icon = '<>',
      selection_strategy = 'reset',
      sorting_strategy = 'descending',
      scroll_strategy = 'cycle',
      color_devicons = true,
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
          ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
          ['<C-n>'] = require('telescope.actions').move_selection_next,
          ['<C-e>'] = require('telescope.actions').move_selection_previous,
          ['<C-p>'] = false,
          ['<C-c>'] = false,
          ['<C-l>'] = require('telescope.actions').close,
        },
        n = {
          ['n'] = require('telescope.actions').move_selection_next,
          ['e'] = require('telescope.actions').move_selection_previous,
          ['j'] = false,
          ['k'] = false,
          ['<C-l>'] = require('telescope.actions').close,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                     -- false will only do exact matching
        override_generic_sorter = false,  -- override the generic sorter
        override_file_sorter = true,      -- override the file sorter
        case_mode = 'smart_case',         -- 'ignore_case' or 'respect_case' or 'smart_case'
      },
      tele_tabby = {
        use_highlighter = true,
      },
      ['ui-select'] = {
        M.get_dropdown(),
      },
    }
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    --- enable Telescope extensions if they are installed
    ---  dap extension also overrides dap internal ui, so running any dap command,
    ---  which makes use of the internal ui, will result in a telescope prompt.
    pcall(require('telescope').load_extension, 'dap')
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'mantoc')
    pcall(require('telescope').load_extension, 'projects') -- local fork of telescope projects extension
    --- maybe also:
    --- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
    --- https://github.com/nvim-telescope/telescope-cheat.nvim
    --- https://github.com/yorik1984/telescope-cheat-md.nvim
  end,
  keys = {
    { '<leader>T',  '', desc = 'Telescope' }, -- group annotation
    { '<leader>Ta', '', desc = '[DAP] commands' },
    { '<leader>Tab', function() M.dap_fn('b') end, desc = 'breakpoints' },
    { '<leader>TaC', function() M.dap_fn('C') end, desc = 'Configurations' },
    { '<leader>Tac', function() M.dap_fn('c') end, desc = 'commands' },
    { '<leader>Taf', function() M.dap_fn('f') end, desc = 'frames' },
    { '<leader>Tav', function() M.dap_fn('v') end, desc = 'variables' },
    { '<leader>TB', require('telescope.builtin').buffers, desc = 'buffers preview' },
    {
      '<leader>Tb', function()
        require('telescope.builtin').buffers(M.get_dropdown())
      end, desc = 'buffers'
    },
    { --- shortcut for searching nvim configuration files
      '<leader>TC', function()
        require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
      end, desc = 'grep Config (nvim)'
    },
    { '<leader>Tc', require('telescope.builtin').grep_string, desc = 'grep under cursor at cwd' },
    --[[
    { '<leader>TD',
        ":lua require('telescope.builtin').live_grep(" ..
        "{search_dirs={ '', }})<C-Left><C-Left><Right>", --- shift cursor inside ''
      desc = 'grep in list of dirs'
    },
    --]]
    { --- same as above but using lua nvim api functions! (left for the future reference)
      '<leader>TD', function()
        local lua_fun = "require('telescope.builtin').live_grep({ search_dirs={ '', } })"
        local key_seq = '<C-Left><C-Left><C-Left><Right>' -- shift cursor inside ^ == ''
        local key_cod = vim.api.nvim_replace_termcodes(key_seq, true, false, true)
        local res_str = ":lua " .. lua_fun
        vim.api.nvim_feedkeys(res_str, 'n',   true)
        vim.api.nvim_feedkeys(key_cod, 'nx!', true)
      end, desc = 'grep in list of dirs'
    },
    { '<leader>Td', require('telescope.builtin').diagnostics, desc = 'diagnostics' },
    { '<leader>Tf', require('telescope.builtin').find_files,  desc = 'find file at cwd' },
    { '<leader>Tg', require('telescope.builtin').live_grep,   desc = 'grep at cwd' },
    { '<leader>Tm', '<cmd>Telescope mantoc sorting_strategy=ascending<CR>', desc = 'mantoc' },
    {
      '<leader>To', function()
        require('telescope.builtin').live_grep({ grep_open_files=true })
      end, desc = 'grep opened files'
    },
    {
      '<leader>TP', function() -- project.nvim
        require('telescope').extensions.projects.projects()
      end, desc = 'Projects'
    },
    { '<leader>Tt', M.tele_tabby, desc = 'tabs' },
    { '<leader>Tv', '', desc = 'vim' }, -- group annotation
    { '<leader>TvC', require('telescope.builtin').colorscheme,                desc = 'colorscheme' },
    { '<leader>TvH', require('telescope.builtin').highlights,                 desc = 'Highlights' },
    { '<leader>TvT', require('telescope.builtin').current_buffer_tags,        desc = 'tags buf' },
    { '<leader>Tvc', require('telescope.builtin').command_history,            desc = 'command history' },
    { '<leader>Tvf', require('telescope.builtin').current_buffer_fuzzy_find,  desc = 'fuzzy find buf' },
    { '<leader>Tvh', require('telescope.builtin').help_tags,                  desc = 'help tags' },
    { '<leader>Tvk', require('telescope.builtin').keymaps,                    desc = 'keymaps' },
    { '<leader>Tvm', require('telescope.builtin').man_pages,                  desc = 'man pages' },
    { '<leader>Tvo', require('telescope.builtin').vim_options,                desc = 'options vim edit' },
    { '<leader>Tvp', require('telescope.builtin').oldfiles,                   desc = 'prev opened files' },
    { '<leader>TvR', require('telescope.builtin').resume,                     desc = 'resume prev picker' },
    { '<leader>Tvr', require('telescope.builtin').registers,                  desc = 'registers' },
    { '<leader>Tvs', require('telescope.builtin').search_history,             desc = 'search history' },
    { '<leader>TG', '', desc = 'Generate/GrugFar' }, -- group annotation
  },
}

return M.spec
