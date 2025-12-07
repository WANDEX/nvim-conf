-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mason-org/mason.nvim'
--      Portable package manager for Neovim that runs everywhere Neovim runs.
--      Easily install and manage LSP servers, DAP servers, linters, and formatters.
-- spec 'WhoIsSethDaniel/mason-tool-installer.nvim'
--      auto install/update via ensure_installed option: DAP, linters, formatters.
-- spec 'mason-org/mason-lspconfig.nvim'
--      bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together.
-- spec 'neovim/nvim-lspconfig'
--      collection of configurations for built-in LSP client! (CORE)
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim
-- ^ NOTE: use vim.lsp.config -> handlers were removed in mason-lspconfig.nvim@2.0.0

local M = {}

-- TODO: make function & mapping which puts 'ensure_installed = {}'.
-- Which generates table with all currently installed by mason packages.
-- To easily update ensure_installed_tbl.

--- mason-tool-installer's list of all tools you want to ensure are installed upon start.
---@return table
function M.ensure_installed_tbl()
  local tbl = vim.tbl_keys(require('user.lsp.serv').servers() or {})
  vim.list_extend(tbl, {
    --- DAP:
    --- linters:
    'cmakelint',
    'cpplint',
    'ruff',
    'shellcheck',
    --- formatters:
    'clang-format',
    'ruff',
    'shfmt',
  })
  return tbl
end

M.spec = {

  { --- mason must be loaded before its dependents
    'mason-org/mason.nvim',
    opts = { ---the directory in which to install packages.
      install_root_dir = require('user.lib.fn').path.concat({ vim.fn.stdpath('data'), 'pack', 'mason' }),
      --- NOTE: does not work properly with 'prepend':
      --- ERROR in lsp.log about libbfd-2.38-system.so for "lua-language-server", etc.
      --- This is because detection of distro / platform-specific shared libs is not robust.
      PATH = 'append', ---@type '"prepend"' | '"append"' | '"skip"'
      ui = {
        icons = {
          package_installed = '',
          package_pending = '󰅐',
          package_uninstalled = '󰢘',
        },
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      auto_update = false, --- auto check each tool for updates & update.
      run_on_start = true, --- auto install / update on startup.
      debounce_hours = 5,  --- at least N hours between attempts to install/update.
    },
    config = function(_, opts)
      opts.ensure_installed = M.ensure_installed_tbl()
      require('mason-tool-installer').setup(opts)
    end,
    dependencies = { -- for the proper loading order of dependencies & configuration requirements
      { 'mason-org/mason.nvim' },
      { 'mason-org/mason-lspconfig.nvim' },
    },
  },

  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      --- Explicitly set to an empty table (installed in/via mason-tool-installer)
      ensure_installed = {},
      --- Whether installed servers should automatically be enabled via `:h vim.lsp.enable()`.
      ---@type boolean | string[] | { exclude: string[] }
      automatic_enable = true,
      --[[ XXX: handlers were removed in mason-lspconfig.nvim@2.0.0 -> use vim.lsp.config
      handlers = {
        function(server_name)
          local server = require('user.lsp.serv').servers[server_name] or {}
          vim.notify(P(server), vim.log.levels.WARN)
          local capabilities = require('blink.cmp').get_lsp_capabilities()
          --- This handles overriding only values explicitly passed
          --- by the server configuration above. Useful when disabling
          --- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
      --]]
    },
    -- config = function(_, opts)
    --   require('mason-lspconfig').setup(opts)
    -- end,
    dependencies = { -- for the proper loading order of dependencies & configuration requirements
      { 'mason-org/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'saghen/blink.cmp' }, -- get_lsp_capabilities()
    },
  },

  { -- main LSP configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} }, -- floating LSP status updates window.
    },
  },

}

return M.spec
