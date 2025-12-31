-- AUTHOR: 'WANDEX/nvim-conf'
-- :h lua-guide-commands-create

--- frequently accidentally press Q instead of q.
vim.api.nvim_create_user_command('Q',  'q',  {})
vim.api.nvim_create_user_command('Qa', 'qa', {})

--- CDC = Change to Directory of Current file [[ command CDC cd %:p:h ]]
vim.api.nvim_create_user_command('CDC', 'cd %:p:h', {})

vim.api.nvim_create_user_command('W',
function()
  require('user.lib.fn').wfpmt()
end,
{})
