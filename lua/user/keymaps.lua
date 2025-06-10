-- AUTHOR: 'WANDEX/nvim-conf'
-- NOTE: vim.keymap.del cannot be used too early => error: no such mapping!
-- Thus only safe set to the <nop> can only be used to redefine default map.
-- MEMO: use :verbose (map/imap) 'key or sequence' - to see if mapping is used
-- :h map-listing, :h mode-switching, :h recursive_mapping,
-- :h motion.txt, :h omap-info, :h language-mapping

--============================================================================
-- colemak keymaps: hjkl -> hnei -- i.e. left/down/up/right
--============================================================================

local nx  = { 'n', 'x' }      -- Normal, Visual
local nxo = { 'n', 'x', 'o' } -- Normal, Visual, Operator
local nvs = { 'n', 'v' }      -- Normal, Visual, Select
local nvo = { 'n', 'v', 'o' } -- Normal, Visual, Select, Operator

vim.keymap.set(nx , '<M-n>', 'nzz<cmd>call ShowSearchIndexes()<CR>', {
  desc = 'find next', silent = true
}) -- search next/prev result, center on the screen, echo/update search index
vim.keymap.set(nx , '<M-e>', 'Nzz<cmd>call ShowSearchIndexes()<CR>', {
  desc = 'find prev', silent = true
})

-- hjkl -> hnei
vim.keymap.set(nx , 'n', 'j', { silent = true })
vim.keymap.set(nx , 'e', 'k', { silent = true })
vim.keymap.set(nvo, 'i', 'l', { silent = true })

-- vim.keymap.del('o', 'n') -- next
-- vim.keymap.set('o', 'N', '<nop>', { silent = true })
-- vim.keymap.del('o', 'N') -- prev

-- go low (bottom of the screen)
vim.keymap.set(nvo, 'gl', 'L',{ silent = true })

-- forward towards the last letter of the word (end of word)
vim.keymap.set(nvo, 'l', 'e', { silent = true })
vim.keymap.set(nvo, 'L', 'E', { silent = true })

-- insert mode and modifier inside
vim.keymap.set(nvo, 'k', 'i', { silent = true })

-- FIXME: omap? why this standard keymap does not work without this?
-- make it work even after reassigning the original modifier inside
-- fix: for rmagatti/alternate-toggler mapping etc.
-- map ciw ckw
-- vim.keymap.set('' , 'ckw', 'ciw', { silent = true })
-- vim.keymap.set('' , 'ciw', 'ckw', { silent = true })

--============================================================================
-- essential global / safe disable by redefining keymap
--============================================================================

-- CDC = Change to Directory of Current file [[ command CDC cd %:p:h ]]
vim.api.nvim_create_user_command('CDC', "cd %:p:h", {})

-- map ctrl+l as the Esc key (easier to reach default exit key etc.)
vim.keymap.set('' , '<C-l>', '<Esc>', {
  desc = 'ESC', silent = true, buffer = true
}) -- Normal, Visual, Select and Operator-pending
vim.keymap.set('!', '<C-l>', '<C-c>', { -- cancel
  desc = 'ESC', silent = true
}) -- Insert and Command-line
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>', {
  desc = 'ESC', silent = true
}) -- Terminal -- much easier terminal Esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
  desc = 'ESC', silent = true
}) -- Terminal -- much easier terminal Esc

vim.keymap.set('' , '<C-z>', '<nop>', {
  desc = '', silent = true
}) -- disable C-z suspend by overriding

vim.keymap.set('n', 'zz', 'zz', {
  desc = 'Center this line', silent = true
}) -- make zz keymap silent -> to not clear cmd

vim.keymap.set('' , '<ScrollWheelUp>', '<nop>', {
  desc = '', silent = true
}) -- disable mouse scroll up
vim.keymap.set('' , '<ScrollWheelDown>', '<nop>', {
  desc = '', silent = true
}) -- disable mouse scroll down

--============================================================================
-- window keymaps
--============================================================================

-- go to window in direction
vim.keymap.set('n', '<C-w>n', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-w>e', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-w>i', '<C-w>l', { silent = true })

--  move window in direction
vim.keymap.set('n', '<C-w>N', '<C-w>J', { silent = true })
vim.keymap.set('n', '<C-w>E', '<C-w>K', { silent = true })
vim.keymap.set('n', '<C-w>I', '<C-w>L', { silent = true })

-- BEG [DISABLE_DEFAULT_MAPPING]
vim.keymap.set('n', '<C-w><C-n>', '<nop>') -- create new empty buffer window
-- vim.keymap.set('n', '<C-w>n',  '<nop>') -- create new empty buffer window

vim.keymap.set('n', '<C-w>j', '<nop>')
vim.keymap.set('n', '<C-w>k', '<nop>')
vim.keymap.set('n', '<C-w>l', '<nop>')

vim.keymap.set('n', '<C-w>J', '<nop>')
vim.keymap.set('n', '<C-w>K', '<nop>')
vim.keymap.set('n', '<C-w>L', '<nop>')
-- END [DISABLE_DEFAULT_MAPPING]

--============================================================================
-- next/prev keymaps
--============================================================================

vim.keymap.set('n', 'N', '<C-f>', {
  desc = 'scroll page next', silent = true
}) -- scroll screen one page
vim.keymap.set('n', 'E', '<C-b>', {
  desc = 'scroll page prev', silent = true
})

vim.keymap.set('c', '<C-n>', '<C-n>', {
  desc = 'command next', silent = false
})
vim.keymap.set('c', '<C-e>', '<C-p>', {
  desc = 'command prev', silent = false
})

vim.keymap.set('n', ']b', '<cmd>bn<CR>', {
  desc = 'buf next', silent = true
}) -- move to next/prev bufpage :bnext,:bprev
vim.keymap.set('n', '[b', '<cmd>bp<CR>', {
  desc = 'buf prev', silent = true
})

vim.keymap.set('n', ']t', '<cmd>tabn<CR>', {
  desc = 'tab next', silent = true
}) -- move to next/prev tab :tabnext,:tabprevious
vim.keymap.set('n', '[t', '<cmd>tabp<CR>', {
  desc = 'tab prev', silent = true
})

-- MEMO: create Llist with word :lvim bar %
vim.keymap.set('n', ']l', '<cmd>lne<CR>', {
  desc = 'Llist next', silent = true
}) -- jump to next/prev Location list item :lne,:lp
vim.keymap.set('n', '[l', '<cmd>lp<CR>', {
  desc = 'Llist prev', silent = true
})

-- MEMO: create Qlist with word :vim bar %
vim.keymap.set('n', ']q', '<cmd>cn<CR>', {
  desc = 'Qlist next', silent = true
}) -- jump to next/prev Quickfix list item :cn,:cp
vim.keymap.set('n', '[q', '<cmd>cp<CR>', {
  desc = 'Qlist prev', silent = true
})

--============================================================================
-- Function keys
--============================================================================

-- TODO: how to reload lazy.nvim config?
-- " Reload vim configuration (old)
-- nnoremap <localleader>rc <cmd>ReloadConfig<CR>
