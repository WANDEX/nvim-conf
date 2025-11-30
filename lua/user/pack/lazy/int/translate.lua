-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'voldikss/vim-translator' (viml+python plugin)

return {
  'voldikss/vim-translator',
  lazy = false,
  init = function()
    vim.g.translator_target_lang = 'ru'
    vim.g.translator_source_lang = 'en'
    vim.g.translator_default_engines = { 'google', 'bing' }
  end,
  keys = {
    { mode = "v", "<leader>t",   "", desc = "trans" }, -- group annotation
    { mode = "v", "<leader>t!r", ":'<,'>TranslateR!<CR>", desc = "replace" },
    { mode = "v", "<leader>t!w", ":'<,'>TranslateW!<CR>", desc = "window"  },
    { mode = "v", "<leader>tr",  ":'<,'>TranslateR<CR>",  desc = "replace" },
    { mode = "v", "<leader>tw",  ":'<,'>TranslateW<CR>",  desc = "window"  },

    { mode = "n", "<leader>t",   "", desc = "trans" }, -- group annotation
    { mode = "n", "<leader>t!l", "<cmd>normal V<CR> | :'<,'>TranslateW!<CR>", desc = "line" },
    { mode = "n", "<leader>t!r", "<cmd>normal V<CR> | :'<,'>TranslateR!<CR>", desc = "replace line" },
    { mode = "n", "<leader>t!w", "<cmd>TranslateW!<CR>",                      desc = "word" },
    { mode = "n", "<leader>tl",  "<cmd>normal V<CR> | :'<,'>TranslateW<CR>",  desc = "line" },
    { mode = "n", "<leader>tr",  "<cmd>normal V<CR> | :'<,'>TranslateR<CR>",  desc = "replace line" },
    { mode = "n", "<leader>tw",  "<cmd>TranslateW<CR>",                       desc = "word" },
  },
}
