-- AUTHOR: 'WANDEX/nvim-conf'
-- user functions

local M = {
  path = {},
  table = {},
}

--- check weather the table is empty
---@nodiscard
---@param t table
---@return boolean
function M.table.empty(t)
    return next(t) == nil
end

---@nodiscard
---@param path_components string[]
---@return string
---@see src: 'https://github.com/mason-org/mason.nvim/blob/8024d64e1330b86044fed4c8494ef3dcd483a67c/lua/mason-core/path.lua#L5'
function M.path.concat(path_components)
    return vim.fs.normalize(table.concat(path_components, '/'))
end

--- write file preserving old modification time.
function M.wfpmt()
  local fpath = vim.api.nvim_buf_get_name(0) -- current buffer file full path
  local mtime = vim.fn.getftime(fpath)       -- file modification time
  vim.cmd("write")
  vim.fn.system(string.format('touch -d @%s "%s"', mtime, fpath)) -- set back old mtime
  vim.cmd("edit") -- reload file after it has been changed
end

--- split string by the separator sequence into array of strings.
--- (global function) version specifically for working with lua string.
---@nodiscard
---@param sep_seq? string
---@return string[]
function string:split_by(sep_seq)
    local seps = sep_seq or ','
    local result = {}
    local i = 1
    for c in (self..seps):gmatch(string.format('([^%s]+)', seps)) do
        result[i] = c
        i = i + 1
    end
    return result
end

--- split string by the separator sequence into array of strings.
---@nodiscard
---@param s string
---@param sep_seq? string
---@return string[]
function M.split_by(s, sep_seq)
    local seps = sep_seq or ','
    local result = {}
    local i = 1
    for c in (s..seps):gmatch(string.format('([^%s]+)', seps)) do
        result[i] = c
        i = i + 1
    end
    return result
end

--- get clipboard content, split multiline string by NL and return as array of strings.
---@nodiscard
---@return string[]
function M.get_clip_content_as_table_split_by_nl()
  -- multiline string must be converted to table of lines (req. by luasnip snippets etc.)
  -- unlike with vim.fn.system(), multiline string is split by NL into |List| (array of strings).
  return vim.fn.systemlist('xsel -bo')
end

return M
