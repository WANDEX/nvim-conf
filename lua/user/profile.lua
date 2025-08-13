-- AUTHOR: 'WANDEX/nvim-conf'

PROFILE_LOAD = false

if PROFILE_LOAD then -- see: 'jonhoo/inferno' - (flamegraph format)
  require("plenary.profile").start("/tmp/nvim_flamegraph.log", { flame = true })
  vim.cmd [[autocmd VimLeave * lua require("plenary.profile").stop()]]
end
