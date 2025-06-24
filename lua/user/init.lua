-- AUTHOR: 'WANDEX/nvim-conf'

-- good idea to set following early in the config, because otherwise
-- any mappings set BEFORE doing this, will be set to the OLD Leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.python3_host_prog = '/usr/bin/python'

-- set some global variables to use as configuration throughout the config.
-- these do not have any special meaning.
vim.g.snippets = 'luasnip'

require 'user.options'
require 'user.keymaps'

require 'user.globals' -- setup globals expected to be always available.

require 'user.diagnostic'

-- vim.lsp.config('*')
-- vim.lsp.config('*', {
--   root_markers = { '.git' },
--   -- flags = {
--   --   debounce_text_changes = 150,
--   -- },
-- })

-- vim.lsp.config('lua_ls', {
--   settings = {
--     Lua = {
--       runtime = { -- tell the language server which version of Lua you're using
--         version = 'LuaJIT', -- (most likely LuaJIT in the case of Neovim)
--       },
--       diagnostics = {
--         globals = {
--           'vim', -- get the language server to recognize the `vim` global
--           'require'
--         },
--       },
--       workspace = { -- make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       telemetry = {
--         enable = false, -- do not send telemetry data containing a randomized but unique identifier
--       },
--     },
--     -- flags = {
--     --   debounce_text_changes = 150,
--     -- },
--   },
-- })

-- luals not works, what is it? standard lua - not nvim?
-- vim.lsp.enable({'luals', 'clangd', 'pyright', 'ts_ls'})
vim.lsp.enable({'lua_ls', 'clangd', 'pyright', 'ts_ls'})

require('user.lazy').load({
  profiling = {
    -- loader = true,  -- debug tab extra stats: loader cache + package.loaders.
    -- require = true, -- track each new require in the Lazy profiling tab
  },
})

require 'user.fn'
require 'user.hi'
