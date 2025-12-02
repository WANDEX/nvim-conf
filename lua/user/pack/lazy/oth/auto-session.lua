-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'rmagatti/auto-session'

return {
  'rmagatti/auto-session',
  lazy = false,
  enabled = true,
  ---enables autocomplete for opts
  ---@module 'auto-session'
  ---@type AutoSession.Config
  opts = {
    enabled = true,
    root_dir = require('user.lib.fn').path.concat({ vim.fn.stdpath('data'), 'sessions' }),
    auto_save = true,
    auto_restore = true,
    auto_create = false,
    log_level = 'error',
    ---@type SessionLens
    session_lens = {
      previewer = nil,
      path_display = { 'shorten' },
      theme_conf = { border = false },
    },
  },
  config = function(_, opts) -- Recommended sessionoptions config
    vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    require('auto-session').setup(opts)
  end,
  keys = {
    { mode = 'n', '<leader>TS', '<cmd>AutoSession search<CR>', desc = 'Session' },
  },
}
