-- AUTHOR: 'WANDEX/nvim-conf'

require 'user.wndx.options'
require 'user.wndx.unicode'

require 'user.wndx.globals'
require 'user.wndx.keymaps'

require 'user.pack'

require 'user.lsp' --- vim.lsp.config servers must be after pack spec

require 'user.wndx.au'
require 'user.wndx.cmd'
require 'user.wndx.hi'
