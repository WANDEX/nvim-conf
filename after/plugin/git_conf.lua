-- configuration for the git related plugins

local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
  return
end

-- require('neogit').setup{}

gitsigns.setup{
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  numhl = false,
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '^', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation: next_hunk()
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Navigation: prev_hunk()
    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='gs.stage_hunk'})
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, {desc='gs.reset_hunk'})
    map('n', '<leader>hs', gs.stage_hunk,                           {desc='gs.stage_hunk'})
    map('n', '<leader>hr', gs.reset_hunk,                           {desc='gs.reset_hunk'})
    map('n', '<leader>hS', gs.stage_buffer,                         {desc='gs.stage_buffer'})
    map('n', '<leader>hu', gs.undo_stage_hunk,                      {desc='gs.undo_stage_hunk'})
    map('n', '<leader>hR', gs.reset_buffer,                         {desc='gs.reset_buffer'})
    map('n', '<leader>hp', gs.preview_hunk,                         {desc='gs.preview_hunk'})
    map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc='gs.blame_line{full=true}'})
    map('n', '<leader>hd', gs.diffthis,                             {desc='gs.diffthis'})
    map('n', '<leader>hD', function() gs.diffthis('~') end,         {desc='gs.diffthis(~)'})

    -- toggle
    map('n', '<leader>ab', gs.toggle_current_line_blame,            {desc='gs.toggle_current_line_blame'})
    map('n', '<leader>ad', gs.toggle_deleted,                       {desc='gs.toggle_deleted'})

    -- Text object
    map({'o', 'x'}, 'kh', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
