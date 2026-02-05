-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mfussenegger/nvim-dap'
--
-- ref:
-- https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/lua/kickstart/plugins/debug.lua#L11

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'Jorenar/nvim-dap-disasm', -- :DapDisasm
    --- Add debuggers here:
    -- 'leoluz/nvim-dap-go',
  },
  keys = {
    {
      '<F5>', function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F17>', function() -- S-F5
        require('dap').stop()
      end,
      desc = 'Debug: Start/Continue',
    },
    { --- last session result, see session output in case of unhandled exception.
      '<F7>', function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>ab', function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<F9>', function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<F21>', function() -- S-F9
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<F10>', function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F11>', function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F23>', function() -- S-F11
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
  },
  config = function()
    local dap   = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      --- Makes a best effort to setup the various debuggers with reasonable debug configurations.
      automatic_installation = true,
      --- provide additional configuration to the handlers, see mason-nvim-dap README for more info.
      handlers = {},
      --- Explicitly set to an empty table (installed in/via mason-tool-installer)
      ensure_installed = {},
    }

    --- Dap UI setup -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          pause       = ' ', -- '⏸ 󰏧'
          play        = ' ', -- '▶  '
          step_into   = ' ', -- '⏎ '
          step_over   = ' ', -- '⏭ '
          step_out    = ' ', -- '⏮ '
          step_back   = ' ', -- 'b'
          run_last    = ' ', -- '', '▶▶', ''
          terminate   = ' ', -- '⏹ '
          disconnect  = ' ', -- '⏏ '
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = { -- codicons
        expanded      = ' ', -- ' ', '', '▾'
        collapsed     = ' ', -- ' ', '', '▸'
        current_frame = ' ', -- ' ', '', '*', '', ''
      },
      layouts = { {
        elements = { {
          id = "scopes",
          size = 0.25,
        }, {
          id = "breakpoints",
          size = 0.25,
        }, {
          id = "stacks",
          size = 0.25,
        }, {
          id = "watches",
          size = 0.25,
        }, },
        position = "left",
        size = 60,
      }, {
        elements = { {
          id = "repl",
          size = 0.5,
        }, {
          id = "console",
          size = 0.5,
        }, },
        position = "bottom",
        size = 10,
      }, },
      mappings = {
        edit   = 'k', -- 'e'
        expand = { '<CR>', '<2-LeftMouse>' },
        open   = 'o',
        remove = 'd',
        repl   = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }

    --- change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop',  { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.NF
      and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or  { Breakpoint = 'b', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    --[[
    require('dap-go').setup { -- Install golang specific config
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    --]]

    -- FIXME: build/ dir is ignored and cannot be used as path in cmd mode autocompletion.

  end,
}
