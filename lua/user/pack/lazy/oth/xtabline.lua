-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mg979/vim-xtabline' (viml plugin)

local M = {}

function M.opts()
  vim.g.xtabline_settings = vim.g.xtabline_settings or {}
  vim.g.xtabline_settings = {
    enable_mappings = 0,
    -- buffers mode by default, without arglist mode
    tabline_modes = { 'buffers', 'tabs' },
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
  }
  return vim.g.xtabline_settings
end

M.spec = {
  'mg979/vim-xtabline',
  enabled = true,
  lazy = false,
  init = function()
    -- vim.cmd('silent! XTablineInit')
    vim.g.xtabline_lazy = 0
    return M.opts()
  end,
  -- keys = {
  --   { mode = "n", "<leader>x",  "", desc = "xtab" }, -- group annotation
  --   { mode = "n", "<leader>xb", "", desc = "buf"  }, -- group annotation
  --   { mode = "n", "<leader>xs", "", desc = "ses"  }, -- group annotation
  --   { mode = "n", "<leader>xt", "", desc = "tab"  }, -- group annotation
  -- },
}

return M.spec
