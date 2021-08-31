-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local use = require('packer').use
require('packer').startup(function()
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}
end)

