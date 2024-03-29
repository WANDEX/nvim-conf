local M = {}

-- write file preserving old modification time.
M.wfpmt = function()
  local fpath = vim.api.nvim_buf_get_name(0) -- current buffer file full path
  local mtime = vim.fn.getftime(fpath)       -- file modification time
  vim.cmd("write")
  vim.fn.system(string.format('touch -d @%s "%s"', mtime, fpath)) -- set back old mtime
  vim.cmd("edit") -- reload file after it has been changed
end
vim.api.nvim_create_user_command('W', "lua require('user.func').wfpmt()", {})

-- split string by the separator sequence into a table.
function string:split_to_table(sep_seq)
    local seps = sep_seq or ","
    local result = {}
    local i = 1
    for c in (self..seps):gmatch(string.format("([^%s]+)", seps)) do
        result[i] = c
        i = i + 1
    end
    return result
end

-- get clipboard content as table.
M.get_clip_content_as_table_split_by_nl = function()
  -- multiline string must be converted to table of lines (req. by luasnip snippets etc.)
  return vim.fn.system('xsel -bo'):split_to_table('\n')
end

return M
