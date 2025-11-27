-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mg979/vim-xtabline' (viml plugin)

local M = {}

function M.init()
  vim.cmd[[
  let g:xtabline_settings = get(g:, 'xtabline_settings', {})
  let g:xtabline_settings.enable_mappings = 0
  "" buffers mode by default, without arglist mode
  let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']
  let g:xtabline_settings.tab_number_in_left_corner = 0
  let g:xtabline_settings.last_open_first = 1
  let g:xtabline_settings.recent_buffers = 14
  let g:xtabline_settings.wd_type_indicator = 1
  let g:xtabline_settings.tab_icon = [" ", " "]
  let g:xtabline_settings.indicators = {
    \ 'modified': ' ',
    \ 'pinned': ' ',
    \ }
  let g:xtabline_settings.icons = {
    \ 'book': '󰂺 ',
    \ 'build': '󰦑 ',
    \ 'check': ' ',
    \ 'cog': ' ',
    \ 'cogs': ' ',
    \ 'cross': ' ',
    \ 'database': '󰆼 ',
    \ 'exclamation': '󱈸 ',
    \ 'finish': ' ',
    \ 'fire': '󰈸 ',
    \ 'flag': ' ',
    \ 'git': ' ',
    \ 'hammer': '󰣪 ',
    \ 'lens': ' ',
    \ 'lightning': ' ',
    \ 'linux': ' ',
    \ 'lock': ' ',
    \ 'palette': '󰏘 ',
    \ 'pin': ' ',
    \ 'star': ' ',
    \ 'warning': ' ',
    \ 'windows': ' ',
    \ 'wrench': '󰖷 ',
    \ }
  ]]
end

function M.setup()
  M.init()
  vim.cmd[[
  let g:xtabline_lazy = 0
  ]]
end

M.spec = {
  'mg979/vim-xtabline',
  enabled = true,
  lazy = false,
  config = M.setup(),
  -- keys = {
  --   { mode = "n", "<leader>x",  "", desc = "xtab" }, -- group annotation
  --   { mode = "n", "<leader>xb", "", desc = "buf"  }, -- group annotation
  --   { mode = "n", "<leader>xs", "", desc = "ses"  }, -- group annotation
  --   { mode = "n", "<leader>xt", "", desc = "tab"  }, -- group annotation
  -- },
}

return M.spec
