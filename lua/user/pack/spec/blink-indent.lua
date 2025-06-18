-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'saghen/blink.indent'

return {
  'saghen/blink.indent',
  lazy = false,
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    -- or disable with `vim.g.indent_guide = false` (global) or `vim.b.indent_guide = false` (per-buffer)
    blocked = {
      buftypes  = { 'nofile', 'terminal', 'quickfix', 'prompt' }, -- :se bt
      filetypes = { -- :se ft
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'gitcommit',
        'TelescopePrompt',
        'TelescopeResults',
        'dashboard',
        '',
      },
    },
    static = {
      enabled = true,
      char = '▎',
      priority = 1,
      highlights = { 'IndentGuidesOdd' }
      -- highlights = { 'IndentGuidesOdd', 'IndentGuidesEven', }
    },
    scope = {
      enabled = true,
      priority = 1024,
      highlights = { 'IndentGuidesEven', }
    },
    underline = {
      enabled = false,
    },
  },
  config = true,
  -- config = function(_, opts)
  --   vim.api.nvim_set_hl(0, "IndentGuidesOdd",  {fg='#282a36', ctermfg=238, nocombine=true})
  --   vim.api.nvim_set_hl(0, "IndentGuidesEven", {fg='#383a46', ctermfg=242, nocombine=true})
  --   require('blink.indent').setup(opts)
  -- end,
}
