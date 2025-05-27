local lazy_path = function()
  return vim.fn.stdpath("data") .. "/pack/lazy/lazy.nvim"
end

-- bootstrap lazy.nvim
local download_lazy_nvim = function()
  if vim.fn.input "Download lazy.nvim? (y for yes): " ~= "y" then
    return
  end
  local lazypath = lazy_path()
  vim.fn.mkdir(vim.fs.dirname(lazypath), "p")
  if not vim.uv.fs_stat(lazypath) then
    print("\nDownloading lazy.nvim...\n")
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    -- print(out)
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
    vim.cmd([[qa]])
  end
  vim.opt.rtp:prepend(lazypath)
end

return function()
  vim.opt.rtp:prepend(lazy_path())
  if not pcall(require, "lazy") then
    download_lazy_nvim()
    return true
  end
  return false
end
