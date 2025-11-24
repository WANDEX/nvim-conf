-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'Pocco81/true-zen.nvim'

return {
  -- 'Pocco81/true-zen.nvim', -- original upstream (but no issue fixes)
  -- 'iaquobe/true-zen.nvim', commit = '26f26c6b7d92f24605ecf1896434571fd42c0ff5', -- fix error: toggle
  -- 'ilan-schemoul/true-zen.nvim', commit = '3c8f2697572c643d2cf5c208d8fa2e7de0c680c3', -- fix error: toggle
  'jonathan-go/true-zen.nvim', commit = '3958221b9eab7a1c93e1c159fa0bc334f3525187', -- fix error: toggle
  lazy = false,
  priority = 1, -- load after everything
  opts = {
    modes = {
      ataraxis = {
        -- minimum_writing_area = { -- minimum size of main window
        --   width  = 80,
        --   height = 150,
        -- },
        quit_untoggles = false, -- type :q or :qa to quit Ataraxis mode
        -- padding = { -- padding windows
        --   left   = 60,
        --   right  = 30,
        --   top    = 0,
        --   bottom = 0,
        -- },
      },
    },
  },
  config = function(_, opts)
    require('true-zen').setup(opts)
  end,
  cmd  = { 'TZMinimalist', 'TZFocus', 'TZAtaraxis' },
  keys = {
    { '<localleader>z',  '', desc = 'zen', }, -- group
    { '<localleader>zc', function() -- '<cmd>TZAtaraxis<CR>'
      -- fix: turn off TZMinimalist first, otherwise tabbar and statusbar not recoverable
      if require('true-zen.minimalist').running then
        require('true-zen.minimalist').toggle()
      end
      require('true-zen.ataraxis').toggle()
    end, desc = 'center' },
    { '<localleader>zm', function() -- '<cmd>TZMinimalist<CR>'
      -- fix: turn off TZAtaraxis first
      if require('true-zen.ataraxis').running then
        require('true-zen.ataraxis').toggle()
      end
      require('true-zen.minimalist').toggle()
    end, desc = 'minimalist' },
    { '<localleader>zf', '<cmd>TZFocus<CR>', desc = 'focus' },
  },
}
