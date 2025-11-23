-- AUTHOR: 'WANDEX/nvim-conf'
-- main list of the plugins

return {
  { 'folke/lazy.nvim', version = '*' }, -- plugin manager

  -- visual
  { 'kyazdani42/nvim-web-devicons' }, -- icons
  { 'junegunn/limelight.vim', cmd='Limelight' }, -- reading

  -- git
  { 'tpope/vim-fugitive' },
  { 'jreybert/vimagit' }, -- till neogit is not fixed
  { 'NeogitOrg/neogit', dependencies = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
    -- enabled = false, -- FIXME throws error if enabled & setup{}
  },

  -- syntax
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
  { 'fei6409/log-highlight.nvim', opts = {}, },

  {
    'iamcco/markdown-preview.nvim', ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = ':call mkdp#util#install()', -- else run manually :Lazy build markdown-preview.nvim
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

  -- other
  { 'airblade/vim-rooter' }, -- auto cwd to the project root
  { 'voldikss/vim-translator' },
  { 'mg979/vim-xtabline',
    config = function()
      vim.cmd('silent! XTabMode buffers') -- fix: set default mode to buffers
    end,
  },
  { 'justinmk/vim-gtfo', enabled = false }, -- XXX
  { 'farmergreg/vim-lastplace' },

  { -- toggle alternate values (0/1, true/false, etc.)
    'rmagatti/alternate-toggler',
    lazy = false,
    opts = {
      alternates = {
        ["ON"] = "OFF",
        ["On"] = "Off",
        ["on"] = "off",
      },
    },
    config = true,
  },

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

  -- completion
  { 'neovim/nvim-lspconfig' }, -- Collection of configurations for built-in LSP client

  {
    'glacambre/firenvim',
    version = '*',
    enabled = false,
    build = ':call firenvim#install(0)', -- else run manually
  },

  -- at the end
  { 'neomake/neomake' },

  { -- STATUS BAR
    'rebelot/heirline.nvim',
    lazy = false, -- load during startup
    priority = 2, -- load after all other plugins (colorscheme)
    opts = function(_, opts)
      local stat = require('user.stat.nerv')
      opts.statusline = stat.statusline()
      opts.colors     = stat.setup_colors()
      -- re-evaluate on ColorScheme events (upd statusline colors on colorscheme change)
      vim.api.nvim_create_augroup('Heirline', { clear = true })
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          require('heirline.utils').on_colorscheme(
            require('user.stat.nerv').setup_colors()
          )
        end,
        group = 'Heirline',
      })
      return opts
    end,
  },

}
