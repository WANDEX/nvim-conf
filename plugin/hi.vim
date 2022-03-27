" source this file, to override default highlights
" to make it across all colorschemes: au ColorScheme * nested source this_file_path
" (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
" MEMO: :call Paste('hi') - to search in output of :hi command
" also note: cterm=reverse gui=reverse

" disable background (to support transparent terminal background)
hi Normal guibg=NONE ctermbg=NONE

" general highlighting to use them as a link
hi GeneralBg    guibg=#16191D ctermbg=Black
hi GeneralFg    guifg=#8FBCBB ctermfg=Cyan
hi GeneralSel   guibg=#5C687A ctermbg=DarkGray
hi GeneralSub   guifg=#8FBCBB ctermfg=Cyan     guibg=#5C687A ctermbg=DarkGray
hi GeneralMod   guifg=DarkRed ctermfg=DarkRed  cterm=bold gui=bold
hi GeneralModS  guifg=DarkRed ctermfg=DarkRed  cterm=bold gui=bold guibg=#5C687A

hi! link Tabline Folded

" completion & etc.
hi Pmenu ctermfg=White ctermbg=DarkGray
hi! link PmenuSel GeneralSel

" which-key.nvim colorscheme:
hi WhichKey          ctermfg=Red      guifg=Red      ctermbg=NONE  guibg=NONE
hi WhichKeyGroup     ctermfg=White    guifg=White    ctermbg=Black guibg=Black
hi WhichKeySeparator ctermfg=DarkGray guifg=DarkGray ctermbg=NONE  guibg=NONE
hi WhichKeyDesc      ctermfg=Gray     guifg=Gray     ctermbg=Black guibg=Black
hi WhichKeyValue     ctermfg=Gray     guifg=Gray     ctermbg=Black guibg=Black
hi WhichKeyFloat     ctermfg=Gray     guifg=Gray     ctermbg=NONE  guibg=NONE
"
hi CmpDocumentation       cterm=reverse
hi CmpDocumentationBorder ctermbg=black

hi FloatBorder ctermfg=red  ctermbg=NONE guibg=NONE
hi NormalFloat ctermfg=gray ctermbg=NONE guibg=NONE

" for neomake & etc.
hi SignColumn ctermfg=14 guifg=Cyan ctermbg=NONE guibg=NONE

" diff & git signs
hi DiffAdd    ctermbg=NONE guibg=NONE ctermfg=Green guifg=Green
hi DiffChange ctermbg=NONE guibg=NONE ctermfg=White guifg=White
hi DiffDelete ctermbg=NONE guibg=NONE ctermfg=Red   guifg=Red
hi DiffText   cterm=bold ctermfg=0 ctermbg=11 gui=bold guibg=Red

" magit
hi DiffLine ctermfg=Gray guifg=Gray

hi diffAdded   ctermbg=NONE guibg=NONE ctermfg=LightGreen guifg=#98C379
hi diffChanged ctermbg=NONE guibg=NONE ctermfg=DarkGreen  guifg=#73BA9F
hi diffRemoved ctermbg=NONE guibg=NONE ctermfg=DarkRed    guifg=#D54E53

hi Folded     ctermfg=Gray guifg=Gray ctermbg=Black guibg=Black
hi Whitespace ctermfg=Gray guifg=Gray ctermbg=NONE guibg=NONE

hi IndentGuidesOdd  guifg=#282a36 ctermfg=238 gui=nocombine cterm=nocombine
hi IndentGuidesEven guifg=#383a46 ctermfg=242 gui=nocombine cterm=nocombine

hi EndOfBuffer ctermfg=DarkGray guifg=DarkGray ctermbg=NONE guibg=NONE
