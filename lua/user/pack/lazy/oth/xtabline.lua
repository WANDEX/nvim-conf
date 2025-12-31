-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mg979/vim-xtabline' (viml plugin)

local M = {}

function M.opts()
  vim.g.xtabline_settings = vim.tbl_deep_extend('force', vim.g.xtabline_settings or {}, {
    enable_mappings = 0,
    buffer_filtering = 1,
    buffers_paths = 1,
    current_tab_paths = -8,
    other_tabs_paths = 0,
    show_right_corner = 1,
    tabline_modes = { 'buffers', 'tabs', }, -- buffers mode by default, without arglist mode
    tab_number_in_left_corner = 0,
    last_open_first = 1,
    recent_buffers = 14,
    wd_type_indicator = 1,
    tab_icon = { " ", " " },
    indicators = { modified='', pinned='' },
    icons = {
      book='󰂺 ',
      build='󰦑 ',
      check=' ',
      cog=' ',
      cogs=' ',
      cross=' ',
      database='󰆼 ',
      exclamatio='󱈸 ',
      finish=' ',
      fire='󰈸 ',
      flag=' ',
      git=' ',
      hammer='󰣪 ',
      lens=' ',
      lightning=' ',
      linux=' ',
      lock=' ',
      palette='󰏘 ',
      pin=' ',
      star=' ',
      warning=' ',
      windows=' ',
      wrench='󰖷 ',
    },
  })
end

M.spec = {
  'mg979/vim-xtabline',
  enabled = true,
  lazy = false,
  init = function()
    vim.g.xtabline_lazy = 0
    M.opts()
  end,
  -- keys = {
  --   { mode = "n", "<leader>x",  "", desc = "xtab" }, -- group annotation
  --   { mode = "n", "<leader>xb", "", desc = "buf"  }, -- group annotation
  --   { mode = "n", "<leader>xs", "", desc = "ses"  }, -- group annotation
  --   { mode = "n", "<leader>xt", "", desc = "tab"  }, -- group annotation
  -- },
}

return M.spec
