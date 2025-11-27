-- AUTHOR: 'WANDEX/nvim-conf'
-- other hard to classify plugins

return {
  { 'folke/lazy.nvim', version = '*' }, -- lazy - plugin manager for this spec

  { 'neovim/nvim-lspconfig' }, -- collection of configurations for built-in LSP client!

  { 'airblade/vim-rooter' }, -- auto cd to the project root

  { 'farmergreg/vim-lastplace' },

  { 'justinmk/vim-gtfo', enabled = false }, -- XXX

  {
    'iamcco/markdown-preview.nvim', ft = { 'markdown' },
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = ':call mkdp#util#install()', -- else run manually :Lazy build markdown-preview.nvim
  },

  {
    'glacambre/firenvim',
    version = '*',
    enabled = false,
    build = ':call firenvim#install(0)', -- else run manually
  },

}
