-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'stevearc/conform.nvim'
--
-- MEMO: install formatters via :Mason 'mason-org/mason.nvim'

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd   = { 'ConformInfo' },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = { -- Define your formatters
      bash        = { 'shfmt' },
      c           = { 'clang-format' },
      cpp         = { 'clang-format' },
      javascript  = { 'prettierd', 'prettier', stop_after_first = true },
      lua         = { 'stylua' },
      mksh        = { 'shfmt' },
      python      = { 'ruff_organize_imports', 'ruff_format' },
      sh          = { 'shfmt' },
    },
    default_format_opts = { -- Set default options
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr) -- enable/disable with a global or buffer-local variable
      if not vim.g.autoformat and not vim.b[bufnr].autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    -- formatters = { -- Customize formatters
    --   shfmt = {
    --     append_args = { "-i", "2" },
    --   },
    -- },
    notify_no_formatters = true, -- Conform will notify you when no formatters are available for the buffer
  },
  init = function()
    vim.g.autoformat, vim.b.autoformat = false, false -- disable autoformat by default
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    require('conform').setup(opts)
  end,
  keys = {
    {
      mode = {'n', ''}, '<leader>af', function()
        require('conform').format({ async = true })
      end, desc = 'format one-shot buf',
    },
    {
      mode = 'n', '<leader>aF', function()
        vim.g.autoformat = not vim.g.autoformat
        vim.notify(string.format('vim.g.autoformat = %s', vim.g.autoformat),
          vim.log.levels.INFO, {title = 'WNDX'}
        )
      end, desc = 'Format toggle autoformat',
    },
  },
}

