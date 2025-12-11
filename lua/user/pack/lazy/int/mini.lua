-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-mini/mini.nvim'

local M = {}

M.spec = {

  --- replaced by mini.nvim
  { 'tpope/vim-surround', enabled = false },
  { 'tpope/vim-repeat',   enabled = false },

  { --- collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    version = '*',
    lazy = false,
    config = function()

      --- Better Around/Inside textobjects
      ---
      --- Examples:
      ---  - va)  - [V]isually select [A]round [)]paren
      ---  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      ---  - ci'  - [C]hange [I]nside [']quote
      --- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-ai.md
      require('mini.ai').setup({
        -- Number of lines within which textobject is searched.
        n_lines = 500,
        --- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          --- Main textobject prefixes
          around = 'a',
          inside = 'i',
          --- Next/last variants
          --- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
          --- Map LSP selection manually to use it (see `:h MiniAi.config`)
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',
          --- Move cursor to corresponding edge of `a` textobject
          goto_left  = 'g[',
          goto_right = 'g]',
        },
        --- How to search for object (first inside current line, then inside
        --- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        --- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = 'cover_or_next',
      })

      --- Add/delete/replace surroundings (brackets, quotes, etc.)
      ---
      --- - Saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      --- - Sd'   - [S]urround [D]elete [']quotes
      --- - Sr)'  - [S]urround [R]eplace [)] [']
      --- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md
      require('mini.surround').setup({
        --- Number of lines within which surrounding is searched.
        n_lines = 20,
        --- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          add       = 'Sa', -- Add surrounding in Normal and Visual modes
          delete    = 'Sd', -- Delete surrounding
          find      = 'Sf', -- Find surrounding (to the right)
          find_left = 'SF', -- Find surrounding (to the left)
          highlight = 'Sh', -- Highlight surrounding
          replace   = 'Sr', -- Replace surrounding
          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
        --- How to search for surrounding (first inside current line, then inside
        --- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        --- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
        --- see `:h MiniSurround.config`.
        search_method = 'cover_or_next',
        --- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 2000,
      })

      --- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-hipatterns.md
      require('mini.hipatterns').setup({
        highlighters = {
          --- Highlight standalone 'FIXME', 'HACK', 'NOTE', 'TODO', 'XXX'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          xxx   = { pattern = '%f[%w]()XXX()%f[%W]',   group = 'DRED'  },
          --- Highlight hex color strings (`#rrggbb`) using that color
          --- NOTE: 'norcalli/nvim-colorizer.lua' currently used for this purpose!
          -- hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

    end,
  },

}

return M.spec
