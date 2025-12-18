-- AUTHOR: 'WANDEX/nvim-conf'
-- spec fork of the 'project.nvim'

local M = {}

M.spec = {
  {
    { --- auto cd to the project root
      'airblade/vim-rooter',
      enabled = false, -- replaced by 'project.nvim'
    },
  },

  {
    -- 'ahmedkhalf/project.nvim', -- orig project repo
    'TheLeoP/project.nvim', -- fork: modern api, fixes for win os, etc.
    --- NOTE: project extension for telescope showed several project dirs.
    ---       Some of those projects were created temporarily, then directories were deleted.
    ---       Maybe nvim hanged because of the not existing directories?
    -- event = 'VeryLazy', -- XXX: maybe plugin hanged nvim previously because of this & loading order?
    -- enabled = false, -- FIXME: try to disable plugin if nvim hangs at startup! (I encountered this!)
    opts = {
      -- manual_mode = true, --- XXX: auto mode sometimes causes nvim inf hang at startup?
      silent_chdir = false, --- message when project.nvim changes dir.
      --- all the patterns used to detect root dir,
      --- when **'pattern'** is in detection_methods
      patterns = {
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
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)

      -- local history = require('project_nvim.utils.history')
      -- history.delete_project = function(project)
      --   for k, v in pairs(history.recent_projects) do
      --     if v == project.value then
      --       history.recent_projects[k] = nil
      --       return
      --     end
      --   end
      -- end

    end,
  },
}

return M.spec
