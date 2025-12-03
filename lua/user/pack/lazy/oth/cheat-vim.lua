-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'dbeniamine/cheat.sh-vim' (viml plugin)
--
-- XXX: currently does not work even with default mappings...
-- Some modifications needed, dunno what is wrong.

local M = {}

function M.opts_defaults()
  ---Vim command used to open new buffer
  vim.g.CheatSheetReaderCmd             = vim.g.CheatSheetReaderCmd             or 'new"'
  ---Cheat sheet file type
  vim.g.CheatSheetFt                    = vim.g.CheatSheetFt                    or 'markdown'
  ---Program used to retrieve cheat sheet with its arguments
  vim.g.CheatSheetUrlGetter             = vim.g.CheatSheetUrlGetter             or 'curl --silent'
  ---Flag to add cookie file to the query
  vim.g.CheatSheetUrlGetterIdFlag       = vim.g.CheatSheetUrlGetterIdFlag       or '-b'
  ---cheat sheet base url
  vim.g.CheatSheetBaseUrl               = vim.g.CheatSheetBaseUrl               or 'https://cht.sh'
  ---cheat sheet settings do not include style settings neiter comments,
  ---see other options below
  vim.g.CheatSheetUrlSettings           = vim.g.CheatSheetUrlSettings           or 'q'
  ---cheat sheet pager
  vim.g.CheatPager                      = vim.g.CheatPager                      or 'less -R'
  ---pygmentize theme used for pager output, see :CheatPager :styles-demo
  vim.g.CheatSheetPagerStyle            = vim.g.CheatSheetPagerStyle            or 'rrt'
  ---Show comments in answers by default
  ---(setting this to 0 means giving ?Q to the server)
  vim.g.CheatSheetShowCommentsByDefault = vim.g.CheatSheetShowCommentsByDefault or 1
  ---Stay in origin buffer (set to 0 to keep focus on the cheat sheet buffer)
  vim.g.CheatSheetStayInOrigBuf         = vim.g.CheatSheetStayInOrigBuf         or 1
  ---cheat sheet buffer name
  vim.g.CheatSheetBufferName            = vim.g.CheatSheetBufferName            or '_cheat'
  ---Default selection in normal mode (line for whole line, word for word under cursor)
  vim.g.CheatSheetDefaultSelection      = vim.g.CheatSheetDefaultSelection      or 'line'
  ---Default query mode
  ---0 => buffer
  ---1 => replace (do not use or you might loose some lines of code)
  ---2 => pager
  ---3 => paste after query
  ---4 => paste before query
  vim.g.CheatSheetDefaultMode           = vim.g.CheatSheetDefaultMode           or 0
  ---Path to cheat sheet cookie
  vim.g.CheatSheetIdPath                = vim.g.CheatSheetIdPath                or vim.fn.expand('~/.cht.sh/id')
  ---Make plugin silent by  setting bellow variable to 1
  vim.g.CheatSheetSilent                = vim.g.CheatSheetSilent                or 0
  ---
  ---FOLLOWING LINES ARE THE EXTRA, THEY ARE NOT DEFINED BY DEFAULT. (ADDED BY WNDX FOR CONSISTENCY)
  ---
  ---Disable default mappings (see plugin/cheat.vim to redo the mappings manually)
  vim.g.CheatSheetDoNotMap              = vim.g.CheatSheetDoNotMap              or 0
  ---Disable the replacement of man by cheat sheets
  vim.g.CheatDoNotReplaceKeywordPrg     = vim.g.CheatDoNotReplaceKeywordPrg     or 0
  ---Framework detection can slow down vim opening see #54 so it has been disabled by default.
  vim.g.CheatSheetDisableFrameworkDetection = vim.g.CheatSheetDisableFrameworkDetection or 1
end

function M.opts()
  vim.g.CheatSheetDoNotMap = 1
  vim.g.CheatDoNotReplaceKeywordPrg = 1
  vim.g.CheatSheetDisableFrameworkDetection = 1
  vim.g.CheatSheetIdPath = vim.fn.expand('$CHTSH/id')
  vim.g.CheatSheetReaderCmd = 'vnew'
end

function M.map_keys()
  vim.keymap.set({'n', 'v'}, '<leader>C', '', { desc = 'Cheat' }) -- group annotation
  vim.keymap.set({'n', 'v'}, '<leader>Cc', '<cmd>Cheat<CR>',        { desc = 'cheat'    })
  vim.keymap.set({'n', 'v'}, '<leader>CE', '<cmd>CheatError<CR>',   { desc = 'Error'    })
  vim.keymap.set({'n', 'v'}, '<leader>Cp', '<cmd>CheatPaste<CR>',   { desc = 'paste'    })
  vim.keymap.set({'n', 'v'}, '<leader>Cr', '<cmd>CheatReplace<CR>', { desc = 'replace'  })
  -- vim.keymap.set({'n', 'v'}, '<leader>CP', '<cmd>CheatPager<CR>',{ desc = 'Pager' }) -- nvim not supported
end

M.spec = {
  'dbeniamine/cheat.sh-vim',
  enabled = true,
  lazy = false,
  init = function()
    M.opts()
    M.opts_defaults()
    M.map_keys()
  end,
}

return M.spec
