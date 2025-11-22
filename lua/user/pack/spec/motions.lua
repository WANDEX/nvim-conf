-- AUTHOR: 'WANDEX/nvim-conf'
-- spec motions related plugins

return {

  {
    'justinmk/vim-sneak', -- replace f/F t/T with one-character Sneak
    lazy = false,
    enabled = false, -- XXX: replaced by flash.nvim
    keys = { -- not map in Select mode (to not break snippets expansion)
      { mode = { 'n', 'x', 'o' }, 'f', '<Plug>Sneak_f', },
      { mode = { 'n', 'x', 'o' }, 'F', '<Plug>Sneak_F', },
      { mode = { 'n', 'x', 'o' }, 't', '<Plug>Sneak_t', },
      { mode = { 'n', 'x', 'o' }, 'T', '<Plug>Sneak_T', },
    },
  },

  -- folding
  -- FIXME: pin -> to not try updating it. Till fix arrive (kalekundert/vim-coiled-snake/issues/33)
  { 'kalekundert/vim-coiled-snake', enabled = false, pin=true, ft='python', }, -- python code folding
  { 'Konfekt/FastFold', enabled = false }, -- remove default: 'zj', 'zk' movements -> breaks vim-sneak dz.. yz.. mappings!

  { 'christoomey/vim-sort-motion', enabled = false },
  { 'christoomey/vim-titlecase', enabled = false },

  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'glts/vim-radical', dependencies = { 'glts/vim-magnum' } }, -- gA, crd, crx, cro, crb

  {
    'folke/flash.nvim',
    lazy = false,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { 's', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
      -- Simulate nvim-treesitter incremental selection
      { '<c-space>', mode = { 'n', 'o', 'x' },
        function()
          require('flash').treesitter({
            actions = {
              ['<c-space>'] = 'next',
              ['<BS>'] = 'prev'
            }
          })
        end, desc = 'Treesitter Incremental Selection' },
    },
  },

}
