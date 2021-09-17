-- setup: lspconfig, snippets, nvim-cmp

local use = require('packer').use
use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

use { -- Install nvim-cmp, and sources as a dependency
  -- sources
  'hrsh7th/cmp-nvim-lsp',         -- LSP
  "hrsh7th/cmp-nvim-lua",         -- neovim's Lua runtime API such vim.lsp.*
  "hrsh7th/cmp-buffer",           -- buffer words
  "hrsh7th/cmp-path",             -- filesystem paths
  "hrsh7th/cmp-calc",             -- simple math calculation
  "octaltree/cmp-look",           -- completing words in English $export WORDLIST="/usr/share/dict/dictname"
  requires = {
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
  },
}

-- snippets
use 'rafamadriz/friendly-snippets' -- Snippets collection
local snip_engine = 'luasnip' -- variable for swapping snippet engines (requires :PackerSync after changing)
if ( snip_engine == 'luasnip' ) then
  snip_source = 'luasnip'
  use {
    'L3MON4D3/LuaSnip', -- snippets engine
    requires = {
      'saadparwaiz1/cmp_luasnip', -- luasnip snippets cmp source
    },
  }
  -- lazy loading so you only get in memory snippets of languages you use
  require("luasnip/loaders/from_vscode").lazy_load() -- takes snippets from "friendly-snippets"
else
  snip_source = 'vsnip'
  use {
    'hrsh7th/vim-vsnip', -- snippets engine
    requires = {
      'hrsh7th/vim-vsnip-integ',  -- vsnip snippet completion/expansion
      'hrsh7th/cmp-vsnip',        -- vsnip snippets cmp source
    },
  }
end

-- show function signature when you type inside (|)
use {'ray-x/lsp_signature.nvim', requires = {'hrsh7th/nvim-cmp'}}
require'lsp_signature'.setup({
  bind = true,
  doc_lines = 5,
  floating_window = true,
  hint_enable = false,
  handler_opts = {border = "single"},
  extra_trigger_chars = {"(", ","},
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',          '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr',          '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>la',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>lD',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<Leader>lh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>le',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>ll',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '[d',          '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',          '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
-- capabilities.textDocument.completion.completionItem.snippetSupport = true -- error if true: clangd
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert', -- preselect first result
    keyword_length = 2,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-h>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-l>'] = cmp.mapping.close(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if (snip_source == 'luasnip') and require'luasnip'.expand_or_jumpable() then
        vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
      elseif (snip_source == 'vsnip') and vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if (snip_source == 'luasnip') and require'luasnip'.jumpable(-1) then
        vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
      elseif (snip_source == 'vsnip') and vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)'), '')
      else
        fallback()
      end
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      -- set source name to show
      vim_item.menu = ({
        nvim_lsp = "[L]",
        nvim_lua = "[nvimLua]",
        luasnip = "[S]",
        vsnip = "[S]",
        buffer = "[B]",
        path = "[P]",
        calc = "[C]",
        look = "[W]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = snip_source },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'look' },
  },
}
