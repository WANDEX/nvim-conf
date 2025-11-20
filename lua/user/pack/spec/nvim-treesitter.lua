-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'nvim-treesitter/nvim-treesitter'
-- spec 'nvim-treesitter/nvim-treesitter-textobjects'
-- 'https://www.lazyvim.org/plugins/treesitter'

-- tree-sitter CLI not found: `tree-sitter` is not executable!
-- tree-sitter CLI is needed because `latex` is marked that it
-- needs to be generated from the grammar definitions to be compatible with nvim!
-- 'latex', 'swift', 'teal', -- req :MasonInstall tree-sitter-cli
-- TODO: how to generate automatically?
--
-- https://github.com/alex-pinkus/tree-sitter-swift
-- https://github.com/euclidianAce/tree-sitter-teal
-- https://github.com/latex-lsp/tree-sitter-latex

return {

  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = { -- a list of parser names, or all (MUST always be installed)
        'awk',
        'bash',
        'c',
        'c_sharp',
        'cmake',
        'cpp',
        'css',
        'csv',
        'cuda',
        'desktop',
        'devicetree',
        'diff',
        'disassembly', -- 'ColinKennedy/tree-sitter-disassembly'
        'dockerfile',
        'doxygen',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'glsl',
        'gnuplot',
        'go',
        'graphql',
        'haskell',
        'hlsl',
        'html',
        'http',
        'ini',
        'javascript',
        'jsonc',
        'kotlin',
        'llvm',
        'lua',
        'luau',
        'make',
        'markdown',
        'markdown_inline',
        'matlab',
        'nasm',
        'nginx',
        'ninja',
        'nix',
        'objc',
        'objdump',
        'ocaml',
        'odin',
        'pascal',
        'perl',
        'php',
        'php',
        'printf',
        'proto',
        'python',
        'qmldir', -- https://doc.qt.io/qt-6/qtqml-modules-qmldir.html
        'qmljs',  -- https://doc.qt.io/qt-6/qmlapplications.html
        'query',
        'regex',
        'rst',
        'ruby',
        'ruby',
        'rust',
        'scss',
        'slang',
        'solidity',
        'sql',
        'ssh_config',
        'strace', -- 'sigmaSd/tree-sitter-strace'
        'svelte',
        'sxhkdrc',
        'tcl',
        'tmux',
        'toml',
        'typescript',
        'udev',
        'uxntal',
        'verilog', -- 'gmlarumbe/tree-sitter-systemverilog'
        'vhdl',
        'vim',
        'vimdoc',
        'wgsl',
        'wit', -- 'bytecodealliance/tree-sitter-wit'
        'xml',
        'xresources',
        'yaml',
        'zathurarc',
        'zig',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- +syntax => slow down / duplicate highlights
      },
      -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
      -- parser_install_dir = require('user.fn').path.concat({ vim.fn.stdpath('data'), 'pack', 'parser' }),
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'master',
    lazy = false,
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = { -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["kf"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["kc"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer']  = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        }, -- END textobjects.select
      }, -- END textobjects
      nvim_next = { -- nvim-next.integrations!
        enable = true,
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
            -- Below will go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            -- Make it even more gradual by adding multiple queries and regex.
            goto_next = {
              ["]c"] = "@conditional.outer",
            },
            goto_previous = {
              ["[c"] = "@conditional.outer",
            }
          }, -- END nvim_next.textobjects.move
        }, -- END nvim_next.textobjects
      }, -- END nvim_next
    },
    config = function(_, opts)
      require('nvim-next.integrations').treesitter_textobjects()
      require('nvim-treesitter.configs').setup(opts)
    end,
    dependencies = { 'ghostbuster91/nvim-next' } -- repeat movements using: ';' ','.
  },

  -- { -- automatically add closing tags for HTML and JSX
  --   'windwp/nvim-ts-autotag',
  --   event = "LazyFile",
  --   opts = {},
  -- },

}
