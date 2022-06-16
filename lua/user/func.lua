local M = {}

M.wfpmt = function() -- write file preserving old modification time
  local fpath = vim.api.nvim_buf_get_name(0) -- current buffer file full path
  local mtime = vim.fn.getftime(fpath)       -- file modification time
  vim.cmd("write")
  vim.fn.system(string.format('touch -d @%s "%s"', mtime, fpath)) -- set back old mtime
  vim.cmd("edit") -- reload file after it has been changed
end
vim.api.nvim_create_user_command('W', "lua require('user.func').wfpmt()", {})

return M
