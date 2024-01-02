-- setup: lspconfig, nvim-cmp

local  cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end


-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"

cmp.setup({

  completion = {
    keyword_length = 2,
  },

  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-e>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-h>'] = cmp.mapping.scroll_docs(4),

    ["<C-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<C-Space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },

    -- ['<C-l>'] = cmp.mapping.close(),
    ['<Esc>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.config.disable,

  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = {
    format = function(entry, vim_item)
      -- set source name to show
      vim_item.menu = ({
        luasnip  = "[S]",
        nvim_lua = "[api]",
        nvim_lsp = "[L]",
        buffer   = "[B]",
        look     = "[W]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = {
    { name = 'luasnip'  },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer'  , keyword_length = 4 },
    { name = 'look'    , keyword_length = 6 },
  },
})
