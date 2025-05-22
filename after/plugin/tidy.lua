-- AUTHOR: 'WANDEX/nvim-conf'
-- configuration for the plugin 'mcauley-penney/tidy.nvim'
-- trim_trailing_whitespace respecting .editorconfig rules.
-- editorconfig support is built-in neovim.

local ok, tidy = pcall(require, 'tidy')
if not ok then
  return
end

tidy.setup({
  enabled_on_save = true,
  -- variable name is misleading! Without it tidy.nvim.toggle() not works!
  provide_undefined_editorconfig_behavior = true, -- trim ws at EOF
  -- this exclude - not overrides rules defined in .editorconfig!
  filetype_exclude = { 'diff', 'markdown' },
})

-- buffer toggle trimming of whitespaces at the EOF
vim.keymap.set('n', '<localleader>we', function()
  local opts = tidy.opts
  local new_state = not opts.provide_undefined_editorconfig_behavior
  opts.provide_undefined_editorconfig_behavior = new_state
  tidy.setup(opts)
  vim.notify("ws trim at EOF = " .. string.format("%s", new_state),
    vim.log.levels.INFO, {title = "WNDX"}
  )
end, { desc = "ws toggle  at EOF buf" })

-- buffer force one-shot/manual whitespaces trim
vim.keymap.set('n', '<localleader>wf', function()
  tidy.run({trim_ws = true})
end, { desc = "ws force one-shot buf" })

-- buffer toggle trim of whitespaces + toggle built-in neovim property per buffer
vim.keymap.set('n', '<localleader>wt', function(bufnr)
  if vim.b.editorconfig.trim_trailing_whitespace == nil then
    return -- cancel => ^ variable not specified in .editorconfig
  end
  tidy.toggle()
  local be_ttw_str = string.format("%s", tidy.opts.enabled_on_save)
  require('editorconfig').properties.trim_trailing_whitespace(bufnr, be_ttw_str)
  vim.notify("trim_trailing_whitespace = " .. be_ttw_str,
    vim.log.levels.INFO, {title = "WNDX"}
  )
end, { desc = "ws toggle trim ws buf" })
