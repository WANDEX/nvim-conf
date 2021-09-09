-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local use = require('packer').use
require('packer').startup({function()
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}

  use { -- icons
    -- 'ryanoasis/vim-devicons', -- vim script
    'kyazdani42/nvim-web-devicons', -- lua
  }

  -- visual
  use {'junegunn/limelight.vim', cmd='Limelight'}

  use { -- format
    -- 'brooth/far.vim' -- " didn't tried yet
    'ntpeters/vim-better-whitespace',
    'editorconfig/editorconfig-vim',
    'sbdchd/neoformat',
    'scrooloose/nerdcommenter',
    {'iamcco/markdown-preview.nvim', run='cd app && yarn install', ft='markdown'},
  }

  use { -- new text objects | more info: 'https://github.com/kana/vim-textobj-user/wiki'
    'kana/vim-textobj-user',    -- CORE (wont be installed with 'requires = ...')
    'kana/vim-textobj-indent',  -- ai/ii aI/iI
    'kana/vim-textobj-line',    -- al/il
    'kana/vim-textobj-entire',  -- ae/ie
    'glts/vim-textobj-comment', -- ac/ic aC
    'kana/vim-textobj-diff',    -- adh/idh
    {'bps/vim-textobj-python', ft='python'}, -- af/if ac/ic [pf/]pf [pc/]pc
  }

  use { -- motion
    'justinmk/vim-sneak',
    'christoomey/vim-sort-motion',
    'christoomey/vim-titlecase',
    'tpope/vim-surround',
    'tpope/vim-repeat',
  }

  use { -- syntax
    {'kovetskiy/sxhkd-vim', ft='sxhkd'},
    -- (https://github.com/wbthomason/packer.nvim/issues/464) add when it will be fixed
    {'numirias/semshi', run=':UpdateRemotePlugins'}, -- TODO ft='python'
  }

  -- folding
  -- use {'kalekundert/vim-coiled-snake', ft='python'} -- python code folding
  use 'Konfekt/FastFold'

  use { -- other
    'airblade/vim-rooter', -- auto cwd to the project root
    'voldikss/vim-translator',
    'Valloric/ListToggle',
    'mg979/vim-visual-multi',
    'preservim/tagbar',
    'justinmk/vim-gtfo',
    'farmergreg/vim-lastplace',
  }

  use {'rmagatti/alternate-toggler', cmd='ToggleAlternate'} -- toggle alternate "boolean" values FIXME

  -- not sure (candidates for deletion):
  -- use 'metakirby5/codi.vim'
  -- use 'dbeniamine/cheat.sh-vim'

  -- at the end
  use 'neomake/neomake'

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
}})

