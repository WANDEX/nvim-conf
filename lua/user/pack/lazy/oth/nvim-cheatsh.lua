-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'siawkz/nvim-cheatsh'
--
-- see also:
--
-- plenary.curl example:
-- https://github.com/DavidAEriksson/cheat.nvim/blob/main/lua/cheat/curl.lua
--
-- direct link on commit:
-- https://github.com/siawkz/nvim-cheatsh/tree/449f5b59b90426c4e5c34e97999b91268c0e46f5

return {
  'siawkz/nvim-cheatsh',
  lazy = false,
  ---last commit with telescope support, next versions for fzf-lua
  commit = '449f5b59b90426c4e5c34e97999b91268c0e46f5',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  opts = {
    cheatsh_url = 'https://cht.sh/', -- URL of the cheat.sh instance to use, support self-hosted instances
    position = 'right', -- position of the window can be: bottom, top, left, right
    height = 20, -- height of the cheat when position is top or bottom
    width = 100, -- width of the cheat when position is left or right
  },
  keys = {
    { mode = 'n', '<leader>LC', '<cmd>CheatList<CR>', desc = 'CheatList' },
  },
}
