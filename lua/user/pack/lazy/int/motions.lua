-- AUTHOR: 'WANDEX/nvim-conf'
-- spec motions related plugins

return {

  -- folding
  -- FIXME: pin -> to not try updating it. Till fix arrive (kalekundert/vim-coiled-snake/issues/33)
  { 'kalekundert/vim-coiled-snake', enabled = false, pin=true, ft='python', }, -- python code folding
  { 'Konfekt/FastFold', enabled = false }, -- remove default: 'zj', 'zk' movements -> breaks vim-sneak dz.. yz.. mappings!

  { 'christoomey/vim-sort-motion', enabled = false },
  { 'christoomey/vim-titlecase', enabled = false },

  -- TODO: replace with mini.nvim
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },

  { 'glts/vim-radical', dependencies = { 'glts/vim-magnum' } }, -- gA, crd, crx, cro, crb

}
