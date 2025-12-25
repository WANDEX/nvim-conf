-- AUTHOR: 'WANDEX/nvim-conf'
-- nerv statusline for 'rebelot/heirline.nvim'

local ok, _ = pcall(require, 'heirline')
if not ok then
  return -- return
end

--- to make sure that vim.diagnostic.config() is pre-configured.
require 'user.lsp.diag'

local _static = require('user.stat.static')

local M = {
  s  = _static.static,
  sc = _static.colors,
  sd = _static.static.d,
}

--- dynamically adjust component width respecting amount of free space in percents.
---@param short string
---@param long string
---@param thresh? any
---@return string
function M.dyn_width(short, long, thresh)
  thresh = thresh or 50.0
  if not require('heirline.conditions').width_percent_below(#long, thresh) then
    return short
  end
  return long
end

function M.lsp_attached()
  local bufnr = vim.api.nvim_get_current_buf()
  return next(vim.lsp.get_clients({ bufnr = bufnr })) ~= nil
end

function M.formatters_attached()
  local conform_ok, conform = pcall(require, 'conform')
  if not conform_ok then
    return false
  end
  local bufnr = vim.api.nvim_get_current_buf()
  return next(conform.list_formatters_for_buffer(bufnr)) ~= nil
end

function M.linters_attached()
  local lint_ok, lint = pcall(require, 'lint')
  if not lint_ok then
    return false
  end
  local bufnr = vim.api.nvim_get_current_buf()
  local linters = lint.get_running(bufnr) ---@type string[]
  if #linters == 0 then
    return false
  end
  return true
end

---@nodiscard
---@param m string current mode
---@return boolean current vim-mode is one of the visual modes
function M.mode_is_v(m)
  -- return
  --   m == 'v' or --  v
  --   m == 'V' or --  V
  --   m == '\22'  -- ^V
  return M.s.mode_names[m]:upper():match('V')
end

function M.statusline()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')

  local Space_s = { provider = M.sd.nbsp }
  local Space_l = { provider = M.sd.sl_f }
  local Space_r = { provider = M.sd.sl_b }
  local Align   = { provider = '%=' }

  local ViMode = {
    --- get vim current mode, this information will be required by the provider
    --- and the highlight functions, so we compute it only once per component
    --- evaluation and store it as a component attribute
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = M.s,
    provider = function(self)
      return self.mode_names[self.mode]
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_fcolors[mode], bold = true }
    end,
  }

  local FileNameBlock = { --- let's first set up some attributes needed by this component and it's children
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.home = vim.fn.getenv('HOME') --- to replace: '/home/user' -> '~'
      self.lfilename = vim.fn.fnamemodify(self.filename, ':.'):gsub(self.home, '~')
    end,
  } --- We can now define some children separately and add them later

  local FileIcon = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ':e')
      self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(
        filename,
        extension,
        { default = true }
      )
    end,
    provider = function(self)
      return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    init = function(self)
      if self.lfilename == '' then
        self.lfilename = '[NONAME]'
      end
end,
    hl = { fg = M.sc.f.cyan },

    flexible = 2,
    {
      provider = function(self)
        return self.lfilename
      end,
    },
    {
      provider = function(self)
        return vim.fn.pathshorten(self.lfilename)
      end,
    },
    {
      provider = function(self)
        return vim.fs.basename(self.lfilename)
      end,
    },
  }

  local FileFlags = {
    {
      provider = function()
        if not vim.bo.modifiable or vim.bo.readonly then
          return '  '
        end
      end,
      hl = { fg = M.sc.f.red },
    },
  }

  local FileNameModifier = {
    hl = function()
      if vim.bo.modified then
        --- use `force` because we need to override the child's hl foreground
        return { fg = M.sc.f.cyan, bold = true, force = true }
      end
    end,
  }

  FileNameBlock = utils.insert( --- let's add the children to our FileNameBlock component
    FileNameBlock,
    { provider = '%<' }, -- this means that the statusline is cut here when there's not enough space
    FileIcon,
    utils.insert(FileNameModifier, FileName), -- a new table where FileName is a child of FileNameModifier
    unpack(FileFlags) -- A small optimization, since their parent does nothing
  )

  local FileType = {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = { bold = true },
  }

  local FileEncoding = {
    provider = function()
      local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc ~= 'utf-8' and enc:upper()
    end,
  }

  local FileFormat = {
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt ~= 'unix' and fmt:upper()
    end,
  }

  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize <= 0 then
        return '0' .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i])
    end,
  }

  local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
      local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
      return (ftime > 0) and os.date('%c', ftime)
    end,
  }

  local ShowCMD = { --- req: showcmdloc='statusline'
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    conditions = function()
      return conditions.is_active()
    end,
    provider = function(self)
      if not M.mode_is_v(self.mode) then
        return -- guard - show only if current mode is one of the visual modes
      end
      local cmd_content = '%S'
      return self.mode .. M.sd.sl_b .. cmd_content .. M.sd.sl_b
    end,
  }

  local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P|%p = percentage through file of displayed window
    provider = '%3l/%-3L:%2c %3p%%',
  }

  local FormattersActive = {
    condition = M.formatters_attached,
    provider = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local formatters = require('conform').list_formatters_for_buffer(bufnr)
      local sico = ' ' --  
      if vim.g.autoformat then -- autoformat on save is enabled
        sico = sico .. '󱡝 ' -- indicator: global
      end
      if vim.b[bufnr].autoformat then
        sico = sico .. '󰚤 ' -- indicator: buffer-local
      end
      return sico .. table.concat(formatters, ' ') .. ' '
    end,
    hl = { fg = M.sc.f.orange, bold = false },
  }

  local LintersActive = {
    condition = M.linters_attached,
    provider = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local linters = require('lint').get_running(bufnr) ---@type string[]
      if #linters == 0 then
        return '󰦕 '
      end
      return '󰦕 ' .. table.concat(linters, ' ') .. ' '
    end,
    hl = { fg = M.sc.f.fg_green, bold = false },
  }

  local LSPActive = {
    condition = M.lsp_attached,
    provider = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local names = {}
      local clients = vim.lsp.get_clients({bufnr = bufnr}) ---@class vim.lsp.Client
      for _, client in ipairs(clients) do
        if not client.config then
          table.insert(names, '💀') -- unexpected!
          goto continue -- config structure not exist!
        end
        if not client.config.name then
          table.insert(names, '☠️') -- unexpected!
          goto continue -- name string not exist!
        end
        table.insert(names, client.config.name)
        ::continue::
      end
      return ' ' .. table.concat(names, ' ') .. ' '
    end,
    hl = { fg = M.sc.f.green, bold = false },
  }

  local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
      erro_sign  =  vim.diagnostic.config().signs.text[vim.diagnostic.severity.ERROR],
      warn_sign  =  vim.diagnostic.config().signs.text[vim.diagnostic.severity.WARN],
      info_sign  =  vim.diagnostic.config().signs.text[vim.diagnostic.severity.INFO],
      hint_sign  =  vim.diagnostic.config().signs.text[vim.diagnostic.severity.HINT],
    },

    init = function(self)
      self.erroc = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnc = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.infoc = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      self.hintc = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,

    {
      provider = function(self)
        return self.erroc > 0 and (' ' .. self.erro_sign .. self.erroc)
      end,
      hl = { fg = M.sc.diag_error },
    },
    {
      provider = function(self)
        return self.warnc > 0 and (' ' .. self.warn_sign .. self.warnc)
      end,
      hl = { fg = M.sc.diag_warn },
    },
    {
      provider = function(self)
        return self.infoc > 0 and (' ' .. self.info_sign .. self.infoc)
      end,
      hl = { fg = M.sc.diag_info },
    },
    {
      provider = function(self)
        return self.hintc > 0 and (' ' .. self.hint_sign .. self.hintc)
      end,
      hl = { fg = M.sc.diag_hint },
    },
  }

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
    end,

    {
      provider = '󰊢', --  
      hl = { fg = M.sc.f.orange },
    },
    {
      provider = function(self)
        return self.status_dict.head
      end,
      hl = { bold = true },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = '(',
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ('+' .. count)
      end,
      hl = { fg = M.sc.git_add },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ('-' .. count)
      end,
      hl = { fg = M.sc.git_del },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ('~' .. count)
      end,
      hl = { fg = M.sc.git_change },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = ')',
    },
  }

  local DAPMessages = {
    condition = function()
      if not pcall(require, 'dap') then return false end
      local session = require('dap').session()
      if session then
        local filename = vim.api.nvim_buf_get_name(0)
        if session.config then
          local progname = session.config.program
          return filename == progname
        end
      end
      return false
    end,
    provider = function()
      if not pcall(require, 'dap') then return '' end
      return ' ' .. require('dap').status()
    end,
    hl = { fg = utils.get_highlight('Debug').fg },
  }

  local WorkDir = {
    init = function(self)
      local ico = ' ' --  
      self.icon = ico .. (vim.fn.haslocaldir(0) == 1 and 'l' or 'g') .. ':'
      local cwd = vim.fn.getcwd(0)
      self.cwd  = vim.fn.fnamemodify(cwd, ':~')
    end,
    hl = { fg = M.sc.f.bg },

    flexible = 1,
    {
      provider = function(self)
        local trail = self.cwd:sub(-1) == '/' and '' or '/'
        return self.icon .. self.cwd .. trail
      end,
    },
    {
      provider = function(self)
        local cwd = vim.fn.pathshorten(self.cwd)
        local trail = self.cwd:sub(-1) == '/' and '' or '/'
        return self.icon .. cwd .. trail
      end,
    },
    {
      provider = function(self)
        local cwd = vim.fs.basename(self.cwd)
        local trail = self.cwd:sub(-1) == '/' and '' or '/'
        return self.icon .. cwd .. trail
      end,
    },
  }

  local HelpName = {
    condition = function()
      return vim.bo.filetype == 'help'
    end,
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.lfilename = vim.fn.fnamemodify(self.filename, ':t')
      self.ico = ' '
    end,
    provider = function(self) -- i.e. HELP
      return self.ico .. self.lfilename
    end,
    -- hl = { fg = M.sc.f.blue },
    hl = { fg = M.sc.f.red }, -- XXX
  }

  local ShellName = {
    condition = function()
      return vim.bo.buftype == 'terminal'
    end,
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.home = vim.fn.getenv('HOME') --- to replace: '/home/user' -> '~'
      self.lfilename = vim.fn.fnamemodify(self.filename, ':.'):gsub(self.home, '~')
        :gsub('//.*//', '') --- replace cwd, :term PID is left untouched
      self.ico = ' '
    end,
    provider = function(self) -- i.e. /bin/bash
      return self.ico .. self.lfilename
    end,
    hl = { fg = M.sc.f.blue, bold = true },
  }

  local Spell = {
    condition = function()
      return vim.wo.spell
    end,
    provider = 'SPELL',
    hl = { fg = M.sc.f.red, bold = true },
  }

  local narrow_FT_ruler = {
    Space_r,
    FileType,
    Align,
    Ruler,
    Space_r,
  }

  local C_WD = {
    Space_l,
    WorkDir,
    Space_l,
  }

  local LS = {
    C_WD,
    FileNameBlock,
    Space_l,
    { provider = '%<' },
    Git,
  }

  local LSE = {
    Space_s,
    Space_l,
    Align,
    -- { provider = '%<' },
  }

  local RS = {
    FileType,
    Space_r,
    Ruler,
  }

  local RSO = { --- right side of other statuslines
    Align,
    Space_r,
    Space_s,
    ShowCMD,
    RS,
    Space_r, -- for the same indent from right as with RSD in DefaultStatusline
  }

  local Mode = utils.surround({ M.sd.t_lr, M.sd.t_ul }, M.sc.f.black, { ViMode })
  local LSD  = utils.surround({ M.sd.t_lr, M.sd.t_ul }, M.sc.f.black, { LS })
  local RSD  = utils.surround({ M.sd.t_ur, M.sd.t_ll }, M.sc.f.black, { RS })

  local DefaultStatusline = {
    Mode,
    Spell,
    LSD,
    Space_l,
    Diagnostics,
    Align,
    DAPMessages,
    Align,
    ShowCMD,
    FormattersActive,
    LintersActive,
    LSPActive,
    Space_r,
    RSD,
  }

  local InactiveStatusline = {
    condition = function()
      return not conditions.is_active()
    end,
    Spell,
    C_WD,
    FileNameBlock,
    LSE,
    RSO,
  }

  local NarrowStatusline = {
    condition = function()
      return conditions.buffer_matches({
        filetype = { 'NvimTree' },
      })
    end,
    narrow_FT_ruler,
  }

  local SpecialStatusline = {
    condition = function()
      return conditions.buffer_matches({
        buftype  = { 'prompt', 'quickfix' },
        filetype = { '^git.*', 'fugitive', 'help', 'magit' },
      })
    end,
    { condition = conditions.is_active, Mode },
    Spell,
    C_WD,
    HelpName,
    LSE,
    RSO,
  }

  local TerminalStatusline = {
    condition = function()
      return conditions.buffer_matches({
        buftype = { 'terminal' }
      })
    end,
    { condition = conditions.is_active, Mode },
    Spell,
    C_WD,
    ShellName, -- i.e. /bin/bash
    LSE,
    RSO,
  }

  local StatusLines = {
    hl = function()
      if conditions.is_active() then
        return {
          fg = M.sc.f.fg,
        }
      else
        return {
          fg = utils.get_highlight('StatusLineNC').fg,
          bg = utils.get_highlight('StatusLineNC').bg,
        }
      end
    end,

    fallthrough = false,

    NarrowStatusline,
    SpecialStatusline,
    TerminalStatusline,
    InactiveStatusline,
    DefaultStatusline,
  }

  return StatusLines -- { statusline = StatusLines }
end

return M
