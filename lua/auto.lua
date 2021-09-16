-- auto.lua
-- autogroups and autocommands

-- run PackerCompile command every time when any of the nvim/lua/* config files are written
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */nvim/lua/* source <afile> | PackerCompile
  augroup end
]])

