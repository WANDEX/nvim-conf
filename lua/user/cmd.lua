-- AUTHOR: 'WANDEX/nvim-conf'
-- :h lua-guide-commands-create

vim.api.nvim_create_user_command('W',
function()
  require('user.lib.fn').wfpmt()
end,
{})
