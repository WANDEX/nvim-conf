-- AUTHOR: 'WANDEX/nvim-conf'
-- enable the following language servers
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim
-- ^ NOTE: use vim.lsp.config -> handlers were removed in mason-lspconfig.nvim@2.0.0

local M = {}

-- add default neocmake LSP conf (seems it does not exist in lspconfig)
vim.lsp.config.neocmake = {
  cmd = { 'neocmakelsp', 'stdio' }, -- fix: stdio command not --stdio!
  filetypes = { 'cmake' },
  --- (field) vim.lsp.Config.root_dir: (string|fun(bufnr: integer, on_dir: fun(root_dir?: string)))?
  --- function (bufnr: integer, on_dir: fun(root_dir?: string))
  root_dir = function(bufnr, on_dir) ---@diagnostic disable-line: unused-local
    local cwd = vim.fn.getcwd()
    local dir = vim.fs.find({ '.git', }, { path = cwd, type='directory', upward = true })[1]
    return on_dir(dir)
    -- return vim.fn.getcwd()
  end,
  single_file_support = true,-- suggested
  -- on_attach = on_attach, -- on_attach is the on_attach function you defined
  init_options = {
    format = {
      enable = false,
    },
    lint = {
      enable = true,
    },
    --- it will deeply check the cmake file which found when search cmake packages.
    scan_cmake_in_package = true,
    --- semantic_token heighlight. if you use treesitter highlight, it is suggested to set with false.
    --- it can be used to make better highlight for vscode which only has textmate highlight
    semantic_token = false,
  },
}

--[[
--- properly configured via 'folke/lazydev.nvim'.
--- overrides only values explicitly passed, changes will be merged.
vim.lsp.config.lua_ls = {
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

--- Enable the following language servers
--- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
---
--- Add any additional override configuration in the following tables. Available keys are:
--- - cmd (table): Override the default command used to start the server
--- - filetypes (table): Override the default list of associated filetypes for the server
--- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--- - settings (table): Override the default settings passed when initializing the server.
---       For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
M.servers = { --- LSP
  clangd            = vim.lsp.config.clangd   or {},
  lua_ls            = vim.lsp.config.lua_ls   or {},
  neocmake          = vim.lsp.config.neocmake or {},
  pyright           = vim.lsp.config.pyright  or {},
  ts_ls             = vim.lsp.config.ts_ls    or {},
}

return M
