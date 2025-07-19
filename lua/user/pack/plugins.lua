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

  -- format
  { 'sbdchd/neoformat' },
  { 'scrooloose/nerdcommenter' },

  { -- trim_trailing_whitespace respecting .editorconfig rules. (editorconfig support is built-in neovim).
    'mcauley-penney/tidy.nvim',
    -- commit = '31f95306ffd408ed4bb5185e8ec3bab9516ad34c', -- 2025 April 14
    lazy = false,
    opts = {
      enabled_on_save = true,
      -- variable name is misleading! Without it tidy.nvim.toggle() not works!
      provide_undefined_editorconfig_behavior = true, -- trim ws at EOF
      -- this exclude - not overrides rules defined in .editorconfig!
      filetype_exclude = { 'diff', 'markdown' },
    },
    config = true,
    keys = {
      { -- buffer toggle trimming of whitespaces at the EOF
        mode = 'n', '<localleader>we', function()
          local tidy = require('tidy')
          local opts = tidy.opts
          local new_state = not opts.provide_undefined_editorconfig_behavior
          opts.provide_undefined_editorconfig_behavior = new_state
          tidy.setup(opts)
          vim.notify("ws trim at EOF = " .. string.format("%s", new_state),
            vim.log.levels.INFO, {title = "WNDX"}
          )
        end, desc = 'ws toggle  at EOF buf',
      },
      { -- buffer force one-shot/manual whitespaces trim
        mode = 'n', '<localleader>wf', function()
          require('tidy').run({trim_ws = true})
        end, desc = 'ws force one-shot buf',
      },
      { -- buffer toggle trim of whitespaces + toggle built-in neovim property per buffer
        mode = 'n', '<localleader>wt', function(bufnr)
          local tidy = require('tidy')
          if vim.b.editorconfig.trim_trailing_whitespace == nil then
            return -- cancel => ^ variable not specified in .editorconfig
          end
          tidy.toggle()
          local be_ttw_str = string.format("%s", tidy.opts.enabled_on_save)
          require('editorconfig').properties.trim_trailing_whitespace(bufnr, be_ttw_str)
          vim.notify("trim_trailing_whitespace = " .. be_ttw_str,
            vim.log.levels.INFO, {title = "WNDX"}
          )
        end, desc = 'ws toggle trim ws buf',
      },
    },
  },

  -- syntax
  { 'nvim-treesitter/nvim-treesitter', branch = 'master', lazy = false, build = ':TSUpdate',
    opts = {
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    },
    config = true,
  },
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
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'glts/vim-radical', dependencies = { 'glts/vim-magnum' } }, -- gA, crd, crx, cro, crb

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

  {
    'rmagatti/auto-session',
    lazy = false,
    enabled = true,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      enabled = true,
      root_dir = require('user.fn').path.concat({ vim.fn.stdpath('data'), 'sessions' }),
      auto_save = true,
      auto_restore = true,
      auto_create = false,
      log_level = 'error',
      session_lens = {
        previewer = false,
        path_display = { 'shorten' },
        theme_conf = { border = false },
      },
    },
    config = function(_, opts) -- Recommended sessionoptions config
      vim.o.sessionoptions='blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
      require('auto-session').setup(opts)
    end,
  },

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

  {
    'smoka7/multicursors.nvim',
    -- commit = '72225ea9e4443c3f4b9df91d0193e07c4ee8d382',
    dependencies = {{
      'nvimtools/hydra.nvim',
      -- commit = '8c4a9f621ec7cdc30411a1f3b6d5eebb12b469dc',
    }},
    -- version = '*',
    lazy = false,
    event = 'VeryLazy',
    opts = function(_, opts)
      opts = require('user.pack.conf.multicursors')
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
