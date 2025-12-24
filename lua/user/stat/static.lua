-- AUTHOR: 'WANDEX/nvim-conf'

local ok, utils = pcall(require, 'heirline.utils')
if not ok then
  return -- guard
end

local M = {}

local g_hl = utils.get_highlight

function M.setup_colors()
  return {
    bright_bg  = g_hl('Folded').bg,
    bright_fg  = g_hl('Folded').fg,
    red        = g_hl('DiagnosticError').fg,
    dark_red   = g_hl('DiffDelete').bg,
    green      = g_hl('String').fg,
    blue       = g_hl('Function').fg,
    gray       = g_hl('NonText').fg,
    orange     = g_hl('Constant').fg,
    purple     = g_hl('Statement').fg,
    cyan       = g_hl('Special').fg,
    diag_warn  = g_hl('DiagnosticWarn').fg,
    diag_error = g_hl('DiagnosticError').fg,
    diag_hint  = g_hl('DiagnosticHint').fg,
    diag_info  = g_hl('DiagnosticInfo').fg,
    git_del    = g_hl('diffDeleted').fg,
    git_add    = g_hl('diffAdded').fg,
    git_change = g_hl('diffChanged').fg,
    f = { --- color palette of fixed colors
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
    },
  }
end

local c = M.setup_colors() -- compute at initialization

return vim.tbl_extend('force', M, {
  colors = c,
  static = {
    mode_names = {
      n         = ' N ',
      no        = ' N?',
      nov       = ' N?',
      noV       = ' N?',
      ['no\22'] = ' N?',
      niI       = ' Ni',
      niR       = ' Nr',
      niV       = ' Nv',
      nt        = ' Nt',
      v         = ' V ',
      vs        = ' Vs',
      V         = ' V_',
      Vs        = ' Vs',
      ['\22']   = ' ^V',
      ['\22s']  = ' ^V',
      s         = ' S ',
      S         = ' S_',
      ['\19']   = ' ^S',
      i         = ' I ',
      ic        = ' Ic',
      ix        = ' Ix',
      R         = ' R ',
      Rc        = ' Rc',
      Rx        = ' Rx',
      Rv        = ' Rv',
      Rvc       = ' Rv',
      Rvx       = ' Rv',
      c         = ' C ',
      cv        = ' Ex',
      r         = '...',
      rm        = ' M ',
      ['r?']    = ' ? ',
      ['!']     = ' ! ',
      t         = ' T ',
    },
    mode_colors = {
      n = c.red,
      i = c.green,
      v = c.cyan,
      V = c.cyan,
      ['\22'] = c.cyan, -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = c.orange,
      s = c.purple,
      S = c.purple,
      ['\19'] = c.purple, -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = c.orange,
      r = c.orange,
      ['!'] = c.red,
      t = c.red,
    },
    mode_fcolors = {
      n = c.f.yellow,
      i = c.f.green,
      v = c.f.blue,
      V = c.f.blue,
      ['\22'] = c.f.blue, -- this is an actual ^V, type <C-v><C-v> in insert mode
      c = c.f.magenta,
      s = c.f.cyan,
      S = c.f.cyan,
      ['\19'] = c.f.cyan, -- this is an actual ^S, type <C-v><C-s> in insert mode
      R = c.f.purple,
      r = c.f.purple,
      ['!'] = c.f.red,
      t = c.f.red,
    },
    d = {
      nbsp = ' ', spch = '─',
      c_kl = '', c_kr = '',
      sl_f = '', sl_b = '',
      t_ll = '', t_lr = '', t_ul = '', t_ur = '', -- :ple- | :pl-
    },
  },
})
