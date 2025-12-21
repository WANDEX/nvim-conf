-- AUTHOR: 'WANDEX/nvim-conf'
-- configuration for built-in neovim diagnostic.
-- NOTE: source in which DiagnosticSign* highlights are defined
-- vim.api.nvim_command('source ~/.config/nvim/plugin/hi.vim')

vim.diagnostic.config({
  underline = true,
  virtual_text = {
    current_line = true,
    virt_text_hide = true,
    virt_text_pos = 'eol_right_align',
    severity = { min = 'HINT', max = 'ERROR' },
    source = false,
    spacing = 0,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = vim.g.NF and ' ' or 'E',
      [vim.diagnostic.severity.WARN]  = vim.g.NF and ' ' or 'W',
      [vim.diagnostic.severity.INFO]  = vim.g.NF and ' ' or 'I',
      [vim.diagnostic.severity.HINT]  = vim.g.NF and ' ' or 'H',
    },
  },
  float = { -- options for floating windows
    header = "",
    border = 'none',
    source = true,
  }, -- general purpose
  severity_sort = true,
  update_in_insert = false,
})

vim.keymap.set('n', '<leader>LDD', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Diag toggle' })

vim.keymap.set('n', '<leader>LDU', function()
  local opts = vim.diagnostic.config() ---@class vim.diagnostic.Opts
  opts.underline = not opts.underline
  vim.diagnostic.config(opts)
end, { desc = 'Diag Underline toggle' })

vim.keymap.set('n', '<leader>LDL', function()
  local opts = vim.diagnostic.config() ---@class vim.diagnostic.Opts
  opts.virtual_lines = not opts.virtual_lines
  vim.diagnostic.config(opts)
end, { desc = 'Diag Lines virtual toggle' })

-- toggle showing of the virtual_text - current_line / all lines.
vim.keymap.set('n', '<leader>LDT', function()
  local opts = vim.diagnostic.config() ---@class vim.diagnostic.Opts
  opts.virtual_text.current_line = not opts.virtual_text.current_line
  vim.diagnostic.config(opts)
end, { desc = 'Diag Text virtual toggle' })
