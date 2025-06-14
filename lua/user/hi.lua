-- source this file, to override default highlights
-- to make it across all colorschemes: au ColorScheme * nested source this_file_path
-- (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
-- MEMO: :call Paste('hi') - to search in output of :hi command
-- also note: cterm=reverse gui=reverse


-- src: https://gist.github.com/lkhphuc/ea6db0458268cad1493b2674cb0fda51
-- Due to the way different colorschemes configure different highlights group,
-- there is no universal way to add gui options to all the desired components.
-- Findout the final highlight group being linked to and update gui option.
local function mod_hl(hl_name, opts)
  local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  if is_ok then
    for k,v in pairs(opts) do hl_def[k] = v end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  end
end

local function wndx_clrs()
  -- local wndx_bold = { cterm='bold',         bold=true }
  -- local wndx_bold = { cterm={'bold'},         bold=true }
  -- local wndx_nobg = { ctermbg='NONE',       bg='' }
  -- local wndx_rvrs = { cterm={'reverse'},      reverse=true }
  local wndx_rvrs = {       reverse=true }
  local wndx_bold = {       bold=true }
  local wndx_nobg = {       bg='' }
  local wndx_dred = { ctermfg='DarkRed',    fg='#FF4E53' }
  local wndx_lred = { ctermfg='LightRed',   fg='#B04E53' }
  local wndx_dcyn = { ctermfg='DarkCyan',   fg='#73BA9F' }
  local wndx_lcyn = { ctermfg='LightCyan',  fg='#8FBCBB' }
  local wndx_lgrn = { ctermfg='LightGreen', fg='#98C379' }

  local wndx_dgry = { ctermfg='DarkGray',   fg='#5C687A' }
  local wndx_lgry = { ctermfg='LightGray',  fg='#8FBCBB' }

  local wndx_whit = { ctermfg='White',      fg='NvimLightGray2' }
  local wndx_gry3 = { ctermfg='LightGray',  fg='NvimLightGray3' }

  local te = function(...)
    return vim.tbl_extend('force', ...)
  end

  -- vim.api.nvim_set_hl(0, "Normal", { link="TSConstant" })

  -- disable background (for the transparent terminal background)
  vim.api.nvim_set_hl(0, "Normal", wndx_nobg)
  -- transparent telescope bg across all themes
  vim.api.nvim_set_hl(0, "TelescopeNormal", { link="Normal" })

  vim.api.nvim_set_hl(0, "Tabline", { link="Folded" })

  -- general highlighting to use them as a link
  -- vim.api.nvim_set_hl(0, "GeneralSel", { wndx_dgry.ctermfg, wndx_dgry.fg })
  vim.api.nvim_set_hl(0, "GeneralSel", wndx_dgry)

  -- completion & etc.
  vim.api.nvim_set_hl(0, "Pmenu",    { ctermfg='White', ctermbg='DarkGray' }) -- FIXME
  vim.api.nvim_set_hl(0, "PmenuSel", { link="GeneralSel" })

  -- which-key.nvim colorscheme:
  vim.api.nvim_set_hl(0, "WhichKey",          te(wndx_nobg, wndx_dred))
  vim.api.nvim_set_hl(0, "WhichKeyGroup",     te(wndx_nobg, wndx_whit))
  vim.api.nvim_set_hl(0, "WhichKeySeparator", te(wndx_nobg, wndx_gry3))
  vim.api.nvim_set_hl(0, "WhichKeyDesc",      te(wndx_nobg, wndx_dgry))
  vim.api.nvim_set_hl(0, "WhichKeyValue",     te(wndx_nobg, wndx_dgry))
  vim.api.nvim_set_hl(0, "WhichKeyFloat",     te(wndx_nobg, wndx_dgry))

  -- hi CmpDocumentation       cterm=reverse
  -- hi CmpDocumentationBorder ctermbg=black

  vim.api.nvim_set_hl(0, "FloatBorder", wndx_lred)
  vim.api.nvim_set_hl(0, "NormalFloat", wndx_dcyn)

  -- for neomake & etc.
  vim.api.nvim_set_hl(0, "SignColumn",  wndx_dcyn)


  -- diff, git signs, bold DiffText without bg.
  vim.api.nvim_set_hl(0, "DiffLine",    te(wndx_nobg, wndx_gry3))
  vim.api.nvim_set_hl(0, "DiffText",    te(wndx_nobg, wndx_bold))
  vim.api.nvim_set_hl(0, "DiffAdd",     te(wndx_nobg, wndx_lgrn))
  vim.api.nvim_set_hl(0, "DiffChange",  te(wndx_nobg, wndx_dcyn))
  vim.api.nvim_set_hl(0, "DiffDelete",  te(wndx_nobg, wndx_lred))

  -- vimagit
  vim.api.nvim_set_hl(0, "diffAdded",   { link="DiffAdd" })
  vim.api.nvim_set_hl(0, "diffRemoved", { link="DiffDelete" })

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

end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = vim.api.nvim_create_augroup('Color', {}),
  pattern = "*",
  callback = function()
    local is_italic = false
    mod_hl("TSKeywordReturn",   { bold=true, italic=is_italic })
    mod_hl("TSConstBuiltin",    { bold=true, italic=is_italic })
    mod_hl("TSFuncBuiltin",     { bold=true, italic=is_italic })
    mod_hl("TSTypeBuiltin",     { bold=true, italic=is_italic })
    mod_hl("TSBoolean",         { bold=true, italic=is_italic })

    mod_hl("TSType",            { bold=true })
    mod_hl("TSConstructor",     { bold=true })
    mod_hl("TSOperator",        { bold=true })

    mod_hl("TSInclude",         { italic=is_italic })
    mod_hl("TSVariableBuiltin", { italic=is_italic })
    mod_hl("TSConditional",     { italic=is_italic })
    mod_hl("TSKeyword",         { italic=is_italic })
    mod_hl("TSKeywordFunction", { italic=is_italic })
    mod_hl("TSComment",         { italic=is_italic })
    mod_hl("TSParameter",       { italic=is_italic })

    mod_hl("semshiBuiltin",     { italic=is_italic })
    -- vim.api.nvim_set_hl(0, "semshiImported", {link="TSConstant"})
    -- mod_hl("semshiImported", { bold=true, })
    vim.api.nvim_set_hl(0, "semshiAttribute", { link="TSAttribute" })

    -- mod_hl("TSVariable",        { bold=false, italic=false, })
    -- mod_hl("Folded", { bg="" })
    wndx_clrs()
  end
})

vim.cmd [[ silent! colorscheme monokai_pro ]]
