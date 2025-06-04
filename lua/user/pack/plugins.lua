-- main list of the plugins

return {
  { -- plugin manager
    'folke/lazy.nvim', version = '*',
    opts = {
      git = {
        log = { '-8' }, -- show last 8 commits
      },
      checker = { enabled = false },
      diff = { -- diff command <d> can be one of:
        -- * git: will run git diff and open a buffer with filetype git
        -- * diffview.nvim: will open Diffview to show the diff
        cmd = 'git',
      },
    },
  },

  -- visual
  { 'kyazdani42/nvim-web-devicons' }, -- icons
  { 'junegunn/limelight.vim', cmd='Limelight' }, -- reading

  -- git
  { 'tpope/vim-fugitive' },
  { 'jreybert/vimagit' }, -- till neogit is not fixed
  { 'lewis6991/gitsigns.nvim', dependencies = {'nvim-lua/plenary.nvim'}, },
  { 'NeogitOrg/neogit', dependencies = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
    -- enabled = false, -- FIXME throws error if enabled & setup{}
  },

  -- format
  { 'sbdchd/neoformat' },
  { 'scrooloose/nerdcommenter' },

  { -- trim_trailing_whitespace respecting .editorconfig rules.
    'mcauley-penney/tidy.nvim', lazy = false, config = true,
    -- commit = '31f95306ffd408ed4bb5185e8ec3bab9516ad34c', -- 2025 April 14
  },

  -- syntax
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },
  { 'justinmk/vim-syntax-extra' },
  { 'kovetskiy/sxhkd-vim', ft='sxhkd', },
  {
    'numirias/semshi', ft = 'python', build = ':UpdateRemotePlugins',
    -- FIXME: :UpdateRemotePlugins not runs automatically! call manually!
    enabled = false, -- XXX maybe there is a better alternatives?
  },
  {
    'norcalli/nvim-colorizer.lua',
    opts = {    -- exclusion only makes sense if '*' is specified!
      '*';      -- highlight all files, but customize some others.
      '!html';  -- exclude from highlighting.
    },
    config = function()
      vim.opt.termguicolors = true -- fix: &termguicolors must be set
    end,
  },

  {
    'iamcco/markdown-preview.nvim', ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    -- build = function() vim.fn["mkdp#util#install"]() end,
    build = ':call mkdp#util#install()' -- else run manually :Lazy build markdown-preview.nvim
  },

  { -- new text objects | more info: 'https://github.com/kana/vim-textobj-user/wiki'
    'kana/vim-textobj-user', lazy = false, -- CORE plugin
    dependencies = {
      { 'glts/vim-textobj-comment'  }, -- ac/ic aC
      { 'kana/vim-textobj-diff'     }, -- adh/idh
      { 'kana/vim-textobj-entire'   }, -- ae/ie
      { 'kana/vim-textobj-indent'   }, -- ai/ii aI/iI
      { 'kana/vim-textobj-line'     }, -- al/il
      { 'bps/vim-textobj-python', ft='python' }, -- af/if ac/ic [pf/]pf [pc/]pc
    },
  },

  -- motion
  { 'justinmk/vim-sneak' },
  { 'christoomey/vim-sort-motion' },
  { 'christoomey/vim-titlecase' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },

  -- folding
  -- FIXME: pin -> to not try updating it. Till fix arrive (kalekundert/vim-coiled-snake/issues/33)
  { 'kalekundert/vim-coiled-snake', pin=true, ft='python', }, -- python code folding
  { 'Konfekt/FastFold' }, -- remove default: 'zj', 'zk' movements -> breaks vim-sneak dz.. yz.. mappings!

  -- other
  { 'airblade/vim-rooter' }, -- auto cwd to the project root
  { 'voldikss/vim-translator' },
  { 'mg979/vim-visual-multi' },
  { 'mg979/vim-xtabline',
    config = function()
      vim.cmd('silent! XTabMode buffers') -- fix: set default mode to buffers
    end,
  },
  { 'preservim/tagbar' },
  { 'justinmk/vim-gtfo' },
  { 'farmergreg/vim-lastplace' },
  { 'rmagatti/alternate-toggler' }, -- toggle alternate values (0/1, true/false, etc.)
  { 'moll/vim-bbye' }, -- wipe/delete buffers without closing windows or messing up layout.
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true, },

  -- telescope
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'TC72/telescope-tele-tabby.nvim' },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  { 'rmagatti/auto-session', lazy = false, enabled = true },

  { 'nvim-tree/nvim-tree.lua', version = '*', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons', } },

  -- completion
  { 'neovim/nvim-lspconfig' }, -- Collection of configurations for built-in LSP client

  {
    'glacambre/firenvim',
    -- build = function() vim.fn['firenvim#install'](0) end,
    build = ':call firenvim#install(0)', -- else run manually
  },

  -- at the end
  { 'neomake/neomake' },
  { 'folke/which-key.nvim' },

  { -- STATUS BAR
    'rebelot/heirline.nvim',
    lazy = false, -- load during startup
    priority = 1, -- load after all other plugins (colorscheme)
    opts = function(_, opts)
      opts.statusline = require('user.stat.nerv')
    end,
  },

}
