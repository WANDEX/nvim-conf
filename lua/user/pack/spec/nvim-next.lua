-- AUTHOR: 'WANDEX/nvim-conf'

local M = {}

M.def_map_tbl = {
  desc = '',
}

---wrapper: vim.keymap.set() - Defines a |mapping| of |keycodes| to a function or keycodes.
---@param mode  string|string[] -- Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs   string          -- Left-hand side  |{lhs}| of the mapping.
---@param rhs   string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
M.map = function(mode, lhs, rhs, opts)
  local def_opts = { desc = '[RM]',  silent = true } -- default opts if not explicitly provided
  local mrg_opts = vim.tbl_extend('force', def_opts, opts)
  mrg_opts.desc = '[RM] ' .. mrg_opts.desc -- stands for: Repeatable Move/Mapping
  -- vim.notify(string.format("opts.silent: %s", mrg_opts.silent), vim.log.levels.INFO) -- DBG
  vim.keymap.set(mode, lhs, rhs, mrg_opts)
end

---wrapper: 'nvim-next.move' make repeatable pair.
---@param p_rhs string|function
---@param n_rhs string|function
---@return string|function, string|function
M.make_repeatable_pair = function(p_rhs, n_rhs)
  local _ok, _ = pcall(require,'nvim-next')
  if not _ok then -- => fallback: use standard - not repeatable cmd.
    return p_rhs, n_rhs ---@return string, string
  end -- END sanity checks
  local prev_item, next_item = require('nvim-next.move').make_repeatable_pair(function(_)
    local ok, _ = false, nil
    if type(p_rhs) == 'string' then
      ok, _ = pcall(vim.cmd, p_rhs)
    end
    if type(p_rhs) == 'function' then
      ok, _ = pcall(p_rhs)
    end
    if not ok then
      vim.notify("[RM] no prev item", vim.log.levels.INFO)
    end
  end, function(_)
    local ok, _ = false, nil
    if type(n_rhs) == 'string' then
      ok, _ = pcall(vim.cmd, n_rhs)
    end
    if type(n_rhs) == 'function' then
      ok, _ = pcall(n_rhs)
    end
    if not ok then
      vim.notify("[RM] no next item", vim.log.levels.INFO)
    end
  end)
  return prev_item, next_item
end

---make repeatable pair cmd and map.
---@param mode  string|string[] -- Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param p_lhs string          -- Left-hand side  |{lhs}| of the mapping.
---@param n_lhs string          -- Left-hand side  |{lhs}| of the mapping.
---@param p_rhs string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param n_rhs string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts  vim.keymap.set.Opts
---Do not add surrounding <cmd>COMMAND<CR> -- will not work!
M.make_repeatable_pair_map = function(mode, p_lhs, n_lhs, p_rhs, n_rhs, opts)
  local p_fun, n_fun = M.make_repeatable_pair(p_rhs, n_rhs)
  M.map(mode, p_lhs, p_fun, vim.tbl_extend('force', opts, {desc = opts.desc .. ' prev'}))
  M.map(mode, n_lhs, n_fun, vim.tbl_extend('force', opts, {desc = opts.desc .. ' next'}))
end

M.main = function()
  local n = 'n' -- mode: normal
  -- jump to next/prev Quickfix list item :cn,:cp | MEMO: create Qlist with word :vim bar %
  M.make_repeatable_pair_map(n, '[q', ']q', 'cp', 'cn', {desc = 'Qlist'})

  M.make_repeatable_pair_map('n', '[d', ']d', function()
    return vim.diagnostic.jump({count=-1, float=false})
  end, -- jump to diag prev/next
  function()
    return vim.diagnostic.jump({count=1,  float=false})
  end, { desc = "[LSP] diag" })


end

M.spec = function()
  return {
    'ghostbuster91/nvim-next',
    lazy = false,
    opts = {
      default_mappings = {
        repeat_style = "original",
      },
    },
    config = function(_, opts)
      require('nvim-next').setup(opts)
      M.main()
    end,
  }
end

return M.spec()
