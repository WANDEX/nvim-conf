-- AUTHOR: 'WANDEX/nvim-conf'
-- enable the following language servers
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim
-- ^ NOTE: use vim.lsp.config -> handlers were removed in mason-lspconfig.nvim@2.0.0

local M = {}

--- extend vim.lsp.Config with lspconfig.util.default_config.
--- NOTE: I am not sure that this is needed since nvim 0.11.
--- If I understand subject properly, servers are initialized with this by default.
--- If loading order of the lspconfig plugin is ordered before vim.lsp.config().
--- Is this true, is this done by default?
--- https://github.com/neovim/neovim/discussions/35942
---@param s_cfg? table LSP server config
---@return vim.lsp.Config?
function M.lspconfig_default_config(s_cfg)
  -- local ok, lspconfig = pcall(require, 'lspconfig')
  -- if not ok then return end -- guard
  local lspconfig = require('lspconfig') -- if plugins loading order is wrong this will throw error.
  local default_config = vim.deepcopy(lspconfig.util.default_config or {}) -- copy to avoid mutation
  if s_cfg == nil then
    return default_config
  else
    s_cfg = vim.tbl_deep_extend('force', {}, default_config, s_cfg or {})
  end
end

--- extend lsp.ClientCapabilities with blink_cmp capabilities.
---@param s_cfg? table LSP server config
---@return lsp.ClientCapabilities?
function M.blink_cmp_capabilities(s_cfg)
  local ok, blink_cmp = pcall(require, 'blink.cmp')
  if not ok then return end -- guard
  local default_config = true --- whether to include nvim's default cap. (param include_nvim_defaults)
  --- if true - gives very similar config as M.lspconfig_default_config()
  local capabilities = blink_cmp.get_lsp_capabilities({}, default_config) ---@type lsp.ClientCapabilities
  if s_cfg == nil then
    return { capabilities = capabilities }
  else
    s_cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, s_cfg.capabilities or {})
  end
end

--- merge tables into one vim.lsp.Config table for specific LSP server name
---@nodiscard
---@param name string LSP server name
---@param ... table (0 or more, variadic)
---@return vim.lsp.Config
function M.tbl_srv_mrg_cfg(name, ...)
  local srv_cfg_def = vim.deepcopy(vim.lsp.config[name] or {}) -- copy to avoid mutation

  -- M.lspconfig_default_config(srv_cfg_def)
  -- M.blink_cmp_capabilities(srv_cfg_def)

  local nargs = select('#', ...)
  if nargs == 0 then
    return vim.tbl_deep_extend('force', {}, srv_cfg_def)
  else
    return vim.tbl_deep_extend('force', {}, srv_cfg_def, ...)
  end
end

--- (field) vim.lsp.Config.root_dir: (string|fun(bufnr: integer, on_dir: fun(root_dir?: string)))?
--- function (bufnr: integer, on_dir: fun(root_dir?: string))
function M.root_dir(bufnr, on_dir) ---@diagnostic disable-line: unused-local
  local  path = require('user.lib.fn').path.root_dir()
  on_dir(path)
end

function M.common_srv_mrg_cfg()
  --- XXX: default lspconfig.util.default_config (not sure that this is needed since nvim 0.11)
  ---      NOT needed with param include_nvim_defaults in blink_cmp.get_lsp_capabilities.
  -- vim.lsp.config('*', M.tbl_srv_mrg_cfg('*', M.lspconfig_default_config()))
  -- vim.lsp.config('*', M.tbl_srv_mrg_cfg('*', M.lspconfig_default_config(), M.blink_cmp_capabilities()))

  --- add additional capabilities to all clients from blink_cmp
  vim.lsp.config('*', M.tbl_srv_mrg_cfg('*', M.blink_cmp_capabilities()))

  vim.lsp.config('*', {
    root_dir = M.root_dir,
  })
end

--- add additional LSP server features to build-in LSP configurations of nvim.
--- merge LSP configs to later auto enable these servers.
--- these servers will be automatically installed via mason.
---
--- add any additional override configuration in the following tables. Available keys are:
--- - cmd (table): Override the default command used to start the server
--- - filetypes (table): Override the default list of associated filetypes for the server
--- - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--- - settings (table): Override the default settings passed when initializing the server.
---       For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
---@return vim.lsp.Config[] vim.lsp.config[] list of tables
function M.servers()
  M.common_srv_mrg_cfg()
  return {
    clangd      = M.tbl_srv_mrg_cfg('clangd'),
    lua_ls      = M.tbl_srv_mrg_cfg('lua_ls'),
    neocmake    = M.tbl_srv_mrg_cfg('neocmake'),
    pyright     = M.tbl_srv_mrg_cfg('pyright'),
    ts_ls       = M.tbl_srv_mrg_cfg('ts_ls'),
  }
end

return M
