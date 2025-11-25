-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mfussenegger/nvim-lint'
--
-- MEMO: install linters via :Mason 'mason-org/mason.nvim'

return {
  'mfussenegger/nvim-lint',
  lazy = false,
  opts = {
    ---@type table<string, string[]>
    linters_by_ft = {
      -- c           = { 'cpplint' },
      cmake       = { 'cmakelint' },
      -- cpp         = { 'clangtidy', 'cpplint' },
      cpp         = { 'clangtidy' },
      bash        = { 'shellcheck' },
      sh          = { 'shellcheck' },
      python      = { 'ruff' },
    },
  },
  config = function(_, opts)
    -- setup - plugin does not have setup() function!
    require('lint').linters_by_ft = opts.linters_by_ft
    -- vim.api.nvim_create_autocmd({ 'BufWritePost' }, { -- InsertLeave or TextChanged
    -- vim.api.nvim_create_autocmd({ 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'BufWritePost' }, {
      pattern = '*',
      group = vim.api.nvim_create_augroup('custom-lint', {}),
      -- callback = function(args)
      --   local ft = vim.bo.filetype
      --   local bufnr = args.buf
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
