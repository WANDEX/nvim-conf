-- taken from feline.nvim (GPL v3.0)
-- 'https://github.com/feline-nvim/feline.nvim/blob/master/lua/feline/providers/lsp.lua'
local M = {}

local lsp = vim.lsp
local diagnostic = vim.diagnostic

local severity_names = { 'Error', 'Warning', 'Information', 'Hint' }

function M.is_lsp_attached()
    return next(lsp.buf_get_clients(0)) ~= nil
end

function M.get_diagnostics_count(severity)
    return vim.tbl_count(diagnostic.get(0, severity and { severity = severity }))
end

function M.diagnostics_exist(severity)
    return M.get_diagnostics_count(severity) > 0
end

function M.lsp_client_names()
    local clients = {}

    for _, client in pairs(lsp.buf_get_clients(0)) do
        clients[#clients + 1] = client.name
    end

    return table.concat(clients, ' '), ' '
end

-- Common function used by the diagnostics providers
local function diagnostics(severity)
    local count = M.get_diagnostics_count(severity)

    return count ~= 0 and tostring(count) or ''
end

function M.diagnostic_errors()
    return diagnostics(1), '  '
end

function M.diagnostic_warnings()
    return diagnostics(2), '  '
end

function M.diagnostic_info()
    return diagnostics(3), '  '
end

function M.diagnostic_hints()
    return diagnostics(4), '  '
end

return M
