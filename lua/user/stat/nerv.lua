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

M.git = {
  ico = {
    {
      provider = vim.g.NF and ' ' or '', --  
      hl = { fg = M.sc.f.orange },
    },
  },
  head = {
    {
      provider = function(self)
        return self.gsd.head
      end,
      hl = { bold = true },
    },
  },
  stat = {
    {
      provider = function(self)
        return M.git_has_changes(self) and '(' or ''
      end,
    },
    {
      {
        provider = function(self)
          local  count = self.gsd.added or 0
          return count > 0 and ('+' .. count)
        end,
        hl = { fg = M.sc.git_add },
      },
      {
        provider = function(self)
          local  count = self.gsd.removed or 0
          return count > 0 and ('-' .. count)
        end,
        hl = { fg = M.sc.git_del },
      },
      {
        provider = function(self)
          local  count = self.gsd.changed or 0
          return count > 0 and ('~' .. count)
        end,
        hl = { fg = M.sc.git_change },
      },
    },
    {
      provider = function(self)
        return M.git_has_changes(self) and ')' or ''
      end,
    },
  },
}

---@nodiscard
---@param delimiters string[]
---@param color string|function|nil
---@param component table
---@return table
--- alternative to utils.surround().
function M.surround(delimiters, color, component)
  return {
    { hl = { fg = color }, provider = delimiters[1] },
    { hl = { bg = color }, component },
    { hl = { fg = color }, provider = delimiters[2] },
  }
end

---@nodiscard
---@param delimiters string[]
---@param color string|function|nil
---@param component table
---@return table
--- alternative to utils.surround() - active and inactive.
function M.surround_ai(delimiters, color, component)
  local conditions = require('heirline.conditions')
  local defbg = require('heirline.utils').get_highlight('StatusLineNC').bg
  return {
    { condition = conditions.is_active,
      {
        { hl = { fg = color }, provider = delimiters[1] },
        { hl = { bg = color }, component },
        { hl = { fg = color }, provider = delimiters[2] },
      },
    },
    { condition = conditions.is_not_active,
      {
        { hl = { fg = defbg }, provider = delimiters[1] },
        { hl = { bg = defbg }, component },
        { hl = { fg = defbg }, provider = delimiters[2] },
      },
    },
  }
end

function M.file_name_init(self)
  self = self or {}
  self.filename = vim.api.nvim_buf_get_name(0)
  self.home = vim.fn.getenv('HOME') --- to replace: '/home/user' -> '~'
  if self.filename == '' then
    self.lfilename = '[NONAME]'
  else
    self.lfilename = vim.fn.fnamemodify(self.filename, ':.'):gsub(self.home, '~')
  end
  return self
end

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

function M.git_has_changes(self)
  self = self or {}
  self.gsd = vim.b.gitsigns_status_dict
  self.gsd.changed = self.gsd.changed or 0 -- fix against nil value
  self.gsd.added   = self.gsd.added   or 0
  self.gsd.removed = self.gsd.removed or 0
  return
    self.gsd.changed ~= 0 or
    self.gsd.added   ~= 0 or
    self.gsd.removed ~= 0
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

---@nodiscard
---@return boolean current buftype or filetype is special.
function M.special_bt_ft()
  return require('heirline.conditions').buffer_matches({
    buftype  = { 'nofile', 'quickfix', 'prompt', 'terminal' },
    filetype = { '^git.*', 'qf', 'fugitive', 'magit' },
  })
end

function M.statusline()
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')

  local Space_s = { provider = M.sd.nbsp }
  local Space_l = { provider = M.sd.sl_f }
  local Space_r = { provider = M.sd.sl_b }
  local Align   = { provider = '%=' }
  local Cut     = { provider = '%<' } -- cut when there is not enough space

  local ViMode = {
    --- get vim current mode, this information will be required by the provider
    --- and the highlight functions, so we compute it only once per component
    --- evaluation and store it as a component attribute
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
      self.ico = vim.g.NF and ' 󰣙' or '   ' --     󰣘 󰣙
    end,
    static = M.s,
    provider = function(self) --- NOTE: equal spacing in active and inactive status lines
      if conditions.is_not_active() then
        return self.ico
      else
        return self.mode_names[self.mode]
      end
    end,
    hl = function(self)
      if conditions.is_not_active() then
        return { fg = '#666666' } -- death star
      else
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_fcolors[mode], bold = true }
      end
    end,
  }

  local FileFlags = { -- unpack(FileFlags) -> A small optimization (if parent does nothing)
    {
      provider = function()
        if not vim.bo.modifiable or vim.bo.readonly then
          return '  '
        end
      end,
      hl = { fg = M.sc.f.red },
    },
  }

  local FileIcon = {
    init = function(self)
      local filename = vim.api.nvim_buf_get_name(0)
      local extension = vim.fn.fnamemodify(filename, ':e')
      local devicons = require('nvim-web-devicons')
      local def = devicons.get_default_icon() or
        { color = '#6d8086', cterm_color = '66', icon = '', name = 'Default' }
      local opts = { default = true }
      local bt = vim.bo.buftype
      local ft = vim.bo.filetype
      self.icon, self.icon_color = devicons.get_icon_color(filename, extension, opts)
      if self.icon == def.icon or self.icon == '󰈙' then -- txt/text
        if bt == 'terminal' then --   
          self.icon, self.icon_color = vim.g.NF and '' or '', M.sc.f.fg
        elseif ft == 'text' then -- override default: 󰈙|  
          self.icon, self.icon_color = vim.g.NF and '' or '', M.sc.f.fg_green
        elseif ft == 'help' then --   
          self.icon, self.icon_color = vim.g.NF and '' or '', M.sc.f.green
        elseif M.special_bt_ft() then --  󰫣  
          self.icon, self.icon_color = vim.g.NF and '' or '', M.sc.f.orange
        else
          self.icon, self.icon_color = devicons.get_icon_color_by_filetype(ft, opts)
        end
      end
    end,
    provider = function(self)
      return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local HelpName = {
    condition = function()
      return vim.bo.filetype == 'help'
    end,
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.lfilename = vim.fn.fnamemodify(self.filename, ':t')
    end,
    provider = function(self) -- i.e. HELP
      return self.lfilename
    end,
    hl = { fg = M.sc.f.green },
  }

  local ShellName = {
    condition = function()
      return vim.bo.buftype == 'terminal'
    end,
    init = function(self)
      M.file_name_init(self)
      self.lfilename = self.lfilename:gsub('//.*//', '') -- replace cwd, :term PID is left untouched
    end,
    provider = function(self) -- i.e. /bin/bash
      return self.lfilename
    end,
    hl = { fg = M.sc.f.blue, bold = true },
  }

  local SpecialName = {
    condition = function()
      return not ShellName.condition() and M.special_bt_ft()
    end,
    init = function(self)
      M.file_name_init(self)
      self.lfilename = self.lfilename:gsub('//.*//', '') -- fugitive commit hash only etc.
      self.lfilename = self.lfilename:gsub('magit://.*', 'MAGIT') -- replace
    end,
    provider = function(self)
      return self.lfilename
    end,
    hl = { fg = M.sc.f.fg_green },
  }

  local FileNameModifier = {
    hl = function()
      if vim.bo.modified then -- force - to override the child's hl
        return { bold = true, force = true }
      end
    end,
  }

  local FileName = {
    condition = function()
      return not    HelpName.condition() and
             not   ShellName.condition() and
             not SpecialName.condition()
    end,
    init = M.file_name_init,
    hl = { fg = M.sc.f.cyan },
    flexible = 4,
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

  local FileNameBlock = {
    FileIcon,
    HelpName,
    ShellName,
    SpecialName,
    utils.insert(FileNameModifier, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
  }

  local FileType = {
    init = function(self)
      self.ico = vim.g.NF and '󰱯' or 'NULL' -- 󰇴
      local ft = vim.bo.filetype
      self.ft = (ft ~= '' and ft) or self.ico
    end,
    provider = function(self)
      return self.ft:upper()
    end,
    hl = { bold = true },
  }

  local FileEncoding = {
    init = function(self)
      local fenc = vim.bo.fenc
      self.enc = (fenc ~= '' and fenc) or vim.o.enc -- :h 'enc'
    end,
    condition = function(self)
      return self.enc ~= 'utf-8'
    end,
    Space_r,
    {
      provider = function(self)
        return self.enc:upper()
      end,
    },
  }

  local FileFormat = {
    init = function(self)
      self.fmt = vim.bo.fileformat
    end,
    condition = function(self)
      return self.fmt ~= 'unix'
    end,
    Space_r,
    {
      provider = function(self)
        return self.fmt:upper()
      end,
    },
  }

  local FileSize = {
    condition = function()
      return not M.special_bt_ft()
    end,
    Space_r,
    {
      provider = function() --- stackoverflow, compute human readable file size
        local suffix = { 'B', 'K', 'M', 'G', 'T', 'P', 'E' }
        local bytes = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        bytes = (bytes < 0 and 0) or bytes
        if bytes <= 0 then
          return '0' .. suffix[1]
        end
        local i = math.floor(math.log(bytes) / math.log(1024))
        return string.format('%.1f%s', bytes / math.pow(1024, i), suffix[i + 1])
      end,
    },
  }

  local FileLastModified = {
    Space_r,
    {
      provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
        return (ftime > 0) and os.date('%c', ftime)
      end,
    },
  }

  local ShowCMD = { --- req: showcmdloc='statusline'
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    condition = conditions.is_active,
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
    { -- separate from the preceding component
      condition = conditions.is_active,
      Space_r,
      Space_s,
    },
    {
      init = function(self)
        self.ico   = vim.g.NF and ' ' or 'S:' --  
        self.ico_g = vim.g.NF and '󱡝' or 'g ' -- indicator: global
        self.ico_l = vim.g.NF and '󰚤' or 'l ' -- indicator: buffer-local
      end,
      provider = function(self)
        if conditions.is_not_active() then return end
        local bufnr = vim.api.nvim_get_current_buf()
        local formatters = require('conform').list_formatters_for_buffer(bufnr)
        local sico = self.ico
        if vim.g.autoformat then -- autoformat on save is enabled
          sico = sico .. self.ico_g
        end
        if vim.b[bufnr].autoformat then
          sico = sico .. self.ico_l
        end
        return sico .. table.concat(formatters, ' ') .. ' '
      end,
      hl = { fg = M.sc.f.orange },
    },
  }

  local LintersActive = {
    condition = M.linters_attached,
    {
      init = function(self)
        self.ico = vim.g.NF and '󰦕 ' or 'l:'
      end,
      provider = function(self)
        if conditions.is_not_active() then return end
        local bufnr = vim.api.nvim_get_current_buf()
        local linters = require('lint').get_running(bufnr) ---@type string[]
        if #linters == 0 then
          return self.ico
        end
        return self.ico .. table.concat(linters, ' ') .. ' '
      end,
      hl = { fg = M.sc.f.fg_green },
    },
  }

  local LSPActive = {
    condition = M.lsp_attached,
    {
      init = function(self)
        self.ico = vim.g.NF and ' ' or 'L:'
      end,
      provider = function(self)
        if conditions.is_not_active() then return end
        local bufnr = vim.api.nvim_get_current_buf()
        local names = {}
        local clients = vim.lsp.get_clients({bufnr = bufnr}) ---@class vim.lsp.Client
        for _, client in ipairs(clients) do
          table.insert(names, client.config.name)
        end
        return self.ico .. table.concat(names, ' ') .. ' '
      end,
      hl = { fg = M.sc.f.green },
    },
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
      condition = conditions.is_active,
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
      { -- separate from the following component
        Space_s,
        Space_l,
      },
    },
  }

  local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
      M.git_has_changes(self) -- gsd
    end,
    Space_l,
    {
      flexible = 8,
      { M.git.ico, M.git.head, M.git.stat },
      { M.git.ico, M.git.head },
      -- { M.git.ico },
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

  local Spell = {
    condition = function()
      return vim.wo.spell
    end,
    provider = 'SPELL',
    hl = { fg = M.sc.f.red, bold = true },
  }

  local FileDetails = {
    FileFormat,
    FileEncoding,
    FileSize,
  }

  local narrow_FT_ruler = {
    utils.surround({'[', ']'}, nil, FileType),
    Align,
    utils.surround({'[', ']'}, nil, Ruler),
  }

  local C_WD = {
    WorkDir,
    Space_l,
  }

  local LS = {
    C_WD,
    FileNameBlock,
    Git,
  }

  local LSE = {
    Space_l,
    Align,
  }

  local RS = {
    FileType,
    Space_r,
    Ruler,
  }

  local RSO = { --- right side
    Align,
    FormattersActive,
    LintersActive,
    LSPActive,
    FileDetails,
  }

  ---@nodiscard
  ---@param component table
  ---@param right? boolean toggle the pair of surrounding chars.
  ---@param color? string|function|nil
  ---@return table
  --- wrapper function to avoid repetitiveness & right/left delimiter pairs.
  local surround = function(component, right, color)
    right = right or false
    color = color or M.sc.f.black
    local delimiters = right and { M.sd.t_ur, M.sd.t_ll } or { M.sd.t_lr, M.sd.t_ul }
    return M.surround_ai(delimiters, color, component)
  end

  local Mode = { ViMode }
  local LSD  = { LS }
  local RSD  = { RS }

  Mode = surround(Mode)
  LSD  = surround(LSD)
  RSD  = surround(RSD, true)

  Mode = utils.insert(Mode, Cut) -- cut after mode and surround chars

  local BEG = {
    Mode,
    Spell,
    LSD,
  }

  local MID = {
    condition = conditions.is_active,
    Diagnostics,
    Align,
    DAPMessages,
  }

  local END = {
    LSE,
    RSO,
    RSD,
  }

  local DefaultStatusline = {
    BEG,
    MID,
    RSO,
    RSD,
  }

  local NarrowStatusline = {
    condition = function()
      return conditions.buffer_matches({
        filetype = { 'NvimTree', 'dap*' },
      })
    end,
    narrow_FT_ruler,
  }

  local SpecialStatusline = {
    condition = M.special_bt_ft,
    BEG,
    END,
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
    -- SpecialStatusline,
    DefaultStatusline,
  }

  return StatusLines -- { statusline = StatusLines }
end

return M
