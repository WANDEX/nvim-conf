local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local nl = function(text) -- new line
  return t { "", text }
end


-- /**
--  * doc string
--  */
ls.add_snippets("cpp", {
  -- s("doc", fmt("\n\n/**\n * {}\n */", { i(1, "doc string") })),
  -- the same
  s("doc", {
    nl("/**"),
    nl(" * "),
    i(1, "doc string"),
    nl(" */"),
  }),
})
