-- AUTHOR: 'WANDEX/nvim-conf'
-- user snippets for C/C++

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

local fn = require('user.fn')


ls.filetype_extend('c', { 'cpp' }) -- to have the same snippets in ft=c


return {

  -- /**
  --  * doc string
  --  */
  s("doc", {
    nl("/**"),
    nl(" * @brief "),
    i(1, "description"),
    nl(" *"),
    nl(" * @param  TODO"),
    nl(" * @return TODO"),
    nl(" */"),
  }), -- the same
  -- s("doc", fmt("\n\n/**\n * {}\n */", { i(1, "doc string") })),


  -- /****************************************************************************
  --  * description / separator
  --  */
  s("docl", {
    nl("/****************************************************************************"),
    nl(" * "),
    i(1, "description / separator"),
    nl(" */"),
  }),

  -- doc string with content from clipboard.
  s("docc",
    fmt("\n\n/**\n * {}{}\n */",
      -- NOTE: luasnip requires splitting multiline string on table of lines.
      { f(fn.get_clip_content_as_table_split_by_nl, {1}), i(1) }
    )
  ),

  s("#pro", fmt("{}\n\n", { i(1, "#pragma once") })),

  s("#in", fmt("{} <{}>\n", { t("#include"), i(1) })),

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
    nl("namespace { // (anonymous)"),
    nl(""), i(1),
    nl("} // (anonymous) [internal_linkage]"),
    nl(""),
  }),

  s({trig="s", hidden=true}, { t("std::") }),
  s('st',   { t("std::") }),
  s("sv",   { t("std::string_view ") }),
  s("sz",   { t("std::size_t ") }),
  s("szc",  { t("const std::size_t ") }),

  s({trig="c", hidden=true}, { t("const ") }),
  s("co",   { t("std::cout << "), i(1), t(" << '\\n';") }),
  s("ce",   { t("std::cerr << "), i(1), t(" << '\\n';") }),

  s("fmti", fmt([[
  #include <fmt/core.h>
  #include <fmt/format.h>
  #include <fmt/ranges.h>         // fmt::join
  {}
  ]], {
    nl(''),
  }, {})),

  s("fmtj",  fmta([[
  fmt::print(stderr, "<name>: {:>>3} : [{}]\n", <name>.size(), fmt::join(<name>, ", "));
  ]], {
    name   = i(1),
  }, { repeat_duplicates = true })),

}
