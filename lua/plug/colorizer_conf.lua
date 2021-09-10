-- configuration for the color plugin

-- use 'kabbamine/vcoolor.vim' - color selector/picker (config in vColor.vim)

local use = require('packer').use
-- use {
  -- both !Throws error without: set termguicolors
  -- 'norcalli/nvim-colorizer.lua',
  -- or this
  -- {'RRethy/vim-hexokinase', run='make hexokinase'},
-- }

-- Exclude some filetypes from highlighting by using `!`
-- require('colorizer').setup{
--   '*'; -- Highlight all files, but customize some others.
--   '!html'; -- Exclude vim from highlighting.
--   -- Exclusion Only makes sense if '*' is specified!
-- }
