local ls = require "luasnip"
ls.filetype_extend("c", { "cpp" }) -- to have the same snippets in ft=c

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local fmt  = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

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
    nl(" * @brief "),
    i(1, "description"),
    nl(" *"),
    nl(" * @param  TODO"),
    nl(" * @return TODO"),
    nl(" */"),
  }),
})

-- /****************************************************************************
--  * description / separator
--  */
ls.add_snippets("cpp", {
  s("docl", {
    nl("/****************************************************************************"),
    nl(" * "),
    i(1, "description / separator"),
    nl(" */"),
  }),
})

ls.add_snippets("cpp", {
  s("#pro", fmt("{}\n\n", { i(1, "#pragma once") })),
})

ls.add_snippets("cpp", {
  s("#in", fmt("{} <{}>\n", { t("#include"), i(1) })),
})

ls.add_snippets("cpp", {
  s("ns",  fmta([[
  namespace <name> {
  <inside>
  } // namespace <name>
  ]], {
    name   = i(1),
    inside = i(2),
  }, { repeat_duplicates = true })),

  -- v1, v2, etc.
  s("nsi",  fmta([[
  inline namespace v<name> {
  <inside>
  } // inline namespace v<name>
  ]], {
    name   = i(1),
    inside = i(2),
  }, { repeat_duplicates = true })),

  s("nsa",  {
    nl("namespace /* (anonymous) */ {"),
    nl(""), i(1),
    nl("} // (anonymous) [internal_linkage]"),
    nl(""),
  }),
})

ls.add_snippets("cpp", {
  s({trig="s", hidden=true}, { t("std::") }),
  s('st',   { t("std::") }),
  s("sv",   { t("std::string_view ") }),
  s("sz",   { t("std::size_t ") }),
  s("szc",  { t("const std::size_t ") }),
})

ls.add_snippets("cpp", {
  s({trig="c", hidden=true}, { t("const ") }),
  s("co",   { t("std::cout << "), i(1), t(" << '\\n';") }),
  s("ce",   { t("std::cerr << "), i(1), t(" << '\\n';") }),
})
