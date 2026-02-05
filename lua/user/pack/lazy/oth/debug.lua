-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mfussenegger/nvim-dap'
--
-- ref:
-- https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/lua/kickstart/plugins/debug.lua#L11
--
-- configurations ref:
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

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
        require('dap').close() -- dap.stop() is deprecated!
      end,
      desc = 'Debug: Stop',
    },
    {
      '<F29>', function() -- C-F5
        require('dap').reverse_continue()
      end,
      desc = 'Debug: Stop',
    },
    { --- last session result, see session output in case of unhandled exception.
      '<F7>', function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle last session ui view',
    },
    {
      '<F19>', function() -- S-F7
        require('dap').run_last()
      end,
      desc = 'Debug: Run last session again',
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
      '<F33>', function() -- C-F9
        require('dap').run_to_cursor()
      end,
      desc = 'Debug: Continue execution to the current cursor',
    },
    {
      '<F10>', function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F22>', function() -- S-F10
        require('dap').step_back()
      end,
      desc = 'Debug: Step Back', -- rr
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
    local dap, dapui = require('dap'), require('dapui')

    require('mason-nvim-dap').setup {
      --- Makes a best effort to setup the various debuggers with reasonable debug configurations.
      automatic_installation = true,
      --- provide additional configuration to the handlers, see mason-nvim-dap README for more info.
      handlers = {},
      --- Explicitly set to an empty table (installed in/via mason-tool-installer)
      ensure_installed = {},
    }

    ---@type dapui.Config
    local dapui_opts = { --- Dap UI setup -- For more information, see |:help nvim-dap-ui|
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
          close = { 'q', '<Esc>', '<C-l>' },
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
          id = 'scopes',
          size = 0.25,
        }, {
          id = 'breakpoints',
          size = 0.25,
        }, {
          id = 'stacks',
          size = 0.25,
        }, {
          id = 'watches',
          size = 0.25,
        }, },
        position = 'left',
        size = 60,
      }, {
        elements = { {
          id = 'repl',
          size = 0.5,
        }, {
          id = 'console',
          size = 0.5,
        }, },
        position = 'bottom',
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

    dapui.setup(dapui_opts)

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' }) --- change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapStop',  { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.NF
      and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or  { Breakpoint = 'b', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    --- use nvim-dap events to open and close the windows automatically (:help dap-extensions)
    dap.listeners.after.event_initialized.dapui_config = dapui.open
    dap.listeners.before.attach.dapui_config           = dapui.open
    dap.listeners.before.event_exited.dapui_config     = dapui.close
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.launch.dapui_config           = dapui.open

    -- vim.keymap.set({ 'n', 'v' }, '<M-k>', function()
    --   dapui.eval('<cword>')
    --   -- dapui.eval('<expression>')
    --   -- dapui.eval()
    -- end, { desc = 'evaluate expression', silent = false, expr = true })

    --- https://github.com/rcarriga/nvim-dap-ui#floating-elements
    -- vim.keymap.set({ 'n', 'v' }, '<M-k>', function()
    --   dapui.float_element()
    -- end, { desc = 'dapui: float element', silent = true })

    vim.keymap.set({ 'n', 'v' }, '<localleader>D', function()
      dapui.setup(dapui_opts)
      -- dapui.update_render(dapui_opts.render)
      dapui.toggle()
    end, { desc = 'dapui: restore layouts', silent = true })

    dap.configurations.cpp = {
      {
        name = 'pick process | codelldb |',
        type = 'codelldb',
        request = 'attach',
        program = '${command:pickProcess}',
      },
      {
        name = 'pick binary  | codelldb |',
        type = 'codelldb',
        request = 'launch',
        program = '${command:pickFile}',
      },
      {
        name = 'pick binary  | codelldb | wndx_cmake_build.sh |',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local bdir = require('user.lib.fn').path.wndx_cmake_build()
          local path = require('dap.utils').pick_file({
            path = bdir, executables = true,
            filter = function(fpath)
              return
                not vim.endswith(fpath, '.out') and -- CompilerIdCXX/a.out
                not vim.endswith(fpath, '.bin')     -- CMakeDetermineCompilerABI_CXX.bin
            end,
          })
          return (path and path ~= '') and path or dap.ABORT
        end,
      },
      {
        name = 'pick binary  | codelldb | wndx_cmake_build.sh | --gtest_filter=*',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local bdir = require('user.lib.fn').path.wndx_cmake_build()
          local path = require('dap.utils').pick_file({
            path = bdir, executables = true,
            filter = function(fpath)
              return
                not vim.endswith(fpath, '.out') and -- CompilerIdCXX/a.out
                not vim.endswith(fpath, '.bin')     -- CMakeDetermineCompilerABI_CXX.bin
            end,
          })
          return (path and path ~= '') and path or dap.ABORT
        end,
        args = function()
          vim.env.GTEST_TESTS_FILTER = vim.env.GTEST_TESTS_FILTER or '*' -- restore last input
          local input = vim.fn.input({ prompt = '--gtest_filter=', default = vim.env.GTEST_TESTS_FILTER })
          vim.env.GTEST_TESTS_FILTER = input -- save last input
          return { '--gtest_brief=1', '--gtest_filter=' .. input, }
        end,
      },
    } -- END dap.configurations.cpp
    dap.configurations.c    = dap.configurations.cpp -- re-use the configuration
    dap.configurations.rust = dap.configurations.cpp

    --[[
    require('dap-go').setup { -- Install golang specific config
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    --]]

  end,
}
