-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'saghen/blink.indent'

return {
  'saghen/blink.indent',
  lazy = false,
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    blocked = {
      buftypes  = { -- :se bt
        include_defaults = true,
        'nofile',
        'prompt',
        'quickfix',
        'terminal',
      },
      filetypes = { -- :se ft
        include_defaults = true,
        '',
        'TelescopePrompt',
        'TelescopeResults',
        'checkhealth',
        'dashboard',
        'gitcommit',
        'help',
        'lspinfo',
        'man',
        'packer',
      },
    },
    static = {
      enabled = true,
      char = '▎',
      whitespace_char = nil,
      priority = 1,
      highlights = { 'IndentGuidesOdd' },
    },
    scope = {
      enabled = true,
      priority = 1000,
      highlights = { 'IndentGuidesEven', },
      underline = {
        enabled = false,
      },
    },
  },
  keys = {
    { --- also via vim.g.indent_guide or (per-buffer) vim.b[bufnr].indent_guide = false
      mode = 'n', '<localleader>sl', function()
        local indent = require('blink.indent')
        local ff = vim.bo.fileformat --- :h fileformat
        local eol = '' --      
        if ff == 'unix' then
          eol = '' -- 'U' --- <NL>
        elseif ff == 'mac' then
          eol = '' -- 'M' --- <CR>
        elseif ff == 'dos' then
          eol = '' -- 'D' --- <CR><NL>
        else
          vim.notify("vim.bo.fileformat unexpected result!", vim.log.levels.ERROR)
        end
        if indent.is_enabled() then
          vim.opt.listchars:append({ eol = eol })
          indent.enable(false)
        else
          vim.opt.listchars:append({ eol = ' ' })
          indent.enable(true)
        end
      end, desc = 'show listchars/toggle indent guides'
    },
  },
}
