vim.keymap.set('', '<ScrollWheelUp>', '<nop>', {
  desc = '', remap = true, silent = true
}) -- disable mouse scroll up
vim.keymap.set('', '<ScrollWheelDown>', '<nop>', {
  desc = '', remap = true, silent = true
}) -- disable mouse scroll down

vim.keymap.set('', '<C-z>', '<nop>', {
  desc = '', remap = true, silent = true
}) -- disable C-z suspend by overriding

vim.keymap.set('', '<C-l>', '<Esc>', {
  desc = 'ESC', remap = true, silent = true, buffer = true
}) -- map ctrl+l as the Esc key (easier to reach default exit key etc.)

-- CDC = Change to Directory of Current file [[ command CDC cd %:p:h ]]
vim.api.nvim_create_user_command('CDC', "cd %:p:h", {})
