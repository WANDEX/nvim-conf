-- AUTHOR: 'WANDEX/nvim-conf'
-- enable the following language servers
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim

local M = {}

--- Enable the following language servers
--- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
---
--- Add any additional override configuration in the following tables. Available keys are:
--- - cmd (table): Override the default command used to start the server
--- - filetypes (table): Override the default list of associated filetypes for the server
--- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--- - settings (table): Override the default settings passed when initializing the server.
---       For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
M.servers = {
  clangd = {},
  lua_ls = {},
  neocmake = {},
  pyright = {},
  ts_ls = {},
}

--[[
--- properly configured via 'folke/lazydev.nvim'.
--- overrides only values explicitly passed, changes will be merged.
M.servers.lua_ls = {
  settings = {
    Lua = {
      runtime = { -- tell the language server which version of Lua you're using
        version = 'LuaJIT', -- (most likely LuaJIT in the case of Neovim)
      },
      diagnostics = {
        globals = {
          'vim', -- get the language server to recognize the `vim` global
          'require'
        },
      },
      workspace = { -- make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false, -- do not send telemetry data containing a randomized but unique identifier
      },
    },
    -- flags = {
    --   debounce_text_changes = 150,
    -- },
  },
}
--]]

return M
