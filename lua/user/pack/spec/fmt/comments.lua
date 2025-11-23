-- AUTHOR: 'WANDEX/nvim-conf'
-- plugins related to comments
--
-- XXX: not sure:
-- 'Djancyp/better-comments.nvim' -- hi: TODO, FIXME, XXX, and any custom pattern.
-- 'folke/todo-comments.nvim' -- ^ same idea, but much more features
-- 'numToStr/Comment.nvim'


return {
  { 'scrooloose/nerdcommenter', enabled = false }, -- I do not use it's mappings anymore
  {
    'folke/ts-comments.nvim',
    lazy = false,
    opts = {},
    enabled = vim.fn.has('nvim-0.10.0') == 1,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' }, -- treesitter-parsers must be installed!
      -- { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- XXX: not sure that it is needed
    },
  },
}
