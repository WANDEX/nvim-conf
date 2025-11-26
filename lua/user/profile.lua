-- AUTHOR: 'WANDEX/nvim-conf'
--
-- see: 'jonhoo/inferno' - (flamegraph format)
-- src: https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file#plenaryprofile
--
-- $ inferno-flamegraph /tmp/nvim_flamegraph.log > nvim_flamegraph.svg

if true then
  vim.notify('plenary.profile flamegraph enabled!', vim.log.levels.WARN)
  --- make plenary module discoverable for require, even before package manager kicks in.
  local plenary_dir = require('user.lib.fn').path.concat({
    vim.fn.stdpath('data'), 'pack', 'lazy', 'plenary.nvim', 'lua'
  })
  package.path = plenary_dir .. '/?.lua;' .. package.path
  ---@diagnostic disable-next-line: param-type-mismatch
  require('plenary.profile').start('/tmp/nvim_flamegraph.log', { flame = true })
  vim.cmd [[autocmd VimLeave * lua require('plenary.profile').stop()]]
end
