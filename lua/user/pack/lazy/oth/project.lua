-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'TheLeoP/project.nvim' -- fork of the 'project.nvim'.
-- to integrate with telescope -- local fork of telescope projects extension was made.
--
-- orig project 'ahmedkhalf/project.nvim' is obsolete:
-- - can hang nvim if selector history has not existing project dir! (I encountered this!)
-- - does not properly cd to the project dir on windows os (at least)
-- - does not support modern vim api (has deprecated functions)
-- - does not contain other valuable fixes made in the fork

local M = {}

M.spec = {
  {
    { --- auto cd to the project root
      'airblade/vim-rooter',
      enabled = false, -- replaced by 'project.nvim'
    },
  },

  {
    'TheLeoP/project.nvim', -- project.nvim fork: modern api, fixes for win os, etc.
    -- commit = '42edfb4d4a914930563cea1913c0d229bb6b6292',
    event = { 'VeryLazy' }, -- XXX: maybe plugin hanged nvim previously because of this & loading order?
    -- enabled = false, -- FIXME: try to disable plugin if nvim hangs at startup!
    opts = {
      -- manual_mode = true,
      silent_chdir = false, --- message when project.nvim changes dir.
      patterns = { --- patterns used to detect root dir, when pattern is in detection_methods!
        '.bzr',
        '.git',
        '.hg',
        '.svn',
        'Makefile',
        '_darcs',
        'build',
        'cmake',
        'package.json',
      },
      ignore_lsp = {
        'dockerls',
        'kulala',
        'lemminx',
      },
      scope_chdir = 'tab', --- what scope to change the directory: global, tab, win
      ---@type boolean|fun(prompt_bufnr: number): boolean
      find_files = false, --- call find_files on project selection
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
}

return M.spec
