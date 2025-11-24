-- AUTHOR: 'WANDEX/nvim-conf'
-- git related plugins

return {

  { 'tpope/vim-fugitive' },

  { 'jreybert/vimagit' }, -- simple: diff, stage, commit msg
  {
    'NeogitOrg/neogit',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'sindrets/diffview.nvim' }
    }
  },

}
