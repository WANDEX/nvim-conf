-- AUTHOR: 'WANDEX/nvim-conf'
-- load 'folke/lazy.nvim' plugin manager

local M = {}

---@param opts LazyConfig
function M.load(opts)
  opts = vim.tbl_deep_extend('force', {
    root   = require('user.lib.fn').path.concat({ vim.fn.stdpath('data'), 'pack', 'lazy' }), -- dir for plugins
    rocks  = {
      root = require('user.lib.fn').path.concat({ vim.fn.stdpath('data'), 'pack', 'lazy', 'lazy-rocks' }),
    },
    spec = {
      { import = 'user.pack.lazy.fmt' },
      { import = 'user.pack.lazy.git' },
      { import = 'user.pack.lazy.int' },
      { import = 'user.pack.lazy.oth' },
      { import = 'user.pack.lazy.vis' },
    },
    git = {
      log = { '-8' }, -- show last 8 commits
    },
    checker = { enabled = false },
    change_detection = {
      enabled = false, -- automatically check for config file changes and reload the ui
      notify = true, -- get a notification when changes are found
    },
    diff = { -- diff command <d> can be one of:
      -- * git: will run git diff and open a buffer with filetype git
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = 'diffview.nvim',
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          -- 'matchparen',
          'netrwPlugin',
          'rplugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
  }, opts or {})
  require('lazy').setup(opts)
  return opts
end

return M
