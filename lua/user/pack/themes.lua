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
    opts = function(_, _)
      vim.cmd('let g:sonokai_transparent_background = 2')
    end,
  },

  { 'tanvirtin/monokai.nvim',   lazy = true, priority = 1000, },

  { 'nekonako/xresources-nvim', lazy = true, priority = 1000, },
}
