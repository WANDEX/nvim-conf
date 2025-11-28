-- AUTHOR: 'WANDEX/nvim-conf'
-- git related plugins

return {

  { 'tpope/vim-fugitive' },

  {
    'NeogitOrg/neogit',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'sindrets/diffview.nvim' }
    }
  },

}
