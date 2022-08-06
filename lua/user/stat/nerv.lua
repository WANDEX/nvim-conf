-- nerv configuration for 'rebelot/heirline.nvim'
-- AUTHOR: WANDEX

local ok, heirline = pcall(require, 'heirline')
if not ok then
  return
end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

function M.setup()
  local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag = {
      warn = utils.get_highlight("DiagnosticWarn").fg,
      error = utils.get_highlight("DiagnosticError").fg,
      hint = utils.get_highlight("DiagnosticHint").fg,
      info = utils.get_highlight("DiagnosticInfo").fg,
    },
    git = {
      del = utils.get_highlight("diffRemoved").fg,
      add = utils.get_highlight("diffAdded").fg,
      change = utils.get_highlight("diffChanged").fg,
    },
  }
  local fcolors = {
    black    = '#000000',
    bg       = '#5C687A',
    fg       = '#8FBCBB',
    fg_green = '#65a380',

    yellow   = '#E5C07B',
    cyan     = '#70C0BA',
    darkblue = '#83A598',
    green    = '#98C378',
    orange   = '#FF8800',
    purple   = '#C678DD',
    magenta  = '#C858E8',
    blue     = '#73BA9F',
    red      = '#D54E54',
  }

  local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
      mode_names = { -- change the strings if yow like it vvvvverbose!
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no\22"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "V",
        vs = "Vs",
        V = "V_",
        Vs = "Vs",
        ["\22"] = "^V",
        ["\22s"] = "^V",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
      },
      mode_colors = {
        n = colors.red,
        i = colors.green,
        v = colors.cyan,
        V = colors.cyan,
        ["\22"] = colors.cyan, -- this is an actual ^V, type <C-v><C-v> in insert mode
        c = colors.orange,
        s = colors.purple,
        S = colors.purple,
        ["\19"] = colors.purple, -- this is an actual ^S, type <C-v><C-s> in insert mode
        R = colors.orange,
        r = colors.orange,
        ["!"] = colors.red,
        t = colors.red,
      },
      mode_fcolors = {
        n = fcolors.yellow,
        i = fcolors.green,
        v = fcolors.blue,
        V = fcolors.blue,
        ["\22"] = fcolors.blue, -- this is an actual ^V, type <C-v><C-v> in insert mode
        c = fcolors.magenta,
        s = fcolors.cyan,
        S = fcolors.cyan,
        ["\19"] = fcolors.cyan, -- this is an actual ^S, type <C-v><C-s> in insert mode
        R = fcolors.purple,
        r = fcolors.purple,
        ["!"] = fcolors.red,
        t = fcolors.red,
      },
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long
    provider = function(self)
      return " %-2(" .. self.mode_names[self.mode] .. "%)"
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_fcolors[mode], bold = true }
    end,
  }

  local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }
  -- We can now define some children separately and add them later

  local FileIcon = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(
        filename,
        extension,
        { default = true }
      )
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    init = function(self)
      self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
      self.home = vim.fn.getenv('HOME')
      if self.lfilename == "" then
        self.lfilename = "[No Name]"
      else
        -- replace: '/home/user' -> '~'
        -- self.lfilename = self.lfilename:gsub("/home/%w+", "~")
        self.lfilename = self.lfilename:gsub(self.home, "~")
      end
    end,
    hl = { fg = fcolors.cyan },

    utils.make_flexible_component(2, {
      provider = function(self)
        return self.lfilename
      end,
    }, {
      provider = function(self)
        return vim.fn.pathshorten(self.lfilename)
      end,
    }),
  }

  local FileFlags = {
    {
      provider = function()
        if not vim.bo.modifiable or vim.bo.readonly then
          return " "
        end
      end,
      hl = { fg = fcolors.red },
    },
  }

  local FileNameModifer = {
    hl = function()
      if vim.bo.modified then
        -- use `force` because we need to override the child's hl foreground
        return { fg = fcolors.cyan, bold = true, force = true }
      end
    end,
  }

  -- let's add the children to our FileNameBlock component
  FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    unpack(FileFlags) -- A small optimisation, since their parent does nothing
    -- { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
  )

  local FileType = {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = { bold = true },
  }

  local FileEncoding = {
    provider = function()
      local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc ~= "utf-8" and enc:upper()
    end,
  }

  local FileFormat = {
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt ~= "unix" and fmt:upper()
    end,
  }

  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { "b", "k", "M", "G", "T", "P", "E" }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize <= 0 then
        return "0" .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i])
    end,
  }

  local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
      local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
      return (ftime > 0) and os.date("%c", ftime)
    end,
  }

  local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P|%p = percentage through file of displayed window
    provider = "%3(%l%)/%-3(%L%):%2c %3(%p%)%%",
  }

  local LSPActive = {
    condition = conditions.lsp_attached,
    -- You can keep it simple,
    -- provider = " [LSP] ",
    -- Or complicate things a bit and get the servers names
    provider  = function(self)
      local names = {}
      for i, server in ipairs(vim.lsp.buf_get_clients(0)) do
        table.insert(names, server.name)
      end
      return " [" .. table.concat(names, " ") .. "] "
    end,
    hl = { fg = fcolors.green, bold = true },
  }

  local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
      error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
      warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
      info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
      hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
    },

    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    {
      provider = function(self)
        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
      end,
      hl = { fg = colors.diag.error },
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
      end,
      hl = { fg = colors.diag.warn },
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info .. " ")
      end,
      hl = { fg = colors.diag.info },
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints)
      end,
      hl = { fg = colors.diag.hint },
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
      provider = "  ", --  
      hl = { fg = fcolors.orange },
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
      provider = "(",
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and ("+" .. count)
      end,
      hl = { fg = colors.git.add },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and ("-" .. count)
      end,
      hl = { fg = colors.git.del },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and ("~" .. count)
      end,
      hl = { fg = colors.git.change },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = ")",
    },
  }

  local DAPMessages = {
    condition = function()
      if not pcall(require, "dap") then return false end
      local session = require("dap").session()
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
      if not pcall(require, "dap") then return "" end
      return " " .. require("dap").status()
    end,
    hl = { fg = utils.get_highlight("Debug").fg },
  }

  local WorkDir = {
    provider = function(self)
      self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
      local cwd = vim.fn.getcwd(0)
      self.cwd = vim.fn.fnamemodify(cwd, ":~")
    end,
    hl = { fg = fcolors.blue, bold = true },

    utils.make_flexible_component(1, {
      provider = function(self)
        local trail = self.cwd:sub(-1) == "/" and "" or "/"
        return self.icon .. self.cwd .. trail .. " "
      end,
    }, {
      provider = function(self)
        local cwd = vim.fn.pathshorten(self.cwd)
        local trail = self.cwd:sub(-1) == "/" and "" or "/"
        return self.icon .. cwd .. trail .. " "
      end,
    }, {
      provider = "",
    }),
  }

  local HelpFilename = {
    condition = function()
      return vim.bo.filetype == "help"
    end,
    provider = function()
      local filename = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = fcolors.blue },
  }

  local TerminalName = {
    -- condition = function()
    --     return vim.bo.buftype == 'terminal'
    -- end,
    -- icon = ' ', -- 
    provider = function()
      -- local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
      -- replace: '/home/user' -> '~'
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", ""):gsub("/home/%w+", "~")
      return " " .. tname
    end,
    hl = { fg = fcolors.blue, bold = true },
  }

  local Spell = {
    condition = function()
      return vim.wo.spell
    end,
    provider = "SPELL ",
    hl = { fg = fcolors.red, bold = true },
  }

  local Align = { provider = "%=" }
  local Space = { provider = " " }

  local LS = {
    -- WorkDir,
    FileNameBlock,
    { provider = "%<" },
    Git,
  }

  local RS = {
    FileType,
    Space,
    Ruler,
  }

  -- right side of inactive & other statuslines
  local RSO = {
    Align,
    RS,
    Space, -- for the same indent from right as with RSD in DefaultStatusline
  }

  ViMode = utils.surround({ "", "" }, fcolors.black, { ViMode })
  LSD = utils.surround({ "", "" }, fcolors.black, { LS })
  RSD = utils.surround({ "", "" }, fcolors.black, { RS })

  local DefaultStatusline = {
    ViMode,
    Space,
    Spell,
    LSD,
    Space,
    Diagnostics,
    Align,
    DAPMessages,
    Align,
    LSPActive,
    RSD,
  }

  local InactiveStatusline = {
    condition = function()
      return not conditions.is_active()
    end,
    -- { hl = { fg = fcolors.darkblue, force = true }, WorkDir },
    FileNameBlock,
    { provider = "%<" },
    RSO,
  }

  local SpecialStatusline = {
    condition = function()
      return conditions.buffer_matches({
        buftype = { "prompt", "quickfix" },
        filetype = { "^git.*", "fugitive" },
      })
    end,
    FileType,
    Space,
    HelpFilename,
    RSO,
  }

  local TerminalStatusline = {
    condition = function()
      return conditions.buffer_matches({ buftype = { "terminal" } })
    end,
    hl = { bg = colors.dark_red },
    { condition = conditions.is_active, ViMode, Space },
    FileType,
    Space,
    TerminalName,
    RSO,
  }

  local StatusLines = {
    hl = function()
      if conditions.is_active() then
        return {
          fg = fcolors.fg,
        }
      else
        return {
          fg = utils.get_highlight("StatusLineNC").fg,
          bg = utils.get_highlight("StatusLineNC").bg,
        }
      end
    end,

    init = utils.pick_child_on_condition,

    SpecialStatusline,
    TerminalStatusline,
    InactiveStatusline,
    DefaultStatusline,
  }

  heirline.setup(StatusLines)
end

M.setup()
return M
