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
      { 'L3MON4D3/LuaSnip', version = 'v2.*' }, -- snippets engine
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
      completion = { documentation = { auto_show = true } },
      signature  = { enabled = true },
      snippets   = { preset = 'luasnip' },
      sources = { -- default list of enabled providers
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = { fallbacks = {} } -- always show the buffer source (defaults to { 'buffer' })
        },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' }
    }, -- can be extended elsewhere in config, without redefining 'sources.default', due to `opts_extend`
    opts_extend = { 'sources.default' }
  },
}
