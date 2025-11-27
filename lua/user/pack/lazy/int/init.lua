-- AUTHOR: 'WANDEX/nvim-conf'
-- interactivity related plugins

return {

  { -- wipe/delete buffers without closing windows or messing up layout.
    'moll/vim-bbye',
    lazy = false,
    keys = {
      {
        mode = 'n', '<Leader>q', '<cmd>Bdelete<CR>',
        desc = 'Bdelete',  silent = true
      },
      {
        mode = 'n', '<Leader>w', '<cmd>Bwipeout<CR>',
        desc = 'Bwipeout', silent = true
      },
    },
  },

  { -- toggle alternate values (0/1, true/false, etc.)
    'rmagatti/alternate-toggler',
    lazy = false,
    opts = {
      alternates = {
        ["ON"] = "OFF",
        ["On"] = "Off",
        ["on"] = "off",
      },
    },
    config = true,
  },

}
