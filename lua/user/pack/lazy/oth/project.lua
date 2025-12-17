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
    'TheLeoP/project.nvim', -- fork: modern api, win fixes, etc.
    opts = {
      -- manual_mode = true,
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
    event = 'VeryLazy',
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
