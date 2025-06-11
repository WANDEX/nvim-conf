-- AUTHOR: 'WANDEX/nvim-conf'
-- NOTE: vim.keymap.del cannot be used too early => error: no such mapping!
-- Thus only safe set to the <nop> can only be used to redefine default map.
-- MEMO: use :verbose (map/imap) 'key or sequence' - to see if mapping is used
-- :h map-listing, :h mode-switching, :h recursive_mapping,
-- :h motion.txt, :h omap-info, :h language-mapping

local nx  = { 'n', 'x' }      -- Normal, Visual
local nxo = { 'n', 'x', 'o' } -- Normal, Visual, Operator
local nvs = { 'n', 'v' }      -- Normal, Visual, Select
local nvo = { 'n', 'v', 'o' } -- Normal, Visual, Select, Operator

--============================================================================
-- repeat search/pattern -- save default n/N keymaps -- then override
--============================================================================

vim.keymap.set('n', 'zz', 'zz', {
  desc = 'Center this line', silent = true
}) -- make zz keymap silent -> to not clear cmd

-- save def repeat pattern n/N as uniq seq => n/N keys are overridden later!
vim.keymap.set(nvo, 'gSP}', 'n', {
  desc = 'repeat search/pattern in  direction', silent = true, remap = false
}) -- go search/repeat pattern in (opposite) direction
vim.keymap.set(nvo, 'gSP{', 'N', {
  desc = 'repeat search/pattern in !direction', silent = true, remap = false
})

vim.keymap.set(nvo, 'gSPZ}', 'gSP}zz', {
  desc = 'repeat search/pattern in  direction & center line', silent = true, remap = true
}) -- go search/repeat pattern in (opposite) direction & center line
vim.keymap.set(nvo, 'gSPZ{', 'gSP{zz', {
  desc = 'repeat search/pattern in !direction & center line', silent = true, remap = true
})

vim.keymap.set(nvo, '<M-n>', 'gSPZ}<cmd>call ShowSearchIndexes()<CR>', {
  desc = 'find next', silent = true, remap = true
}) -- search next/prev result, center line, echo/update search index
vim.keymap.set(nvo, '<M-e>', 'gSPZ{<cmd>call ShowSearchIndexes()<CR>', {
  desc = 'find prev', silent = true, remap = true
})

vim.keymap.set(nvo, 'N', '<C-f>', {
  desc = 'scroll page next', silent = true
}) -- scroll screen one page
vim.keymap.set(nvo, 'E', '<C-b>', {
  desc = 'scroll page prev', silent = true
})

--============================================================================
-- colemak keymaps: hjkl -> hnei -- i.e. left/down/up/right
--============================================================================

-- insert mode and modifier inside
vim.keymap.set(nvo, 'k', 'i', { silent = true })

-- go low (bottom of the screen)
vim.keymap.set(nvo, 'gl', 'L',{ silent = true })

-- forward towards last letter of the word (end of word)
vim.keymap.set(nvo, 'l', 'e', { silent = true })
vim.keymap.set(nvo, 'L', 'E', { silent = true })

-- hjkl -> hnei
vim.keymap.set(nvo, 'n', 'j', { silent = true })
vim.keymap.set(nvo, 'e', 'k', { silent = true })
-- do not modify Operator mode (some plugins rely on default e.g. i -> ciw)
vim.keymap.set(nvs, 'i', 'l', { silent = true })

--============================================================================
-- essential global / safe disable by redefining keymap
--============================================================================

-- map ctrl+l as the Esc key (easier to reach default exit key etc.)
vim.keymap.set('' , '<C-l>', '<Esc>', {
  desc = 'ESC', silent = true, buffer = true
}) -- Normal, Visual, Select and Operator-pending
vim.keymap.set('!', '<C-l>', '<C-c>', { -- cancel
  desc = 'ESC', silent = true
}) -- Insert, Command
vim.keymap.set('t', '<C-l>', '<C-\\><C-n>', {
  desc = 'ESC', silent = true
}) -- Terminal -- much easier terminal Esc
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
  desc = 'ESC', silent = true
}) -- Terminal -- much easier terminal Esc

vim.keymap.set('' , '<C-z>', '<nop>', {
  desc = '', silent = true
}) -- disable C-z suspend by overriding

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

vim.keymap.set('!', '<C-n>', '<C-n>', {
  desc = 'next', silent = false
}) -- Insert, Command -- next/prev -- command, completion, etc.
vim.keymap.set('!', '<C-e>', '<C-p>', {
  desc = 'prev', silent = false
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

vim.keymap.set('v', '<', '<gv', {
  desc = 'indent selection  left', silent = true
}) -- easier moving of code blocks, without losing the selection block
vim.keymap.set('v', '>', '>gv', {
  desc = 'indent selection right', silent = true
})

vim.keymap.set('n', '<M-o>', 'mjo<Esc>`j', {
  desc = 'add blank line below cursor', silent = true
}) -- without entering insert mode (returning to the prev cursor line)
vim.keymap.set('n', '<M-O>', 'mjO<Esc>`j', {
  desc = 'add blank line above cursor', silent = true
})

--============================================================================
-- Function keys
--============================================================================

vim.keymap.set('n', '<F3>', '<cmd>TagbarToggle<CR>', {
  desc = 'TagbarToggle'
})

vim.keymap.set('n', '<F4>', '<cmd>set relativenumber!<CR>', {
  desc = 'set relativenumber!'
})

vim.keymap.set('n', '<F7>', '<cmd>setlocal spell! spelllang=en_us,ru_yo,ru_ru<CR>', {
  desc = 'spell en,ru'
}) -- toggle spell check
vim.keymap.set('n', '<F19>', '<cmd>setlocal spell! spelllang=en_us<CR>', {
  desc = 'spell en' -- S-F7
})
vim.keymap.set('n', '<F31>', '<cmd>setlocal spell! spelllang=ru_yo,ru_ru<CR>', {
  desc = 'spell ru' -- C-F7
})

vim.keymap.set('n', '<F12>', "gg=G''", {
  desc = 'fix/re-indent file' -- or only selection: V -> =
})

--============================================================================
-- extra keymaps -- leader, localleader, etc.
--============================================================================

vim.keymap.set('n', '<C-h>', function()
  local cword = vim.fn.expand('<cword>')
  local rword = vim.fn.getreg('/')
  if vim.g.hl_CWORD and rword == cword then
    vim.g.hl_CWORD = false
    vim.cmd('silent nohlsearch') -- tmp stop the highlighting
  else
    vim.g.hl_CWORD = true
    vim.o.hlsearch = true -- to auto turn on, on next search etc.
    vim.fn.setreg('/', cword)
  end
end, {
  desc = 'highlight CWORD toggle', silent = false, expr = true
}) -- toggle highlight of word under the cursor

vim.keymap.set('n', '<Leader>q', '<cmd>Bdelete<CR>', {
  desc = 'Bdelete',  silent = true
}) -- 'moll/vim-bbye' plugin mappings
vim.keymap.set('n', '<Leader>w', '<cmd>Bwipeout<CR>', {
  desc = 'Bwipeout', silent = true
})

vim.keymap.set('n', '<localleader>b', '<cmd>call BgToggle()<CR>', {
  desc = 'BgToggle()', silent = true
}) -- toggle between background transparency

vim.keymap.set('n', '<localleader>ct', '<cmd>call ColumnToggle()<CR>', {
  desc = 'ColumnToggle()', silent = true
}) -- toggle colored column at lines which character length exceed N

vim.keymap.set('n', '<localleader>ww', ':%s/\\s\\+$//gc ', {
  desc = 'ws trim substitute'
}) -- trim trailing whitespace using substitute cmd

-- CDC = Change to Directory of Current file [[ command CDC cd %:p:h ]]
vim.api.nvim_create_user_command('CDC', "cd %:p:h", {})

-- TODO: how to reload lazy.nvim config?
-- " Reload vim configuration (old)
-- nnoremap <localleader>rc <cmd>ReloadConfig<CR>
