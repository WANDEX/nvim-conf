-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'danymat/neogen'

return {
  'danymat/neogen',
  lazy = false,
  opts = {
    snippet_engine = 'luasnip',
  },
  config = function(_, opts)
    require('neogen').setup(opts)
  end,
  keys = {
    {
      mode = 'n', '<leader>TGF', function()
        require('neogen').generate({type='file'})
      end, desc = 'neogen annot File', silent = true
    },
    {
      mode = 'n', '<leader>TGf', function()
        require('neogen').generate({type='func'})
      end, desc = 'neogen annot func', silent = true
    },
    {
      mode = 'n', '<leader>TGc', function()
        require('neogen').generate({type='class'})
      end, desc = 'neogen annot class', silent = true
    },
    {
      mode = 'n', '<leader>TGt', function()
        require('neogen').generate({type='type'})
      end, desc = 'neogen annot type', silent = true
    },
    {
      mode = 'n', '<leader>TGls', function()
        local snippet, row, col = require('neogen').generate({ snippet_engine = 'luasnip' })
        -- local snippet, row, col = require('neogen').generate({ snippet_engine = 'luasnip', return_snippet = true })
        local ls = require('luasnip')
        -- FIXME
        -- TODO: also need to jump onto: row, col, then insert text.
        -- And then pass the snippet to the plugin's snippet expansion function.
        -- ls.lsp_expand(snippet, { pos={row,col} }) -- is this is the right function? do I call it properly?
        -- ls.lsp_expand(snippet, { pos[1]=row, pos[1]=col }) -- is this is the right function? do I call it properly?
        -- vim.notify(("row=%d, col=%d, snippet=\n%s"):format(row, col, snippet), vim.log.levels.DEBUG) -- XXX
        -- vim.notify(("snippet=\n%s"):format(snippet), vim.log.levels.DEBUG) -- XXX
      end, desc = 'neogen annot gen snip', silent = true
    },
  },
  -- require('neogen').setup({ snippet_engine = "luasnip" })
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter' }, -- treesitter-parsers must be installed!
    { 'L3MON4D3/LuaSnip' }, -- for snippet support & expand function
  },
}
