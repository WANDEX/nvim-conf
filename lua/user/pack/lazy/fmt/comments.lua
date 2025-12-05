-- AUTHOR: 'WANDEX/nvim-conf'
-- plugins related to comments & bind comment toggle keys
--
-- XXX: not sure:
-- 'Djancyp/better-comments.nvim' -- hi: TODO, FIXME, XXX, and any custom pattern.
-- 'folke/todo-comments.nvim' -- ^ same idea, but much more features
-- 'numToStr/Comment.nvim'

local M = {}

--- vim.keymap.set wrapper - for testing availability of the key
---@param lhs string
M.map_comment_key_test = function(lhs)
  vim.keymap.set({'n', ''}, lhs, function()
    vim.notify(string.format('FIRE: %s', lhs), vim.log.levels.INFO)
  end, { desc = '[TEST] comment toggle', silent = false })
end

--- test 'C-/' which is a standard comment toggle key in many text editors
--- Default maps for built-in commenting.  See |gc-default| and |gcc-default|.
---
--- hist: https://groups.google.com/g/vim_dev/c/Ym6D-kWIsyo
M.map_comment_key_tests = function()
  ---map 'C-/' may be a not valid keycode
  if false then M.map_comment_key_test('C-/') end
  ---map 'C-/' == 'C-_' (in my system maps literal: ctrl+shift+_)
  if false then M.map_comment_key_test('C-_') end
  ---map 'C-/': INSERT(<C-v><C-/>) -> ''; :lua print(string.byte('^_')) -> 31 == '\31'
  if false then M.map_comment_key_test('\31') end ---works with: st-256color
end

--- create buffer-local mapping - specifically for comment toggle seq: gc/gcc.
--- recursive mapping: remap=true required!
--- wrapper: vim.keymap.set() - Defines a |mapping| of |keycodes| to a function or keycodes.
---@param mode  string|string[] -- Mode 'short-name' (see |nvim_set_keymap()|), or a list thereof.
---@param lhs   string          -- Left-hand side  |{lhs}| of the mapping.
---@param rhs   string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, opts)
  local def_opts = {
    buffer=true, silent=true, nowait=true, remap=true, desc = '',
  } -- default opts if not explicitly provided
  local mrg_opts = vim.tbl_extend('force', def_opts, opts)
  if mrg_opts.buffer then
    mrg_opts.desc = '[B] ' .. mrg_opts.desc -- [B] buffer-local mapping
  end
  -- vim.notify(string.format('fire! %s', lhs), vim.log.levels.DEBUG)
  vim.keymap.set(mode, lhs, rhs, mrg_opts)
end

--- create buffer-local mapping - specifically for comment toggle seq: gc/gcc.
---@param callback string|function
function M.comments_buf_local_maps_aug(callback)
  vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('custom_comments_mappings', { clear = true }),
    pattern = '*', -- for all ft
    callback = function()
      --- fix: E5108: Error executing lua/vim/_comment.lua:210: Buffer is not 'modifiable'
      --- such dynamic behavior is possible only in buffer-local mapping ctx.
      --- guard => do nothing - to avoid doing M.map and receiving obvious error.
      if vim.bo.commentstring == '' or not vim.bo.modifiable or vim.bo.readonly then
        return
      end
      callback()
    end
  })
end

--- vim.keymap.set wrapper - actually map onto default neovim comment key seq: gc/gcc.
---@param lhs string
---
--- neovim internals impl & orig vim.keymap.set:
--- https://github.com/neovim/neovim/blob/e82aef2e22a57688dcc19a978cbe083349ad8a2a/runtime/lua/vim/_defaults.lua#L174
M.map_comment_keys = function(lhs)
  M.map({ 'n', 'x' }, lhs, 'gc',  { desc = 'comment toggle' })
  M.map({ 'n' },      lhs, 'gcc', { desc = 'comment toggle line' })
  M.map({ 'o' },      lhs, 'gc',  { desc = 'comment textobject' })
end

--- map 'C-/' which is a standard comment toggle key in many text editors
--- FIXME: keymap via keycode such as keycode '\31' etc, are not portable!
--- for not supported platfroms and terminals, mapping must be changed.
--- but in such edge cases it is easier to use standard: gc/gcc
M.bind_comment_keys = function()
  -- M.map_comment_key_tests()
  M.map_comment_keys('<leader>ac') -- always working fallback
  M.map_comment_keys('\31') -- works with: st-256color
  --- ^ default not binds for the insert mode
  M.map({ 'i' }, '\31', function() vim.cmd.normal({'gcc', bang = false}) end, { desc = 'comment toggle line' })
end

M.spec = {
  { 'scrooloose/nerdcommenter', enabled = false }, -- I do not use it's mappings anymore
  {
    'folke/ts-comments.nvim',
    lazy = false,
    opts = {},
    enabled = vim.fn.has('nvim-0.10.0') == 1,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' }, -- treesitter-parsers must be installed!
      -- { 'JoosepAlviste/nvim-ts-context-commentstring' }, -- XXX: not sure that it is needed
    },
  },
}

M.comments_buf_local_maps_aug(M.bind_comment_keys)
return M.spec
