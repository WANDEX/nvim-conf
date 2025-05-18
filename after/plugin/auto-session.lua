-- configuration for the plugin "rmagatti/auto-session"

local aus_ok, aus = pcall(require, 'auto-session')
if not aus_ok then
  return
end

-- Recommended sessionoptions config
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

---enables autocomplete for opts
---@module "auto-session"
---@type AutoSession.Config
aus.setup({
  enabled = true,
  root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_save = true,
  auto_restore = true,
  auto_create = false,
  log_level = "error",

  session_lens = {
    previewer = false,
    path_display = { "shorten" },
    theme_conf = { border = false },
  },
})

