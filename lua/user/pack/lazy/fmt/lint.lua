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
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      pattern = '*',
      group = vim.api.nvim_create_augroup('custom-lint', { clear = true }),
      callback = function()
        if not vim.bo.modifiable then return end -- guard
        local ft = vim.bo.filetype
        local linters = opts.linters_by_ft[ft] ---@type string[]
        if linters == nil then -- guard - linters were not specified for the ft
          return
        end
        local at_path = require('user.lib.fn').at_path
        local err_cnt = 0
        for idx, linter in pairs(linters) do
          if not at_path(linter) then
            err_cnt = err_cnt + 1
            vim.notify(string.format("[lint]: linter[%d]='%s' not found at $PATH!", idx, linter),
              -- vim.log.levels.WARN
              vim.log.levels.INFO
            )
          end
        end
        if err_cnt then -- linter was not found at_path
          return
        end
        require('lint').try_lint()
      end,
    })
  end,
}
