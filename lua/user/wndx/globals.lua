-- AUTHOR: 'WANDEX/nvim-conf'
--
-- :Lazy reload lazy.nvim
-- ^preferred way of reloading plugins
-- is by using your plugin manager functionality!

P = function(v)
  print(vim.inspect(v))
  return v
end
