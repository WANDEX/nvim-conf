-- AUTHOR: 'WANDEX/nvim-conf'

vim.api.nvim_create_autocmd('TextYankPost', {
  group    = vim.api.nvim_create_augroup('hi_on_yank', { clear = true }),
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank({ timeout=1500 })
  end,
})

--- override theme highlights with the user highlights.
vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme' }, {
  group    = vim.api.nvim_create_augroup('hi_override_wndx', { clear = true }),
  callback = require('user.wndx.hi').main,
})

--- save 'titleold' window title in builtin global variable, set 'titlestring'.
--- restores old window title if neovim finished working.
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group    = vim.api.nvim_create_augroup('win_title_upd', { clear = true }),
  callback = function()
    local upd_win_title = function(title_old)
      vim.opt.title       = true
      vim.opt.titleold    = title_old -- set this window title at nvim exit
      vim.opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'
    end -- original window title, before modification by the vim.opt.titlestring.
    local orig_title = require('user.lib.pl').get_win_title()
    if orig_title == '' then
      return
    end
    upd_win_title(orig_title)
  end,
})

vim.api.nvim_create_autocmd({ 'QuitPre' }, {
  pattern  = '*',
  group    = vim.api.nvim_create_augroup('wndx_close_locklist_quickfix', { clear = true }),
  callback = function()
    --- close the window showing the location list for the current window
    vim.cmd [[if empty(&buftype) | lclose | endif]]
    --- close the quickfix window.
    vim.cmd [[if empty(&buftype) | cclose | endif]]
  end,
})

--- supposed to be used and works only with the following options:
---  vim.opt.showcmd     = true
---  vim.opt.showcmdloc  = 'statusline'
vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
  pattern  = { '*:v', '*:V', '*:\22', '*:\22s' }, -- trigger on enter into all Visual modes.
  group    = vim.api.nvim_create_augroup('wndx_show_cmd_visual_selection', { clear = true }),
  callback = function(event)
    local echo_visual_sel = function()
      local cmd = vim.api.nvim_eval_statusline('%S', {}) -- cmd table with str content
      local pad = vim.v.echospace - cmd.width -- N whitespace padding for the right-align
      local out = string.rep(' ', pad) .. cmd.str
      vim.api.nvim_echo({ {out} }, false, {}) -- TODO find/use function which does not move cursor pos.
    end
    echo_visual_sel() -- update once right after enter or switch between the Visual modes.
    vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
      buffer   = event.buf,
      group    = event.group,
      callback = echo_visual_sel, -- update on each CursorMoved event.
    })
  end,
})

--- run xrdb whenever Xresources are updated.
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern  = { '*/.Xresources', '*/xres/*' },
  group    = vim.api.nvim_create_augroup('wndx_auto_compile_xres', { clear = true }),
  command  = '!xrdb ~/.Xresources',
})

--- run wal right after previous xrdb when this specific file is updated.
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern  = { '*/xres/core4w' },
  group    = vim.api.nvim_create_augroup('wndx_auto_compile_xres', { clear = true }),
  command  = '!wal -q -tn -i ~/.config/wallpaper.jpg',
})

--- update binds when sxhkdrc is updated.
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern  = { '*/sxhkdrc' },
  group    = vim.api.nvim_create_augroup('wndx_auto_compile_sxhkdrc', { clear = true }),
  command  = '!pkill -USR1 sxhkd',
})

--- have dwmblocks automatically recompile and run when you edit this file
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern  = { '*/dwmblocks/config.h' },
  group    = vim.api.nvim_create_augroup('wndx_auto_compile_dwmblocks', { clear = true }),
  command  =
    '!cd ~/source/projects/core/fork/dwmblocks/ && ' ..
    'make && sudo make install && ' ..
    '{ killall -q dwmblocks;setsid dwmblocks & }'
})
