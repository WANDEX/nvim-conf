-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-treesitter/nvim-treesitter'
-- spec 'nvim-treesitter/nvim-treesitter-textobjects'
-- 'https://www.lazyvim.org/plugins/treesitter'

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      highlight = {
        enable = true,
      },
    },
    config = true,
  },
  { -- automatically add closing tags for HTML and JSX
    'windwp/nvim-ts-autotag',
    event = "LazyFile",
    opts = {},
  },
}
