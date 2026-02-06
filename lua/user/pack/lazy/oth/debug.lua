-- AUTHOR: 'WANDEX/nvim-conf'
-- spec 'mfussenegger/nvim-dap'
--
-- ref:
-- https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/lua/kickstart/plugins/debug.lua#L11
--
-- configurations ref:
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Cookbook
--
-- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md#disassembly-view
-- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md#workspace-configuration-reference

local M = {}

_, M.dap = pcall(require, 'dap')

M.controls_icons = {
  pause       = ' ', -- '⏸ 󰏧'
  play        = ' ', -- '▶  '
  step_into   = ' ', -- '⏎ '
  step_over   = ' ', -- '⏭ '
  step_out    = ' ', -- '⏮ '
  step_back   = ' ', -- 'b'
  run_last    = ' ', -- '', '▶▶', ''
  terminate   = ' ', -- '⏹ '
  disconnect  = ' ', -- '⏏ '
}

---@module 'dap-disasm'
---@type disasm.Config
M.dap_disasm_opts = {
  dapui_register   = true, -- add disassembly view to elements of nvim-dap-ui
  dapview_register = true, -- add disassembly view to nvim-dap-view
  dapview = { -- if registered, pass section configuration to nvim-dap-view
    keymap = 'D',
    label  = 'DASM',
    short_label = ' ', -- 
  },
  --- Show winbar with buttons to step into the code with instruction granularity
  --- This settings is overriden (disabled) if the dapview integration is enabled and the plugin is installed
  winbar = {
    enabled = true,
    labels = {
      step_into = 'Step Into',
      step_over = 'Step Over',
      step_back = 'Step Back',
    },
    order = { 'step_into', 'step_over', 'step_back' },
  },
  sign = 'DapStopped', -- The sign to use for instruction the exectution is stopped at
  ins_before_memref = 16, -- Number of instructions to show before the memory reference
  ins_after_memref  = 16, -- Number of instructions to show after the memory reference
  columns = { -- Columns to display in the disassembly view
    'address',
    'instructionBytes',
    'instruction',
  },
}

--- NOTE: I manually changed keymap in lua/dap-view/views/keymaps/views.lua
---       'keymap("e", function()' -> 'keymap("a", function()'
---       Currently there is no way to change mappings defined in views.lua
---
---@module 'dap-view'
---@type dapview.Config
M.dap_view_opts = {
  winbar = {
    show = true,
    sections = { 'watches', 'scopes', 'disassembly', 'repl', 'breakpoints', 'threads', 'exceptions' },
    default_section = 'scopes',
    show_keymap_hints = true,
    base_sections = {
      breakpoints = { label = 'Breakpoints', keymap = 'B' },
      scopes      = { label = 'Scopes',      keymap = 'S' },
      exceptions  = { label = 'Exceptions',  keymap = 'X' },
      watches     = { label = 'Watches',     keymap = 'W' },
      threads     = { label = 'Threads',     keymap = 'T' },
      repl        = { label = 'REPL',        keymap = 'R' },
      sessions    = { label = 'Sessions',    keymap = 'K' },
      console     = { label = 'Console',     keymap = 'C' },
    },
    controls = {
      enabled = true,
    },
  },
  windows = {
    size = 0.25,
    position = 'below',
    terminal = {
      size = 0.3,
      position = 'right',
      hide = {},
    },
  },
  icons = vim.tbl_extend('force', M.controls_icons, {
    collapsed = ' ',
    disabled  = ' ', --  
    enabled   = ' ', --  
    expanded  = ' ',
    filter    = ' ',
    negate    = ' ', -- 
  }),
  -- render = {
  --   ---@field sort_variables? fun(lhs: dap.Variable, rhs: dap.Variable): boolean Override order of variables
  --   -- sort_variables = function(lhs, rhs)
  --   --   return vim.fn.sort()
  --   -- end,
  -- },
}
---@type dapui.Config
M.dapui_opts = { --- Dap UI setup -- For more information, see |:help nvim-dap-ui|
  controls = {
    element = 'repl',
    enabled = true,
    icons = M.controls_icons,
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
  }, {
    elements = { {
      id = 'disassembly',
      size = 1.0,
    } },
    position = 'bottom',
    size = 0.1,
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

function M.set_breakpoint_icons()
  vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
  vim.api.nvim_set_hl(0, 'DapStop',  { fg = '#ffcc00' })
  local breakpoint_icons = vim.g.NF and
    { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' } or
    { Breakpoint = 'b', BreakpointCondition = 'c', BreakpointRejected = 'x', LogPoint = 'l', Stopped = '>' } or
    { Breakpoint = '', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '' }
  for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
  end
end

--- dap, dapui, dap-view: reload / restore layouts
function M.dap_reload()
  local dap   = require('dap')
  local dapui = require('dapui')
  local dapvw = require('dap-view')
  dapui.close()
  dapvw.close(true)
  dap.close()
  dapui.setup(M.dapui_opts)
  dapvw.setup(M.dap_view_opts)
end

--- https://github.com/rcarriga/nvim-dap-ui#floating-elements
function M.keymaps()
  local k_opts = { desc = 'dapui: evaluate expression', silent = true }

  vim.keymap.set({ 'n', 'v' }, '<M-h>', '<cmd>lua require"dapui".eval()<CR>', k_opts)

  vim.keymap.set('n', '<localleader>D', function()
    M.dap_reload()
    -- dapui.toggle()
    -- dapvw.toggle(true)
  end, { desc = 'dap, dapui, dap-view: reload / restore layouts', silent = true })
end

--- use nvim-dap events to open and close the windows automatically (:help dap-extensions)
function M.dap_listeners()
  local dap, dapui = require('dap'), require('dapui')
  dap.listeners.after.event_initialized.dapui_config = dapui.open
  dap.listeners.before.attach.dapui_config           = dapui.open
  dap.listeners.before.event_exited.dapui_config     = dapui.close
  dap.listeners.before.event_terminated.dapui_config = dapui.close
  dap.listeners.before.launch.dapui_config           = dapui.open
end

--- XXX: function to store temporary trash code & notes
function M.other()
  local dap = require('dap')
  dap.adapters.codelldb = {
    type = 'executable',
    command = 'codelldb',
    -- detached = false, -- on windows you may have to uncomment this line
    -- enrich_config = {
    -- },
    -- options = {
    -- }
  }
end

function M.pick_binary()
  local bdir = require('user.lib.fn').path.wndx_cmake_build()
  local path = require('dap.utils').pick_file({
    path = bdir, executables = true,
    filter = function(fpath)
      return
      not vim.endswith(fpath, '.out') and -- CompilerIdCXX/a.out
      not vim.endswith(fpath, '.bin')     -- CMakeDetermineCompilerABI_CXX.bin
    end,
  })
  return (path and path ~= '') and path or M.dap.ABORT
end

function M.gtest_tests_filter()
  vim.env.GTEST_TESTS_FILTER = vim.env.GTEST_TESTS_FILTER or '*' -- restore last input
  local input = vim.fn.input({ prompt = '--gtest_filter=', default = vim.env.GTEST_TESTS_FILTER })
  vim.env.GTEST_TESTS_FILTER = input -- save last input
  return { '--gtest_brief=1', '--gtest_filter=' .. input, }
end

--- TODO lldb.showDisassembly - When to show disassembly:
---  auto   - only when source is not available.
---  never  - never show.
---  always - always show, even if source is available.
function M.initCommands_codelldb()
  return {
  }
end

function M.dap_configurations()
  local dap = require('dap')
  dap.configurations.cpp = {
    {
      name = 'pick process | codelldb |',
      type = 'codelldb',
      request = 'attach',
      program = '${command:pickProcess}',
      -- pid = require('dap.utils').pick_process,
      -- args = {},
      initCommands = M.initCommands_codelldb,
    },
    {
      name = 'pick binary  | codelldb |',
      type = 'codelldb',
      request = 'launch',
      program = '${command:pickFile}',
      initCommands = M.initCommands_codelldb,
    },
    {
      name = 'pick binary  | codelldb | wndx_cmake_build.sh |',
      type = 'codelldb',
      request = 'launch',
      program = M.pick_binary,
      initCommands = M.initCommands_codelldb,
    },
    {
      name = 'pick binary  | codelldb | wndx_cmake_build.sh | --gtest_filter=*',
      type = 'codelldb',
      request = 'launch',
      program = M.pick_binary,
      args = M.gtest_tests_filter,
      initCommands = M.initCommands_codelldb,
    },
  } -- END dap.configurations.cpp
  dap.configurations.c    = dap.configurations.cpp -- re-use the configuration
  dap.configurations.rust = dap.configurations.cpp
  --[[
  require('dap-go').setup({ -- Install golang specific config
    delve = {
      -- On Windows delve must be run attached or it crashes.
      -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      detached = vim.fn.has 'win32' == 0,
    },
  })
  --]]
end

M.spec = {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    },
    {
      'Jorenar/nvim-dap-disasm', --- :DapDisasm :DapViewToggle :DapViewOpen :DapViewClose
      dependencies = { 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui',
        { 'igorlfs/nvim-dap-view', opts = M.dap_view_opts },
      },
    },
    {
      'theHamsta/nvim-dap-virtual-text',
      dependencies = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    },
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = { 'mfussenegger/nvim-dap', 'mason-org/mason.nvim' },
    },
    --- add debugger extensions here:
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
      desc = 'Debug: Reverse Continue',
    },
    {
      '<F7>', function()  --   F7 mutually exclusive layouts: dap-view & dapui
        require('dap-view').close(true) -- close to not break layout
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle last session view ui',
    },
    {
      '<F19>', function() -- S-F7
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last session again',
    },
    {
      '<F55>', function() -- M-F7 mutually exclusive layouts: dap-view & dapui
        require('dapui').close() -- close to not break layout
        require('dap-view').toggle(true)
      end,
      desc = 'Debug: Toggle last session view min',
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
    require('mason-nvim-dap').setup({
      --- Makes a best effort to setup the various debuggers with reasonable debug configurations.
      automatic_installation = true,
      --- provide additional configuration to the handlers, see mason-nvim-dap README for more info.
      handlers = {},
      --- Explicitly set to an empty table (installed in/via mason-tool-installer)
      ensure_installed = {},
    })
    require('dapui').setup(M.dapui_opts) -- setup before dap-disasm alongside with dap-view
    require('dap-disasm').setup(M.dap_disasm_opts)
    M.set_breakpoint_icons()
    M.keymaps()
    -- M.dap_listeners()
    -- M.other()
    M.dap_configurations()
  end,
}

return M.spec
