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

  {
    'iamcco/markdown-preview.nvim', ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    -- build = function() vim.fn["mkdp#util#install"]() end,
    build = ':call mkdp#util#install()' -- else run manually :Lazy build markdown-preview.nvim
  },

  { -- new text objects | more info: 'https://github.com/kana/vim-textobj-user/wiki'
    'kana/vim-textobj-user', lazy = false, -- CORE plugin
    enabled = false, -- XXX
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
  { 'justinmk/vim-sneak', -- replace f/F t/T with one-character Sneak
    lazy = false,
    keys = { -- not map in Select mode (to not break snippets expansion)
      { mode = { 'n', 'x', 'o' }, 'f', '<Plug>Sneak_f', },
      { mode = { 'n', 'x', 'o' }, 'F', '<Plug>Sneak_F', },
      { mode = { 'n', 'x', 'o' }, 't', '<Plug>Sneak_t', },
      { mode = { 'n', 'x', 'o' }, 'T', '<Plug>Sneak_T', },
    },
  },
  { 'christoomey/vim-sort-motion' },
  { 'christoomey/vim-titlecase' },
  { 'tpope/vim-surround', enabled = false }, -- XXX
  { 'tpope/vim-repeat' },

  -- folding
  -- FIXME: pin -> to not try updating it. Till fix arrive (kalekundert/vim-coiled-snake/issues/33)
  { 'kalekundert/vim-coiled-snake', pin=true, ft='python', }, -- python code folding
  { 'Konfekt/FastFold' }, -- remove default: 'zj', 'zk' movements -> breaks vim-sneak dz.. yz.. mappings!

  -- other
  { 'airblade/vim-rooter' }, -- auto cwd to the project root
  { 'voldikss/vim-translator' },
  { 'mg979/vim-xtabline',
    config = function()
      vim.cmd('silent! XTabMode buffers') -- fix: set default mode to buffers
    end,
  },
  { 'preservim/tagbar' },
  { 'justinmk/vim-gtfo', enabled = false }, -- XXX
  { 'farmergreg/vim-lastplace' },
  { 'rmagatti/alternate-toggler' }, -- toggle alternate values (0/1, true/false, etc.)

  { -- wipe/delete buffers without closing windows or messing up layout.
    'moll/vim-bbye',
    lazy = false,
    keys = {
      {
        mode = 'n', '<Leader>q', '<cmd>Bdelete<CR>',  { silent = true,
        desc = 'Bdelete'  },
      },
      {
        mode = 'n', '<Leader>w', '<cmd>Bwipeout<CR>', { silent = true,
        desc = 'Bwipeout' },
      },
    },
  },

  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true, enabled = false }, -- XXX

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

  {
    'folke/which-key.nvim',
    version = '*',
    lazy = false,
    opts = require('user.pack.conf.which-key').opts,
  },

  {
    'smoka7/multicursors.nvim',
    -- commit = '72225ea9e4443c3f4b9df91d0193e07c4ee8d382',
    dependencies = {{
      'nvimtools/hydra.nvim',
      -- commit = '8c4a9f621ec7cdc30411a1f3b6d5eebb12b469dc',
    }},
    -- version = '*',
    event = 'VeryLazy',
    opts = function(_, opts)
      opts = require('user.pack.multicursors.config')
      return opts
    end,
    cmd  = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' }, '<C-j>', '<cmd>MCstart<cr>',
        desc = 'MC Create a selection for selected text or word under the cursor',
      },
      {
        mode = { 'v', 'n' }, '<C-n>', '<cmd>MCunderCursor<cr>',
        desc = 'MC Select the char under the cursor and start listening for the actions.',
      },
    },
  },

  { -- STATUS BAR
    'rebelot/heirline.nvim',
    lazy = false, -- load during startup
    priority = 1, -- load after all other plugins (colorscheme)
    opts = function(_, opts)
      local stat = require('user.stat.nerv')
      opts.statusline = stat.statusline()
      opts.colors     = stat.setup_colors()
      -- re-evaluate on ColorScheme events (upd statusline colors on colorscheme change)
      vim.api.nvim_create_augroup('Heirline', { clear = true })
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          require('heirline.utils').on_colorscheme(opts.colors)
        end,
        group = 'Heirline',
      })
      return opts
    end,
  },

}
