-- AUTHOR: 'WANDEX/nvim-conf'

require 'user.lsp.diag'
require 'user.lsp.keys'

vim.lsp.enable({'lua_ls', 'clangd', 'neocmake', 'pyright', 'ts_ls'})

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
