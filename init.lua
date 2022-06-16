-- XXX: impatient.nvim will only be required until https://github.com/neovim/neovim/pull/15436 is merged
if not pcall(require, 'impatient') then
  print 'failed to load impatient.nvim'
end

require 'user.profile'

if require 'user.first_load'() then
  return
end

-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- Leader key - <SPACE>
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.python3_host_prog = '/usr/bin/python'

-- I set some global variables to use as configuration throughout my config.
-- These don't have any special meaning.
vim.g.snippets = 'luasnip'

-- Setup globals that I expect to be always available.
--  See `./lua/user/globals/*.lua` for more information.
require 'user.globals'

-- Turn off builtin plugins I do not use.
require 'user.disable_builtin'

require 'user.pack.plugins'

require 'user.diagnostic'

require 'user.func'

require 'user.stat.nerv'
