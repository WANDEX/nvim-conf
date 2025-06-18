-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'saghen/blink.cmp'

return {
  {
    'saghen/blink.cmp',
    version = '1.*', -- use a release tag to download pre-built binaries
    -- AND/OR build from source, requires nightly:
    -- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }, -- snippets collection
      -- !Important! Make sure you're using the latest release of LuaSnip
      -- `main` does not work at the moment
      { -- snippets engine
        'L3MON4D3/LuaSnip', version = 'v2.*',
        opts = {},
        config = function() -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
          require('luasnip.loaders.from_lua').load({paths = './lua/user/snip/ft'})
        end,
      },
      { 'xzbdmw/colorful-menu.nvim',   opts = {}, config = true, },
      { 'nvim-tree/nvim-web-devicons', opts = {} },
      {
        'onsails/lspkind.nvim',
        opts = {
          mode = 'symbol',
          preset = 'default',
          symbol_map = {
            Text = "T",
            Method = "M",
            Function = "F",
            Constructor = "N",
            Field = "f",
            Variable = "v",
            Class = "C",
            Interface = "I",
            Module = "m",
            Property = "p",
            Unit = "u",
            Value = "V",
            Enum = "E",
            Keyword = "k",
            Snippet = "s",
            Color = "r",
            File = "d",
            Reference = "R",
            Folder = "D",
            EnumMember = "e",
            Constant = "c",
            Struct = "S",
            Event = "n",
            Operator = "o",
            TypeParameter = "t",
          },
        },
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'none', -- set to 'none' to disable the 'default' preset
        ['<Down>']  = { 'select_next', 'fallback' },
        ['<Up>']    = { 'select_prev', 'fallback' },
        ['<C-n>']   = { 'select_next', 'fallback_to_mappings' },
        ['<C-e>']   = { 'select_prev', 'fallback_to_mappings' },
        ['<C-k>']   = { 'scroll_documentation_down', 'fallback' },
        ['<C-j>']   = { 'scroll_documentation_up',   'fallback' },
        ['<C-y>']   = { 'select_and_accept' },
        ['<C-l>']   = { 'cancel', 'fallback' },
        ['<Tab>']   = { 'snippet_forward',  'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      },
      appearance = { nerd_font_variant = 'mono' },
      -- completion = { documentation = { auto_show = true } },
      signature  = { enabled = true },
      snippets   = { preset = 'luasnip' },
      sources = { -- default list of enabled providers
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = { fallbacks = {} } -- always show the buffer source (defaults to { 'buffer' })
        },
      },
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true, show_with_menu = true }, -- only show when menu is closed
        menu = {
          auto_show = true, -- only show menu on manual <C-space>
          draw = {
            columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'kind' }, { 'source_id' } },
            components = {
              label = { -- label and label_description are combined together in label by colorful-menu.nvim.
                text      = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
              source_id = {
                text = function(ctx) return '[' .. ctx.source_id .. ']' end
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
                  return icon .. ctx.icon_gap
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
