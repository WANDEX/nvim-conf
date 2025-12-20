-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'folke/flash.nvim'

local M = {}

function M.jump2d()
  local Flash = require('flash')

  ---@param opts Flash.Format
  local function format(opts)
    --- always show first and second label
    return { ---@diagnostic disable undefined-field
      { opts.match.label1, 'FlashMatch' },
      { opts.match.label2, 'FlashLabel' },
    }
  end

  Flash.jump({
    search = { mode = 'search' },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = function(win)
          -- limit matches to the current label
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2 -- use the second label
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
        match.label2 = labels[(m - 1) % #labels + 1]
        match.label = match.label1
      end
    end,
  })
end

function M.jump1()
  local opts = {
    modes = {
      search = {
        mode = 'exact',
      },
    },
  }
  require('flash').jump(opts)
end

function M.jump2()
  local opts = {
    modes = {
      search = {
        mode = 'fuzzy',
      },
    },
    highlight = {
      backdrop = true, -- show a backdrop with hl FlashBackdrop
    },
  }
  require('flash').jump(opts)
end

--- simulate nvim-treesitter incremental selection
function M.ts_inc_sel()
  require('flash').treesitter({
    actions = {
      ['<c-space>'] = 'next',
      ['<BS>'] = 'prev'
    }
  })
end

M.spec = {

  {
    'justinmk/vim-sneak', -- replace f/F t/T with one-character Sneak
    lazy = false,
    enabled = false, -- replaced by flash.nvim
    keys = { -- not map in Select mode (to not break snippets expansion)
      { mode = { 'n', 'x', 'o' }, 'f', '<Plug>Sneak_f', },
      { mode = { 'n', 'x', 'o' }, 'F', '<Plug>Sneak_F', },
      { mode = { 'n', 'x', 'o' }, 't', '<Plug>Sneak_t', },
      { mode = { 'n', 'x', 'o' }, 'T', '<Plug>Sneak_T', },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      -- labels = 'asdfghjklqwertyuiopzxcvbnm', -- default
      -- labels = 'arstdhneioqwfpgjluyzxcvbnm', -- colemak
      -- labels = 'neio arst dh qwfp gj luy zxcv bkm', -- colemak reorder
      -- labels = 'neio tsra hd pfwq luy vcxz bkm', -- colemak reorder-reorder
      -- labels = 'ne t h fwq luy z b', -- colemak reorder-reorder (no-input)
      labels = 'nethfwqluyzb', -- colemak reorder-reorder (no-input keys)
      label = {
        uppercase = true, -- allow uppercase labels
      },
      highlight = {
        backdrop = false, -- show a backdrop with hl FlashBackdrop
        matches  = false, -- highlight the search matches
        priority = 5000,  -- extmark priority
        groups = {
          label = 'DRED',
        },
      },
      modes = {
        char = { -- `f`, `F`, `t`, `T`, `;` and `,` motions
          jump_labels = false,
          highlight = { backdrop = false },
        },
        search = { -- a regular search with `/` or `?`
          highlight = { backdrop = false },
        },
      },
    },
    config = function(_, opts)
      require('flash').setup(opts)

      vim.keymap.set({ 'n', 'x', 'o' }, 's', M.jump1, { desc = 'Flash' })

      vim.keymap.set('n', '<c-s>', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
      vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end,  { desc = 'Toggle Flash Search' })

      vim.keymap.set('x', '<c-space>', M.ts_inc_sel, { desc = 'Treesitter Incremental Selection' })
      vim.keymap.set('x',      '<BS>', M.ts_inc_sel, { desc = 'Treesitter Incremental Selection' })
    end,
    --[[
    -- stylua: ignore
    keys = {
      { mode = { 'n', 'x', 'o' }, 's', M.jump1, desc = 'Flash' },

      { mode = 'n', '<c-s>', function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { mode = 'c', '<c-s>', function() require('flash').toggle() end,  desc = 'Toggle Flash Search' },

      { mode = 'x', '<c-space>', M.ts_inc_sel, desc = 'Treesitter Incremental Selection' },
      { mode = 'x', '<BS>',      M.ts_inc_sel, desc = 'Treesitter Incremental Selection' },
    },
    --]]
  },

}

return M.spec
