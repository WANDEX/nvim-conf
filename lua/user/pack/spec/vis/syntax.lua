-- AUTHOR: 'WANDEX/nvim-conf'
-- plugins related to: syntax, highlight, minor visual aspects

return {

  -- visual
  -- { 'kyazdani42/nvim-web-devicons' }, -- icons
  { 'junegunn/limelight.vim', cmd='Limelight' }, -- reading

  -- syntax
  { 'justinmk/vim-syntax-extra' },
  { 'kovetskiy/sxhkd-vim', ft='sxhkd', },
  {
    'numirias/semshi', ft = 'python', build = ':UpdateRemotePlugins',
    -- FIXME: :UpdateRemotePlugins not runs automatically! call manually!
    enabled = false, -- XXX maybe there is a better alternatives?
  },

  { 'fei6409/log-highlight.nvim', opts = {} },

  {
    'norcalli/nvim-colorizer.lua',
    lazy = false,
    config = function()
      vim.opt.termguicolors = true -- fix: &termguicolors must be set
      require('colorizer').setup({
        -- exclusion only makes sense if '*' is specified!
        '*';      -- highlight all files, but customize some others.
        '!html';  -- exclude from highlighting.
      })
    end,
    keys = {
      {
        mode = { 'n' }, '<localleader>cC', '<cmd>ColorizerToggle<CR>',
        desc = 'Colorizer toggle color highlight', silent = true
      },
    },
  },

}
