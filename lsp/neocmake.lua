-- https://github.com/neocmakelsp/neocmakelsp

return {
  -- cmd = { 'neocmakelsp', 'stdio' }, -- fix: stdio command not --stdio!
  -- filetypes = { 'cmake' },
  -- on_attach = on_attach, -- on_attach is the on_attach function you defined
  single_file_support = true,-- suggested
  init_options = {
    format = {
      enable = false,
    },
    lint = {
      enable = true,
    },
    --- it will deeply check the cmake file which found when search cmake packages.
    scan_cmake_in_package = true,
    --- semantic_token heighlight. if you use treesitter highlight, it is suggested to set with false.
    --- it can be used to make better highlight for vscode which only has textmate highlight
    semantic_token = false,
  },
}
