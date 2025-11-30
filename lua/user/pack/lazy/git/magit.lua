-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'jreybert/vimagit' (viml plugin)

local M = {}

--- with it's defaults, plugin initializes more properly - without noticeable lock/freeze.
--- otherwise waits and initializes with noticeable lock/freeze.
--- converted to lua from original plugin file src: 'vimagit/autoload/magit/mapping.vim'
function M.opts_defaults()
  vim.g.magit_stage_file_mapping     = vim.g.magit_stage_file_mapping     or 'F'
  vim.g.magit_stage_hunk_mapping     = vim.g.magit_stage_hunk_mapping     or 'S'
  vim.g.magit_stage_line_mapping     = vim.g.magit_stage_line_mapping     or 'L'
  vim.g.magit_mark_line_mapping      = vim.g.magit_mark_line_mapping      or 'M'
  vim.g.magit_commit_mapping         = vim.g.magit_commit_mapping         or 'CC'
  vim.g.magit_commit_amend_mapping   = vim.g.magit_commit_amend_mapping   or 'CA'
  vim.g.magit_commit_fixup_mapping   = vim.g.magit_commit_fixup_mapping   or 'CF'
  vim.g.magit_close_commit_mapping   = vim.g.magit_close_commit_mapping   or 'CU'
  vim.g.magit_reload_mapping         = vim.g.magit_reload_mapping         or 'R'
  vim.g.magit_edit_mapping           = vim.g.magit_edit_mapping           or 'E'

  vim.g.magit_jump_next_hunk         = vim.g.magit_jump_next_hunk         or '<C-N>'
  vim.g.magit_jump_prev_hunk         = vim.g.magit_jump_prev_hunk         or '<C-P>'

  vim.g.magit_ignore_mapping         = vim.g.magit_ignore_mapping         or 'I'
  vim.g.magit_discard_hunk_mapping   = vim.g.magit_discard_hunk_mapping   or 'DDD'

  vim.g.magit_close_mapping          = vim.g.magit_close_mapping          or 'q'
  vim.g.magit_toggle_help_mapping    = vim.g.magit_toggle_help_mapping    or '?'

  vim.g.magit_diff_shrink            = vim.g.magit_diff_shrink            or '-'
  vim.g.magit_diff_enlarge           = vim.g.magit_diff_enlarge           or '+'
  vim.g.magit_diff_reset             = vim.g.magit_diff_reset             or '0'

  vim.g.magit_folding_toggle_mapping = vim.g.magit_folding_toggle_mapping or { '<CR>' }
  vim.g.magit_folding_open_mapping   = vim.g.magit_folding_open_mapping   or { 'zo', 'zO' }
  vim.g.magit_folding_close_mapping  = vim.g.magit_folding_close_mapping  or { 'zc', 'zC' }
end

function M.opts()
  vim.g.magit_show_magit_mapping = '<nop>'
  vim.g.magit_edit_mapping   = 'O' --- redefining E-edit -> O-open
  -- vim.g.magit_jump_next_hunk = '<C-n>'
  -- vim.g.magit_jump_prev_hunk = '<C-e>'
  vim.g.magit_jump_next_hunk = '<nop>'
  vim.g.magit_jump_prev_hunk = '<nop>'

  -- vim.g.magit_folding_toggle_mapping = { '<CR>' } -- original
  vim.g.magit_folding_toggle_mapping = { '<C-O>', '<C-Z>' }

  vim.g.magit_commit_title_limit = 69
  vim.g.magit_scrolloff = 5
  vim.g.magit_refresh_gitgutter = 0
  vim.g.magit_default_fold_level = 1
end

--- lol I cant even believe that I wrote this, long time ago...
--- old viml way of making buffer/ft local macro/mapping was...

-- function M.viml_buffer_local_mappings()
--   vim.cmd[[
--   aug custom_magit_mappings
--     au!
--     "" regex to match magit items: (modified, untracked, added, new dir, etc.) \C = :noignorecase
--     " au FileType magit let g:magit_item_regex = '^\(\C[a-z]\+.[a-z]\+\): \(.\{-\}\)\%( -> .*\)\?$'
--
--     "" go to next magit item (without folding/unfolding of a hunk)
--     " au FileType magit nnoremap <buffer><nowait> gn
--     " \ <cmd>let ln = search(g:magit_item_regex, 'wn')<CR> <cmd>call cursor(ln, 1)<CR>
--
--     "" go to Commit message
--     " au FileType magit nnoremap <buffer><nowait> gc
--     " \ <cmd>/Commit message\n=<CR> <cmd>CLS<CR> <cmd>exe 'normal }'<CR>
--
--     "" go to Staged changes
--     " au FileType magit nnoremap <buffer><nowait> gs
--     " \ <cmd>/Staged changes\n=<CR> <cmd>CLS<CR> <cmd>exe 'normal }'<CR>
--
--     "" go to Unstaged changes
--     " au FileType magit nnoremap <buffer><nowait> gu
--     " \ <cmd>/Unstaged changes\n=<CR> <cmd>CLS<CR> <cmd>exe 'normal }'<CR>
--
--     "" go to Head line in Info and put cursor at the beginning of commit message
--     "" au FileType magit nnoremap <buffer><nowait> gh
--     "" \ <cmd>exe 'normal gg'<CR> <cmd>/Head:<CR> <cmd>CLS<CR> <cmd>exe 'normal 2W'<CR>
--
--     "" go to next found magit item, yank and paste [filename] in git commit message
--     "" au FileType magit nnoremap <buffer><nowait> gf
--     "" \ <cmd>let @f='['<CR> <cmd>exe 'normal gnn"FyT/'<CR> <cmd>let @f.=']'<CR>
--     "" \ <cmd>exe 'normal gce'<CR> <cmd>put F<CR>
--
--   aug END
--   ]]
-- end

--- create buffer local mapping for ft=magit.
--- wrapper: vim.keymap.set() - Defines a |mapping| of |keycodes| to a function or keycodes.
---@param mode  string|string[] -- Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@param lhs   string          -- Left-hand side  |{lhs}| of the mapping.
---@param rhs   string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param opts? vim.keymap.set.Opts
M.map = function(mode, lhs, rhs, opts)
  local def_opts = {
    buffer=true, silent=true, nowait=true, desc = '[WNDX]',
  } -- default opts if not explicitly provided
  local mrg_opts = vim.tbl_extend('force', def_opts, opts)
  mrg_opts.desc = '[WNDX] ' .. mrg_opts.desc
  -- vim.notify(string.format("fire! %s", lhs), vim.log.levels.DEBUG)
  vim.keymap.set(mode, lhs, rhs, mrg_opts)
end

--- wrapper: vim.keymap.set() - Defines a |mapping| of |keycodes| to a function or keycodes.
---@param lhs  string          -- Left-hand side  |{lhs}| of the mapping.
---@param rhs  string|function -- Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@param desc string
M.map3 = function(lhs, rhs, desc)
  M.map('n', lhs, rhs, {desc = desc})
  -- vim.cmd('CLS') -- hide search/yank highlight | XXX: does not work, why?
end

--- create buffer local mapping for ft=magit
---@param callback string|function
function M.magit_buf_local_maps_aug(callback)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("custom_magit_mappings", { clear = true }),
    pattern = "magit",
    callback = function(args)
      -- local bufnr = args.buf
      local ft = vim.bo.filetype
      if ft ~= "magit" then return end -- guard
      vim.fn.setreg('f', {}) -- clean reg
      callback()
      -- vim.cmd('CLS') -- hide search/yank highlight | XXX: does not work, why?
    end
  })
end

function M.magit_buf_local_maps()
  local str_clr_norm = "\n=<CR> <cmd>CLS<CR> <cmd>exe 'normal }'<CR>"
  -- local str_clr_norm = "\n=<CR> <cmd>exe 'normal }'<CR>"
  local fpath_re = [[[/|a-z|A-Z|\-|_|\.]\+]]
  local magit_item_re = [[^[a-z]\+: \(]]..fpath_re..[[\)$]] -- perfect
  local _go_ni='gsn'
  local _go_ne='gse'
  local _go_cm='gsc'
  local _go_sc='gss'
  local _go_uc='gsu'
  local _go_gh='gsh'

  M.map3("<C-n>", "<cmd>call magit#jump_hunk('N')<CR><cmd>normal zz<CR>", "go to next hunk and center line")
  M.map3("<C-e>", "<cmd>call magit#jump_hunk('P')<CR><cmd>normal zz<CR>", "go to prev hunk and center line")

  M.map3(_go_ni, function()
      local ln, col = vim.fn.searchpos(magit_item_re, 'wn')
      vim.fn.cursor(ln, col)
    end,
    "go to next magit item (without folding/unfolding of a hunk)"
  )
  M.map3(_go_ne, function()
      local ln, col = vim.fn.searchpos(magit_item_re, 'wne')
      vim.fn.cursor(ln, col)
    end,
    "go to next magit item end (without folding/unfolding of a hunk)"
  )
  local _cm = "Commit message"
  M.map3(_go_cm,
    "<cmd>/" .. _cm .. str_clr_norm,
    "go to " .. _cm
  )
  local _sc = "Staged changes"
  M.map3(_go_sc,
    "<cmd>/" .. _sc .. str_clr_norm,
    "go to " .. _sc
  )
  local _uc = "Unstaged changes"
  M.map3(_go_uc,
    "<cmd>/" .. _uc .. str_clr_norm,
    "go to " .. _uc
  )
  M.map3(_go_gh,
    "<cmd>exe 'normal gg'<CR> <cmd>/Head:<CR> <cmd>CLS<CR> <cmd>exe 'normal 2W'<CR>",
    "go to Head: line in Info and put cursor at the beginning of commit message"
  )

  local re_sep = '[/|\\| ]'
  M.map3("gf", function()
    local reg_f = 'f'
    vim.fn.setreg(reg_f, {}) -- clean reg
    --- yank only basename (back-search from the end)
    local macro_seq = _go_ne..'<CR>"'..reg_f..'y?'..re_sep..'<CR>'.._go_cm..'<CR>'
    vim.api.nvim_input(macro_seq)
    vim.defer_fn(function()
      local content = vim.fn.getreg(reg_f)
      --- cleanup: trim one leading c (re_sep)
      content = string.sub(content, 2, string.len(content))
      local str_res = '[' .. content .. ']'
      vim.api.nvim_put({str_res}, 'l', false, false)
    end, 20)
    end,
    "go to next magit file/item, yank and paste [filename] in git commit message"
  )
end

function M.map_keys()
  vim.keymap.set("n", "<leader>M", "", { desc = "Magit" }) -- group annotation
  vim.keymap.set("n", "<leader>Mh", "<cmd>call magit#show_magit('h')<CR>", { desc = "hrz"  })
  vim.keymap.set("n", "<leader>Mo", "<cmd>call magit#show_magit('c')<CR>", { desc = "only" })
  vim.keymap.set("n", "<leader>Mv", "<cmd>call magit#show_magit('v')<CR>", { desc = "vrt"  }) -- magit cannot unbind def mapping
end


M.spec = {
  'jreybert/vimagit', -- simple: diff, stage, commit msg
  enabled = true,
  lazy = false,
  init = function()
    M.opts()
    M.opts_defaults()
    M.magit_buf_local_maps_aug(M.magit_buf_local_maps)
    M.map_keys()
  end,
  -- keys = {
  --   { mode = "n", "<leader>M", "", desc = "Magit" }, -- group annotation
  --   { mode = "n", "<leader>Mh", "<cmd>call magit#show_magit('h')<CR>", desc = "hrz"  },
  --   { mode = "n", "<leader>Mo", "<cmd>call magit#show_magit('c')<CR>", desc = "only" },
  --   { mode = "n", "<leader>Mv", "<cmd>call magit#show_magit('v')<CR>", desc = "vrt"  }, -- magit cannot unbind def mapping
  -- },
}

return M.spec
