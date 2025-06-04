-- AUTHOR: 'WANDEX/nvim-conf'

require 'user.profile'

if require 'user.first_load'() then
  return
end

-- good idea to set following early in the config, because otherwise
-- any mappings set BEFORE doing this, will be set to the OLD Leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.python3_host_prog = '/usr/bin/python'

-- set some global variables to use as configuration throughout the config.
-- these do not have any special meaning.
vim.g.snippets = 'luasnip'

require 'user.globals' -- setup globals expected to be always available.

require 'user.disable_builtin' -- turn off built-in plugins I do not use.

require 'user.diagnostic'

require('lazy').setup({
  root   = vim.fn.stdpath("data") .. "/pack/lazy", -- dir for plugins
  rocks  = {
    root = vim.fn.stdpath("data") .. "/pack/lazy/lazy-rocks",
  },
  spec = {
    { import = 'user.pack' },
  },
})

require 'user.func'
