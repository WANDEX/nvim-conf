-- AUTHOR: 'WANDEX/nvim-conf'

vim.api.nvim_create_autocmd('TextYankPost', {
  group    = vim.api.nvim_create_augroup('override_hi', { clear = true }),
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank({ timeout=1500 })
  end,
})

-- save 'titleold' window title in builtin global variable, set 'titlestring'.
vim.api.nvim_create_autocmd('VimEnter', {
  group    = vim.api.nvim_create_augroup('win_title_upd', { clear = true }),
  pattern  = '*',
  callback = function()
    local upd_win_title = function(title_old)
      vim.opt.title       = true
      vim.opt.titleold    = title_old -- set this window title at nvim exit
      vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
    end
    -- TODO: create similar function: wayland_get_win_title()
    local xorg_get_win_title = function()
      local ok_id, win_id = pcall(vim.fn.system, { 'xdotool', 'getactivewindow' })
      if not ok_id then
        return ''
      end
      local ok_name, win_wm_name = pcall(vim.fn.system, { 'xprop', '-id', win_id, 'WM_NAME' })
      if not ok_name then
        return ''
      end -- original window title, before modification by the vim.opt.titlestring.
      return require('user.fn').split_by(win_wm_name, ' = "')[2]
    end
    local orig_title = ''
    orig_title = xorg_get_win_title()
    if orig_title == '' then
      return
    end
    upd_win_title(orig_title)
  end,
})
