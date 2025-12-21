-- AUTHOR: 'WANDEX/nvim-conf'
-- config spec 'neovim/nvim-lspconfig'
--
-- look into ref with additional comments:
-- https://github.com/nvim-lua/kickstart.nvim

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

--- @param event any (string|array) Event(s) that will trigger the handler (`callback` or `command`).
local function hi(event)
  local lsp_b = vim.lsp.buf

  --- The following two autocommands are used to highlight references of the
  --- word under your cursor when your cursor rests there for a little while.
  ---    See `:help CursorHold` for information about when this is executed
  ---
  --- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and M.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then

    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = lsp_b.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = lsp_b.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event2)
        lsp_b.clear_references()
        vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
      end,
    })
  end

  --- The following code creates a keymap to toggle inlay hints in your
  --- code, if the language server you are using supports them
  ---
  --- This may be unwanted, since they displace some of your code
  if client and M.client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    M.map('<leader>th', function()
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

      --- Rename the variable under your cursor.
      ---  Most Language Servers support renaming across files, etc.
      l_map('grn', lsp_b.rename, '[R]e[n]ame')

      --- Execute a code action, usually your cursor needs to be on top of an error
      --- or a suggestion from your LSP for this to activate.
      l_map('gra', lsp_b.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      --- Find references for the word under your cursor.
      l_map('grr', tel_b.lsp_references, '[G]oto [R]eferences')

      --- Jump to the implementation of the word under your cursor.
      ---  Useful when your language has ways of declaring types without an actual implementation.
      l_map('gri', tel_b.lsp_implementations, '[G]oto [I]mplementation')

      --- Jump to the definition of the word under your cursor.
      ---  This is where a variable was first declared, or where a function is defined, etc.
      ---  To jump back, press <C-t>.
      l_map('grd', tel_b.lsp_definitions, '[G]oto [D]efinition')

      --- WARN: This is not Goto Definition, this is Goto Declaration.
      ---  For example, in C this would take you to the header.
      l_map('grD', lsp_b.declaration, '[G]oto [D]eclaration')

      --- Fuzzy find all the symbols in your current document.
      ---  Symbols are things like variables, functions, types, etc.
      l_map('gO', tel_b.lsp_document_symbols, 'Open Document Symbols')

      --- Fuzzy find all the symbols in your current workspace.
      ---  Similar to document symbols, except searches over your entire project.
      l_map('gW', tel_b.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

      --- Jump to the type of the word under your cursor.
      ---  Useful when you're not sure what type a variable is and you want to see
      ---  the definition of its *type*, not where it was *defined*.
      l_map('grt', tel_b.lsp_type_definitions, '[G]oto [T]ype Definition')

      hi(event) -- XXX
    end,
  })
end

return M
