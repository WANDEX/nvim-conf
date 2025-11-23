-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'saghen/blink.cmp'

return {
  { -- neovim api, docs support, module annotations | properly configures LuaLS for editing Neovim config.
    'folke/lazydev.nvim', -- :LazyDev debug | :LazyDev lsp - settings for attached LSP servers.
    ft = 'lua', -- only load on lua files
    dependencies = {
      { 'LelouchHe/xmake-luals-addon' }, -- xmake.lua
    },
    opts = {
      library = {
        -- Load luvit types when the 'vim.uv' word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- Load the xmake types when opening file named 'xmake.lua'
        { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    version = '1.*', -- use a release tag to download pre-built binaries
    -- AND/OR build from source, requires nightly:
    -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    dependencies = {
      -- !Important! Make sure you're using the latest release of LuaSnip
      -- `main` does not work at the moment
      { -- snippets engine
        'L3MON4D3/LuaSnip', version = 'v2.*',
        opts = {},
        config = function() -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
          require('luasnip.loaders.from_lua').load({ paths = {'./lua/user/snip/ft'} })
          require('luasnip.loaders.from_vscode').lazy_load({ -- non lazy - slower startup-time!
            exclude = { 'javascript' },
          })
        end,
        dependencies = {
          { 'rafamadriz/friendly-snippets' }, -- snippets collection "from_vscode"
        },
      },
      { 'xzbdmw/colorful-menu.nvim',   opts = {}, config = true },
      { 'nvim-tree/nvim-web-devicons', opts = {} },
      { 'onsails/lspkind.nvim' },
      { 'MahanRahmati/blink-nerdfont.nvim' }, -- trigger on colon : symbol name
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'none', -- set to 'none' to disable the 'default' preset
        ['<Down>']  = { 'select_next' },
        ['<Up>']    = { 'select_prev' },
        ['<C-n>']   = { 'select_next' },
        ['<C-e>']   = { 'select_prev' },
        ['<C-k>']   = { 'scroll_documentation_down' },
        ['<C-j>']   = { 'scroll_documentation_up' },
        ['<C-y>']   = { 'select_and_accept' },
        ['<C-l>']   = { 'cancel', 'fallback_to_mappings' },
        ['<Tab>']   = { 'snippet_forward',  'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<M-s>']   = { 'show_signature', 'hide_signature', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },
      cmdline = {
        keymap = {
          preset = 'inherit',
          ['<C-n>'] = { 'select_next', 'fallback_to_mappings' }, -- fallback fixes this mapping!
          ['<C-e>'] = { 'select_prev', 'fallback_to_mappings' }, -- fallback fixes this mapping!
        }, -- inherit from top level keymap
        completion = { menu = { auto_show = false }, },
      },
      appearance = { nerd_font_variant = 'mono' },
      signature = {
        enabled = true,
        window  = { max_height = 50, max_width = 200, },
        trigger = { enabled = true, },
      },
      snippets   = { preset = 'luasnip' },
      sources = { -- default list of enabled providers
        default = { 'nerdfont', 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          nerdfont = { -- trigger on colon : symbol name
            module = 'blink-nerdfont',
            name = 'NF',
            opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
            min_keyword_length = 3,
            score_offset = -20, -- tune by preference (low priority)
          },
          buffer = {
            min_keyword_length = 3,
            score_offset = -5,
          },
          snippets = {
            min_keyword_length = 2,
            score_offset = -2,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 1,
          },
          lsp = {
            fallbacks = {}, -- always show the buffer source (defaults to { 'buffer' })
            score_offset = 0,
          },
        },
      },
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true, show_without_menu = true, show_with_menu = true },
        keyword = { range = 'full' }, -- 'prefix'
        menu = { -- TODO: enable/show menu if word length > 3 chars, otherwise ghost_text only
          auto_show = true, -- only show menu on manual <C-space>
          draw = {
            align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
            columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'kind' }, { 'source_id' } },
            components = {
              label = { -- label and label_description are combined together in label by colorful-menu.nvim.
                text      = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
              source_name = {
                width = { max = 5 },
              },
              source_id = {
                width = { max = 5 },
                -- text = function(ctx) return '[' .. ctx.source_id .. ']' end
              },

              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require('lspkind').symbolic(ctx.kind, { mode = 'symbol' })
                  end
                  -- return icon .. ' ' -- or ctx.icon_gap
                  return icon -- in my lspkind conf I already appended ' ' to the each symbol
                end,
                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                    local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },

            },
          },
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' }
    }, -- can be extended elsewhere in config, without redefining 'sources.default', due to `opts_extend`
    opts_extend = { 'sources.default' }
  },
}
