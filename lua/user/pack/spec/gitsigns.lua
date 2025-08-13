-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'lewis6991/gitsigns

return {
  'lewis6991/gitsigns.nvim',
  version = '*',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    on_attach = function(bufnr)
      local gs = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gs.nav_hunk('next')
        end
      end, {desc='gs.nav_hunk("next")'})

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gs.nav_hunk('prev')
        end
      end, {desc='gs.nav_hunk("prev")'})

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, {desc='gs.stage_hunk'})
      map('n', '<leader>hr', gs.reset_hunk, {desc='gs.reset_hunk'})

      map('v', '<leader>hs', function()
        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, {desc='gs.stage_hunk'})

      map('v', '<leader>hr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, {desc='gs.reset_hunk'})

      map('n', '<leader>hS', gs.stage_buffer, {desc='gs.stage_buffer'})
      map('n', '<leader>hR', gs.reset_buffer, {desc='gs.reset_buffer'})
      map('n', '<leader>hp', gs.preview_hunk, {desc='gs.preview_hunk'})
      map('n', '<leader>hi', gs.preview_hunk_inline, {desc='gs.preview_hunk_inline'})

      map('n', '<leader>hb', function()
        gs.blame_line({ full = true })
      end, {desc='gs.blame_line'})

      map('n', '<leader>hd', gs.diffthis, {desc='gs.diffthis'})

      map('n', '<leader>hD', function()
        gs.diffthis('~')
      end, {desc='gs.diffthis("~")'})

      map('n', '<leader>hQ', function() gs.setqflist('all') end, {desc='gs.setqflist("all")'})
      map('n', '<leader>hq', gs.setqflist, {desc='gs.setqflist'})

      -- Toggles
      map('n', '<leader>ab', gs.toggle_current_line_blame, {desc='gs.toggle_current_line_blame'})
      map('n', '<leader>aw', gs.toggle_word_diff, {desc='gs.toggle_word_diff'})

      -- Text object
      map({'o', 'x'}, 'ih', gs.select_hunk, {desc='gs.select_hunk'})
    end,
  },
}
