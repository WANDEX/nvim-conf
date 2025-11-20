-- AUTHOR: 'WANDEX/nvim-conf'

vim.keymap.set('n', "gK",    function() return vim.lsp.buf.signature_help() end, { desc = "[LSP] Signature Help"})
vim.keymap.set('i', "<c-k>", function() return vim.lsp.buf.signature_help() end, { desc = "[LSP] Signature Help"})

vim.keymap.set('n', "gd", vim.lsp.buf.definition,       { desc = "[LSP] definition" })
vim.keymap.set('n', "gr", vim.lsp.buf.references,       { desc = "[LSP] references", nowait = true })
vim.keymap.set('n', "gI", vim.lsp.buf.implementation,   { desc = "[LSP] Implementation" })
vim.keymap.set('n', "gy", vim.lsp.buf.type_definition,  { desc = "[LSP] t[y]pe definition" })
vim.keymap.set('n', "gD", vim.lsp.buf.declaration,      { desc = "[LSP] Declaration" })

-- vim.keymap.set('n', "<leader>cA", LazyVim.lsp.action.source, { desc = "Source Action" })
vim.keymap.set('n', "<leader>lC",         vim.lsp.codelens.refresh,   { desc = "[LSP] Refresh & Display Codelens"})
vim.keymap.set('n', "<leader>lh",         vim.lsp.buf.hover,          { desc = "[LSP] hover" })
vim.keymap.set('n', "<leader>lr",         vim.lsp.buf.rename,         { desc = "[LSP] rename" })
vim.keymap.set('n', '<leader>le',         vim.diagnostic.open_float,  { desc = "[LSP] diag enter/show" })
vim.keymap.set('n', '<leader>ll',         vim.diagnostic.setloclist,  { desc = "[LSP] list diag" })
vim.keymap.set({'n', 'v'}, "<leader>la",  vim.lsp.buf.code_action,    { desc = "[LSP] Code Action" })
vim.keymap.set({'n', 'v'}, "<leader>lc",  vim.lsp.codelens.run,       { desc = "[LSP] Run Codelens" })
