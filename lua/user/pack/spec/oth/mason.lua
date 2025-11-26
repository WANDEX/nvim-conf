-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mason-org/mason.nvim'

return {
  'mason-org/mason.nvim',
  opts = {
    -- the directory in which to install packages.
    install_root_dir = require('user.lib.fn').path.concat({ vim.fn.stdpath('data'), 'pack', 'mason' }),

    ---@type '"prepend"' | '"append"' | '"skip"'
    PATH = "prepend",

    ui = {
      icons = {
        package_installed = '',
        package_pending = '󰅐',
        package_uninstalled = '󰢘',
      },
    },
  },
}
