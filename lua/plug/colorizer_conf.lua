-- configuration for the color related plugins

vim.o.termguicolors = true -- wont work/throws error without: set termguicolors

-- use 'kabbamine/vcoolor.vim' - color selector/picker (config in vColor.vim)

local use = require('packer').use
local plug = '!hexokinase' -- variable for swapping colorizers
if ( plug == 'hexokinase' ) then
  use {
    'RRethy/vim-hexokinase', -- FIXME dunno why, but does not work!
    run='make hexokinase',
  }
else
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup{
        -- Exclusion Only makes sense if '*' is specified!
        '*'; -- Highlight all files, but customize some others.
        '!html'; -- Exclude from highlighting.
      }
    end,
  }
end

