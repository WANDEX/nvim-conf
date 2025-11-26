-- AUTHOR: 'WANDEX/nvim-conf'
-- user snippets for all file types

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

-- local fn = require('user.lib.fn')

local ft_comment_str = function(comment_str)
  comment_str = comment_str or '' -- vim.bo.commentstring == '-- %s'
  return string.gsub(vim.bo.commentstring, " %%s", comment_str)
end

return {

  -- TODO: take user/repo from .git config - remote
  s("AUTHOR", fmt("{} AUTHOR: '{}'\n", {
    f(function() return ft_comment_str() end),
    i(2, "WANDEX/nvim-conf"),
  })),

  -- date: 2025-08-12 13:37:30 UTC
  s({ trig = "date" }, {
    f(function()
      return string.format(
        ft_comment_str(" date: %%s"), os.date("!%F %T UTC")
      )
    end),
  }),

}
