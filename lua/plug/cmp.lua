--[[ nvim-cmp
  ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _
 / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
| |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
| |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
 \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
configuration for the plugin "hrsh7th/nvim-cmp" ]]

local use = require('packer').use
require('packer').startup(function()
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use { -- Snippets engine
    'L3MON4D3/LuaSnip',
    requires = { -- Snippets collection
      "rafamadriz/friendly-snippets",
    },
  }
  use { -- Install nvim-cmp, and sources as a dependency
    "hrsh7th/nvim-cmp", -- Autocompletion plugin
    requires = { -- sources
      'saadparwaiz1/cmp_luasnip', -- snippets
      'hrsh7th/cmp-nvim-lsp',     -- LSP
      "hrsh7th/cmp-nvim-lua",     -- neovim's Lua runtime API such vim.lsp.*
      "hrsh7th/cmp-buffer",       -- buffer words
      "hrsh7th/cmp-path",         -- filesystem paths
      "hrsh7th/cmp-calc",         -- simple math calculation
      "octaltree/cmp-look",       -- completing words in English $export WORDLIST="/usr/share/dict/dictname"
    },
  }
end)

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
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
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'
-- lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load() -- takes snippets from "friendly-snippets"

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert', -- preselect first result
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-h>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-l>'] = cmp.mapping.close(),
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
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-e>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
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
        buffer = "[B]",
        path = "[P]",
        calc = "[C]",
        look = "[W]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'look' },
  },
}
