-- auto.lua
-- autogroups and autocommands

-- run PackerCompile command every time when any of the nvim/lua/* config files are written
vim.cmd([[au BufWritePost */nvim/lua/* so <afile> | PackerCompile]])

