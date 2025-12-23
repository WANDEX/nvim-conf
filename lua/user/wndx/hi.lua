-- AUTHOR: 'WANDEX/nvim-conf'
-- MEMO: :call Paste('hi') - to search in output of :hi command

local M = {
  table = require('user.lib.fn').table,
}

function M.mod_hl_mrg(hl_name, opts)
  -- local hl_mrg = vim.api.nvim_get_hl(0, { name=hl_name })
  -- for k, v in pairs(opts) do
  --   hl_mrg[k] = v
  -- end
  -- return hl_mrg

  local hl = vim.api.nvim_get_hl(0, { name=hl_name })
  return vim.tbl_extend('force', hl, opts) -- XXX is this more effective?
end

--- modify highlight group by the name
--- without losing keys defined by the colorscheme or create new group.
function M.mod_hl(hl_name, opts)
  local hl_mrg = M.mod_hl_mrg(hl_name, opts)
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_set_hl(0, hl_name, hl_mrg)
end

--- link with link_name, then add additional highlight overrides.
--- link with link_name, warn about impossibility of additional highlight overrides.
function M.mod_lh(hl_name, link_name, opts)
  opts = opts or {}
  link_name = link_name or ''
  local hl_mrg = opts -- default
  if type(link_name) == 'string' and link_name ~= '' then
    hl_mrg = M.mod_hl_mrg(link_name, opts)
  elseif type(link_name) == 'table' then -- table with attributes provided!
    hl_mrg = M.te(link_name, opts)
    P(hl_mrg) -- XXX
    vim.notify('link_name == table', vim.log.levels.DEBUG)
  end
  if not M.table.empty(hl_mrg) then
    vim.api.nvim_set_hl(0, hl_name, hl_mrg)
    return
  end
  vim.notify(('mod_lh(%s) was not applied! MISUSE!'):format(hl_name), vim.log.levels.WARN)
  -- vim.notify(
  --   'link is used in combination with other attributes; ' ..
  --   'only the link will take effect! (see |:nvim_set_hl & :hi-link|).',
  --   vim.log.levels.WARN
  -- ) -- XXX: maybe it can actually using mod_hl approach!
end

--- e.g. mod_hl_all_has({ italic=false })
--- disable italic style in all highlights which has italic key.
function M.mod_hl_all_has(opts)
  local hl_defs = vim.api.nvim_get_hl(0, {})
  for hl_name, hl_def in pairs(hl_defs) do
    for k, v in pairs(opts) do
      if hl_def[k] ~= nil then
        hl_def[k] = v
      end
    end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  end
end

function M.wndx_colors()
  return {
    dred = { ctermfg='DarkRed',    fg='#FF4E53' }, -- fg='#590008' , guifg='NvimDarkRed',
    lred = { ctermfg='LightRed',   fg='#B04E53' }, -- fg='#FFC0B9' , guifg='NvimLightRed',

    dblu = { ctermfg='DarkBlue',   fg='#004C73' }, -- fg='#004C73' , guifg='NvimDarkBlue',
    lblu = { ctermfg='LightBlue',  fg='#8FBCBB' }, -- fg='#A6DBFF' , guifg='NvimLightBlue',

    dcyn = { ctermfg='DarkCyan',   fg='#73BA9F' }, -- fg='#007373' , guifg='NvimDarkCyan',
    lcyn = { ctermfg='LightCyan',  fg='#8CF8F7' }, -- fg='#8CF8F7' , guifg='NvimLightCyan',

    dgrn = { ctermfg='DarkGreen',  fg='#005523' }, -- fg='#005523' , guifg='NvimDarkGreen',
    lgrn = { ctermfg='LightGreen', fg='#98C379' }, -- fg='#B3F6C0' , guifg='NvimLightGreen',

    dgry = { ctermfg='Gray',       fg='#4F5258' }, -- fg='#4F5258' , guifg='NvimDarkGray4',
    lgry = { ctermfg='DarkGray',   fg='#9B9EA4' }, -- fg='#9B9EA4' , guifg='NvimLightGray4',

    gry2 = { ctermfg='White',      fg='#E0E2EA' }, -- fg='#E0E2EA' , guifg='NvimLightGray2',
    gry3 = { ctermfg='LightGray',  fg='#C4C6CD' }, -- fg='#C4C6CD' , guifg='NvimLightGray3',
  }
end

function M.nvim_colors()
  return {
    dred = { ctermfg='DarkRed',    fg='#590008' }, -- guifg='NvimDarkRed',
    lred = { ctermfg='LightRed',   fg='#FFC0B9' }, -- guifg='NvimLightRed',

    dblu = { ctermfg='DarkBlue',   fg='#004C73' }, -- guifg='NvimDarkBlue',
    lblu = { ctermfg='LightBlue',  fg='#A6DBFF' }, -- guifg='NvimLightBlue',

    dcyn = { ctermfg='DarkCyan',   fg='#007373' }, -- guifg='NvimDarkCyan',
    lcyn = { ctermfg='LightCyan',  fg='#8CF8F7' }, -- guifg='NvimLightCyan',

    dgrn = { ctermfg='DarkGreen',  fg='#005523' }, -- guifg='NvimDarkGreen',
    lgrn = { ctermfg='LightGreen', fg='#B3F6C0' }, -- guifg='NvimLightGreen',

    dgry = { ctermfg='Gray',       fg='#4F5258' }, -- guifg='NvimDarkGray4',
    lgry = { ctermfg='DarkGray',   fg='#9B9EA4' }, -- guifg='NvimLightGray4',

    gry2 = { ctermfg='White',      fg='#E0E2EA' }, -- guifg='NvimLightGray2',
    gry3 = { ctermfg='LightGray',  fg='#C4C6CD' }, -- guifg='NvimLightGray3',
  }
end

function M.te(...)
  return vim.tbl_extend('force', ...)
end

--- left unmapped:
---  @lsp.type.macro
---  @lsp.type.modifier
---  @lsp.type.namespace
---  @lsp.type.number
---  @lsp.type.regexp
function M.BlinkCmpKind()
  -- local c = M.nvim_colors()
  local w = M.wndx_colors()
  M.mod_hl('BlinkCmpKind',              M.te(w.lblu, {}))
  M.mod_lh('BlinkCmpKindClass',         '@lsp.type.class')
  M.mod_lh('BlinkCmpKindColor',         '@lsp.type.decorator')
  M.mod_lh('BlinkCmpKindConstant',      '@constant')
  M.mod_lh('BlinkCmpKindConstructor',   '@constructor')
  M.mod_lh('BlinkCmpKindEnum',          '@lsp.type.enum')
  M.mod_lh('BlinkCmpKindEnumMember',    '@lsp.type.enumMember')
  M.mod_lh('BlinkCmpKindEvent',         '@lsp.type.event')
  M.mod_lh('BlinkCmpKindField',         '@field')
  M.mod_lh('BlinkCmpKindFile',          '@lsp.type.comment')
  M.mod_lh('BlinkCmpKindFolder',        'BlinkCmpKindFile')
  M.mod_lh('BlinkCmpKindFunction',      '@lsp.type.function')
  M.mod_lh('BlinkCmpKindInterface',     '@lsp.type.interface')
  M.mod_lh('BlinkCmpKindKeyword',       '@lsp.type.keyword', { reverse=true }) -- FIXME
  -- M.mod_lh('BlinkCmpKindKeyword',       { reverse=true }) -- XXX
  M.mod_lh('BlinkCmpKindMethod',        '@lsp.type.method')
  M.mod_lh('BlinkCmpKindModule',        '@module')
  M.mod_lh('BlinkCmpKindOperator',      '@lsp.type.operator')
  M.mod_lh('BlinkCmpKindProperty',      '@lsp.type.property')
  M.mod_lh('BlinkCmpKindReference',     '@reference')
  M.mod_lh('BlinkCmpKindSnippet',       '@lsp.type.string')
  M.mod_lh('BlinkCmpKindStruct',        '@lsp.type.struct')
  M.mod_lh('BlinkCmpKindText',          '@text')
  M.mod_lh('BlinkCmpKindTypeParameter', '@lsp.type.typeParameter')
  M.mod_lh('BlinkCmpKindUnit',          '@lsp.type.type')
  M.mod_lh('BlinkCmpKindValue',         '@lsp.type.parameter')
  M.mod_lh('BlinkCmpKindVariable',      '@lsp.type.variable')
end

--- override theme highlights with the user highlights.
function M.highlights()
  local rvrs = { reverse=true }
  local bold = { bold=true    }
  local nobg = { bg=''        }
  local c = M.nvim_colors()
  local w = M.wndx_colors()
  local grbg = { ctermbg='Gray', bg='#303040' }
  local gwbg = { ctermbg='Gray', bg='#303F40' }

  -- vim.api.nvim_set_hl(0, 'Normal', { link='TSConstant' })

  -- disable background (for the transparent terminal background)
  M.mod_hl('Normal', nobg)
  -- transparent telescope bg across all themes
  M.mod_hl('TelescopeNormal', { link='Normal' })

  M.mod_hl('Tabline',       M.te(nobg, {}))
  M.mod_hl('XTFill',        { link='Tabline' })
  -- M.mod_hl('XTHidden', { link='Tabline' })

  M.mod_hl('Statusline',    M.te(nobg, {}))
  M.mod_hl('StatusLine',    { link='Statusline' })
  M.mod_hl('StatusLineNC',  { link='Statusline' })
  -- M.mod_hl('StatusLineTerm',       { link='Statusline' })
  -- M.mod_hl('StatusLineTermNC',     { link='Statusline' })
  -- M.mod_hl('NvimTreeStatusLine',   { link='Statusline' })
  -- M.mod_hl('NvimTreeStatusLineNC', { link='Statusline' })

  -- general select highlighting to use as a link
  M.mod_hl('GeneralSel',    M.te(nobg, c.lgry, rvrs, bold))

  -- completion & etc.
  M.mod_hl('Pmenu',         M.te(nobg, c.gry2))
  M.mod_hl('PmenuSel',      { link='GeneralSel' })

  -- which-key.nvim colorscheme:
  M.mod_hl('WhichKey',          M.te(nobg, w.dred))
  M.mod_hl('WhichKeyGroup',     M.te(nobg, c.gry2))
  M.mod_hl('WhichKeySeparator', M.te(nobg, c.gry3))
  M.mod_hl('WhichKeyDesc',      M.te(nobg, c.dgry))
  M.mod_hl('WhichKeyValue',     M.te(nobg, c.dgry))
  M.mod_hl('WhichKeyFloat',     M.te(nobg, c.dgry))

  -- hi CmpDocumentation       cterm=reverse
  -- hi CmpDocumentationBorder ctermbg=black

  M.mod_hl('FloatBorder', c.lred)
  M.mod_hl('NormalFloat', c.lgry)

  -- for neomake & etc.
  M.mod_hl('SignColumn',  c.lgry)

  -- diff, git signs, bold DiffText without bg.
  M.mod_hl('DiffLine',    M.te(nobg, c.gry3))
  M.mod_hl('DiffText',    gwbg)
  M.mod_hl('DiffChange',  grbg)

  M.mod_hl('DiffAdd',     M.te(nobg, w.lgrn))
  M.mod_hl('DiffDelete',  M.te(nobg, w.lred))

  -- vimagit
  M.mod_hl('diffAdded',   { link='DiffAdd' })
  M.mod_hl('diffRemoved', { link='DiffDelete' })

  -- Neogit
  -- diffRemoved    xxx guifg=#ff6188
  -- diffAdded      xxx guifg=#a9dc76
  -- @text          xxx guifg=#a9dc76
  -- @text.diff.add xxx guifg=#3d5213
  -- @text.diff.delete xxx guifg=#4a0f23
  -- @text.danger   xxx gui=bold guifg=#fd6883
  -- @tag.attribute xxx guifg=#a9dc76

  -- @diff          xxx cleared
  -- @diff.plus     xxx links to Added
  -- Added          xxx ctermfg=10 guifg=NvimLightGreen
  -- @diff.minus    xxx links to Removed
  -- Removed        xxx ctermfg=9 guifg=NvimLightRed
  -- @diff.delta    xxx links to Changed
  -- Changed        xxx ctermfg=14 guifg=NvimLightCyan
  -- @tag           xxx guifg=#ff6188
  -- @tag.builtin   xxx links to Special

  M.mod_hl('IndentGuidesOdd',  M.te(nobg, {fg='#282a36', ctermfg=238, nocombine=true}))
  M.mod_hl('IndentGuidesEven', M.te(nobg, {fg='#383a46', ctermfg=242, nocombine=true}))

  --- set the color of hidden special characters. But not 'listchars' whitespace.
  --- unprintable characters: Text displayed differently from what it really is.
  M.mod_hl('SpecialKey', M.te(c.lred, rvrs))

	--- |hl-NonText| highlighting will be used for 'eol', 'extends' and 'precedes'.
  M.mod_hl('NonText',    { link='IndentGuidesOdd' })
  --- |hl-Whitespace| for 'nbsp', 'space', 'tab', 'multispace', 'lead' and 'trail'.
  M.mod_hl('Whitespace', { link='IndentGuidesEven' })

  M.mod_hl('DRED',  M.te(nobg, w.dred, rvrs))
  M.mod_hl('LRED',  M.te(nobg, w.lred, rvrs))

  M.BlinkCmpKind()
end

function M.main()
  M.mod_hl_all_has({ italic=false })
  M.highlights()
end

return M
