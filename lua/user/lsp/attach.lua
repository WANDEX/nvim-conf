-- AUTHOR: 'WANDEX/nvim-conf'
-- config spec 'neovim/nvim-lspconfig'
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim
--
-- MEMO :h lsp-defaults, :h lsp-defaults-disable
-- global defaults: { grr, gra, grn, gri, grt, gO, i_CTRL-S }

local M = {}

--- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
---@param client vim.lsp.Client
---@param method vim.lsp.protocol.Method
---@param bufnr? integer some lsp support methods only in specific files
---@return boolean
function M.client_supports_method(client, method, bufnr)
  if vim.fn.has 'nvim-0.11' == 1 then
    return client:supports_method(method, bufnr)
  else
    ---@diagnostic disable-next-line: param-type-mismatch
    return client.supports_method(method, { bufnr = bufnr })
  end
end

--- create buffer local mapping for the lsp attached buffer.
--- wrapper: vim.keymap.set() - Defines a |mapping| of |keycodes| to a function or keycodes.
---@param lhs   string          Left-hand side  |{lhs}| of the mapping.
---@param rhs   string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
---@param mode? string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
function M.map(lhs, rhs, opts, mode)
  mode = mode or 'n'
  opts = opts or {}
  local def_opts = {
    buffer = opts.buffer or 0, silent = true, nowait = true, desc = '[LSP]'
  } -- default opts if not explicitly provided
  local mrg_opts = vim.tbl_extend('force', def_opts, opts)
  mrg_opts.desc = '[LSP] ' .. mrg_opts.desc
  vim.keymap.set(mode, lhs, rhs, mrg_opts)
end

--- highlight references of the word under cursor when cursor rests there for updatetime.
--- @see vim.opt.updatetime = 500 -- |CursorHold| autocmd event (4000 ms default)
--- @param event any (string|array) Event(s) that will trigger the handler (`callback` or `command`).
local function hi_cursor_refs(event)
  local lsp_b = vim.lsp.buf
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  local doc_hi = vim.lsp.protocol.Methods.textDocument_documentHighlight
  if client and M.client_supports_method(client, doc_hi, event.buf) then
    local highlight_augroup = vim.api.nvim_create_augroup('hi_cursor_refs', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = lsp_b.document_highlight,
    }) --- :h CursorHold - info when it is executed
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = lsp_b.clear_references,
    }) --- clear highlights when CursorMoved
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event2)
        lsp_b.clear_references()
        vim.api.nvim_clear_autocmds({ group = 'hi_cursor_refs', buffer = event2.buf })
      end,
    })
  end

  if client and M.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    M.map('<leader>th', function() --- toggle inlay hints, if LSP supports them
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, { desc = '[T]oggle Inlay [H]ints', buffer = event.buf })
  end
end

--- This function installs autocmd's that are run when an LSP attaches to a particular buffer.
---   That is to say, every time a new file is opened that is associated with an lsp
---   (for example, opening `main.rs` is associated with `rust_analyzer`) this
---   function will be executed to configure the current buffer.
--- https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/init.lua#L525
function M.lsp_attach()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)

      ---@param lhs   string          Left-hand side  |{lhs}| of the mapping.
      ---@param rhs   string|function Right-hand side |{rhs}| of the mapping, can be a Lua function.
      ---@param desc  string          Left-hand side  |{opts.desc}| of the mapping.
      ---@param mode? string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
      local l_map = function(lhs, rhs, desc, mode)
        M.map(lhs, rhs, { buffer = event.buf, desc = desc }, mode)
      end

      local lsp_b = vim.lsp.buf
      local tel_b = require('telescope.builtin')
      local use_tel = true

      local ok_live_rename, live_rename = pcall(require, 'live-rename')
      if    ok_live_rename then
        l_map('grn', function() live_rename.rename({ cursorpos = -1 }) end, '[R]e[n]ame live')
      else
        l_map('grn', lsp_b.rename, '[R]e[n]ame')
      end
      --- Execute a code action, usually your cursor needs to be on top of an error
      --- or a suggestion from your LSP for this to activate.
      l_map('gra', lsp_b.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      if use_tel then
        l_map('grr', tel_b.lsp_references,  '[G]oto [R]eferences')
      else
        l_map('grr', lsp_b.references,      '[G]oto [R]eferences')
      end

      --- Jump to the implementation of the word under your cursor.
      ---  Useful when your language has ways of declaring types without an actual implementation.
      if use_tel then
        l_map('gri', tel_b.lsp_implementations, '[G]oto [I]mplementation')
      else
        l_map('gri', lsp_b.implementation,      '[G]oto [I]mplementation')
      end

      if use_tel then
        l_map('grt', tel_b.lsp_type_definitions,  '[G]oto [T]ype Definition')
      else
        l_map('grt', lsp_b.type_definition,       '[G]oto [T]ype Definition')
      end

      if use_tel then
        l_map('grd', tel_b.lsp_definitions, '[G]oto [D]efinition')
      else
        l_map('grd', lsp_b.definition,      '[G]oto [D]efinition')
      end
      l_map('grD', lsp_b.declaration,       '[G]oto [D]eclaration')

      l_map('gO', tel_b.lsp_document_symbols,           'Open Document Symbols')
      l_map('gW', tel_b.lsp_dynamic_workspace_symbols,  'Open Workspace Symbols')

      l_map('<leader>lC', vim.lsp.codelens.refresh,     'Codelens refresh & display')
      l_map('<leader>lc', vim.lsp.codelens.run,         'codelens run', { 'n', 'v' })
      l_map('<leader>le', vim.diagnostic.open_float,    'diag enter/show')
      l_map('<leader>lh', lsp_b.hover,                  'hover') -- always works unlike signature_help?
      l_map('<leader>ll', vim.diagnostic.setloclist,    'list diag')

      ---XXX: signature help - always works worse that hover?
      -- l_map('<c-k>',      lsp_b.signature_help, 'signature help', { 'i' }) -- <c-s> default
      -- l_map('<leader>ls', lsp_b.signature_help, 'signature help', { 'n' })
      -- l_map('gK',         lsp_b.signature_help, 'signature help', { 'n' })

      hi_cursor_refs(event)
    end,
  })
end

return M
