-- configuration for the plugin "rmagatti/auto-session" & "rmagatti/session-lens"

local aus_ok, aus = pcall(require, 'auto-session')
if not aus_ok then
  return
end

local aul_ok, aul = pcall(require, 'session-lens')
if not aul_ok then
  return
end

-- Recommended sessionoptions config
vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

local opts = {
  log_level = 'info',
  auto_session_enable_last_session = false,
  auto_session_root_dir = vim.fn.stdpath('data').."/aus/",
  auto_session_enabled = true,
  auto_save_enabled = false,
  auto_restore_enabled = true,
  -- auto_session_allowed_dirs = ["list", "of paths"],
  -- auto_session_suppress_dirs = ["list", "of paths"],
}

aus.setup(opts)

aul.setup {
  path_display = {'shorten'},
  theme_conf = { winblend = 0, border = true },
  previewer = false
}
