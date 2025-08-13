-- AUTHOR: 'WANDEX/nvim-conf'
-- source this file, to override default highlights
-- to make it across all colorschemes: au ColorScheme * nested source this_file_path
-- (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
-- MEMO: :call Paste('hi') - to search in output of :hi command
-- also note: cterm=reverse gui=reverse

-- modify highlight group by the name
-- without losing keys defined by the colorscheme or create new group.
local function mod_hl(hl_name, opts)
  local hl_def = vim.api.nvim_get_hl(0, { name=hl_name })
  for k, v in pairs(opts) do
    hl_def[k] = v
  end
  vim.api.nvim_set_hl(0, hl_name, hl_def)
end

-- e.g. mod_hl_all_has({ italic=false })
-- disable italic style in all highlights which has italic key.
local function mod_hl_all_has(opts)
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

local function wndx_colors()
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

local function nvim_colors()
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

local function highlights()
  -- local rvrs = { cterm={'reverse'},      reverse=true }
  -- local bold = { bold=true, cterm='bold',   }
  -- local bold = { bold=true, cterm={'bold'}, }
  -- local nobg = { bg='',     ctermbg='NONE', }
  local rvrs = { reverse=true }
  local bold = { bold=true    }
  local nobg = { bg=''        }
  local c = nvim_colors()
  local w = wndx_colors()
  local grbg = { ctermbg='Gray', bg='#303040' }
  local gwbg = { ctermbg='Gray', bg='#303F40' }

  local te = function(...)
    return vim.tbl_extend('force', ...)
  end

  -- vim.api.nvim_set_hl(0, "Normal", { link="TSConstant" })

  -- disable background (for the transparent terminal background)
  mod_hl("Normal", nobg)
  -- transparent telescope bg across all themes
  mod_hl("TelescopeNormal", { link="Normal" })

  mod_hl("Tabline",     { link="Folded" })

  -- general select highlighting to use as a link
  mod_hl("GeneralSel",  te(nobg, c.lgry, rvrs, bold))

  -- completion & etc.
  mod_hl("Pmenu",       te(nobg, c.gry2))
  mod_hl("PmenuSel",    { link="GeneralSel" })

  -- which-key.nvim colorscheme:
  mod_hl("WhichKey",          te(nobg, w.dred))
  mod_hl("WhichKeyGroup",     te(nobg, c.gry2))
  mod_hl("WhichKeySeparator", te(nobg, c.gry3))
  mod_hl("WhichKeyDesc",      te(nobg, c.dgry))
  mod_hl("WhichKeyValue",     te(nobg, c.dgry))
  mod_hl("WhichKeyFloat",     te(nobg, c.dgry))

  -- hi CmpDocumentation       cterm=reverse
  -- hi CmpDocumentationBorder ctermbg=black

  mod_hl("FloatBorder", c.lred)
  mod_hl("NormalFloat", c.lgry)

  -- for neomake & etc.
  mod_hl("SignColumn",  c.lgry)

  -- diff, git signs, bold DiffText without bg.
  mod_hl("DiffLine",    te(nobg, c.gry3))
  mod_hl("DiffText",    gwbg)
  mod_hl("DiffChange",  grbg)

  mod_hl("DiffAdd",     te(nobg, w.lgrn))
  mod_hl("DiffDelete",  te(nobg, w.lred))

  -- vimagit
  mod_hl("diffAdded",   { link="DiffAdd" })
  mod_hl("diffRemoved", { link="DiffDelete" })

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

  mod_hl("IndentGuidesOdd",  te(nobg, {fg='#282a36', ctermfg=238, nocombine=true}))
  mod_hl("IndentGuidesEven", te(nobg, {fg='#383a46', ctermfg=242, nocombine=true}))
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = vim.api.nvim_create_augroup('Color', {}),
  pattern = "*",
  callback = function()
    mod_hl_all_has({ italic=false })
    highlights()
  end
})

vim.cmd [[ silent! colorscheme monokai_pro ]]
