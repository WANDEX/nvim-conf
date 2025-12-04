-- AUTHOR: 'WANDEX/nvim-conf'
-- :h lua-guide-commands-create

--- CDC = Change to Directory of Current file [[ command CDC cd %:p:h ]]
vim.api.nvim_create_user_command('CDC', "cd %:p:h", {})

vim.api.nvim_create_user_command('W',
function()
  require('user.lib.fn').wfpmt()
end,
{})
