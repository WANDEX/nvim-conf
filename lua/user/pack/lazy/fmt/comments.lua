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
    vim.notify(string.format("FIRE: %s", lhs), vim.log.levels.INFO)
  end, { desc = 'comment toggle', silent = false })
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

---@nodiscard
---@param rhs string
---@return string|function
M.rhs = function(rhs)
  -- fix: E5108: Error executing lua/vim/_comment.lua:210: Buffer is not 'modifiable'
  if vim.bo.commentstring == '' or not vim.bo.modifiable or vim.bo.readonly then
    return function() end -- => do nothing - to avoid receiving obvious error.
  end
  return rhs -- => map to gc/gcc
end

--- vim.keymap.set wrapper - actually map onto default neovim comment keys,
--- recursive mapping: remap=true required!
---@param lhs string
---
--- neovim internals impl & orig vim.keymap.set:
--- https://github.com/neovim/neovim/blob/e82aef2e22a57688dcc19a978cbe083349ad8a2a/runtime/lua/vim/_defaults.lua#L174
M.map_comment_keys = function(lhs)
  vim.keymap.set({ 'n', 'x' }, lhs, M.rhs('gc'),  { remap = true, desc = 'comment toggle' })
  vim.keymap.set({ 'n' },      lhs, M.rhs('gcc'), { remap = true, desc = 'comment toggle line' })
  vim.keymap.set({ 'o' },      lhs, M.rhs('gc'),  { remap = true, desc = 'comment textobject' })
end

--- map 'C-/' which is a standard comment toggle key in many text editors
--- FIXME: keymap via keycode such as keycode '\31' etc, are not portable!
--- for not supported platfroms and terminals, mapping must be changed.
--- but in such edge cases it is easier to use standard: gc/gcc
M.bind_comment_keys = function()
  -- M.map_comment_key_tests()
  M.map_comment_keys('<leader>ac') -- always working fallback
  M.map_comment_keys('\31') -- works with: st-256color
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

M.bind_comment_keys()
return M.spec
