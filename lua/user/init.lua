-- AUTHOR: 'WANDEX/nvim-conf'

require 'user.options'
require 'user.keymaps'

require 'user.globals' -- setup globals expected to be always available.

require 'user.lsp'

require('user.lazy').load({
  profiling = {
    -- loader = true,  -- debug tab extra stats: loader cache + package.loaders.
    -- require = true, -- track each new require in the Lazy profiling tab
  },
})

require 'user.au'
require 'user.cmd'
require 'user.hi'
