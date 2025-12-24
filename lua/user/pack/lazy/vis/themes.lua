-- AUTHOR: 'WANDEX/nvim-conf'
-- themes configuration, lazy-load & etc.

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,            -- from the github README
    opts = {
      transparent_background = true,
    },
  },

  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        transparent = true,     -- disable setting background
      },
    },
  },

  {
    'sainnhe/sonokai',
    lazy = true,
    priority = 1000,
    init = function()
      vim.g.sonokai_transparent_background = 2
    end,
  },

  { 'tanvirtin/monokai.nvim',   lazy = true, priority = 1000, },

  { 'nekonako/xresources-nvim', lazy = true, priority = 1000, },

  { -- STATUSLINE
    'rebelot/heirline.nvim',
    lazy = false, -- load during startup
    priority = 2, -- load after all other plugins (colorscheme)
    opts = function(_, opts)
      vim.cmd.colorscheme('monokai_pro') --- set default colorscheme at startup
      local stat = require('user.stat.nerv') --- set statusline
      opts.statusline = stat.statusline()
      opts.colors     = stat.sc
      --- re-evaluate on ColorScheme events (upd statusline colors on colorscheme change)
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('hi_heirline', { clear = true }),
        callback = function()
          require('heirline.utils').on_colorscheme(
            require('user.stat.static').setup_colors()
          )
        end,
      })
      return opts
    end,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' }, -- icons and their colors
    },
  },

}
