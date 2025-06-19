-- AUTHOR: 'WANDEX/nvim-conf'
-- user snippets

local ls = require('luasnip')

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt  = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local nl = function(text) -- new line
  return t { '', text }
end

-- local fn = require('user.fn')

return {

  -- TODO: 1 - comment string based on ft = { lua = '--', cpp = '//' }
  -- TODO: 2 - take user/repo from .git config - remote
  s("AUTHOR", fmt("{} AUTHOR: '{}'\n", {
    i(1, "--"),
    i(2, "WANDEX/nvim-conf")
  })),

}
