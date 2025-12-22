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
