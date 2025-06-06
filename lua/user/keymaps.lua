
-- map ctrl+l as the Esc key (easier to reach default exit key etc.)
vim.keymap.set('', '<C-l>', '<Esc>', {
  desc = 'ESC', remap = true, silent = true, buffer = true
})
