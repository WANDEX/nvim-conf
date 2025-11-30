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

  { -- STATUS BAR
    'rebelot/heirline.nvim',
    lazy = false, -- load during startup
    priority = 2, -- load after all other plugins (colorscheme)
    opts = function(_, opts)
      local stat = require('user.stat.nerv')
      opts.statusline = stat.statusline()
      opts.colors     = stat.setup_colors()
      -- re-evaluate on ColorScheme events (upd statusline colors on colorscheme change)
      vim.api.nvim_create_augroup('Heirline', { clear = true })
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          require('heirline.utils').on_colorscheme(
            require('user.stat.nerv').setup_colors()
          )
        end,
        group = 'Heirline',
      })
      return opts
    end,
    dependencies = {
      { 'kyazdani42/nvim-web-devicons' }, -- icons and their standard colors
    },
  },

}
