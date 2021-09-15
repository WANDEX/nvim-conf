" source this file, to override default highlights
" to make it across all colorschemes: au ColorScheme * nested source this_file_path
" (https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f)
" MEMO: :call Paste('hi') - to search in output of :hi command
" also note: cterm=reverse gui=reverse

" disable background (to support transparent terminal background)
hi Normal guibg=NONE ctermbg=NONE

" completion & etc.
hi Pmenu ctermfg=White ctermbg=DarkGray

" which-key.nvim colorscheme:
hi WhichKey          ctermfg=Red      guifg=Red      ctermbg=NONE  guibg=NONE
hi WhichKeyGroup     ctermfg=White    guifg=White    ctermbg=Black guibg=Black
hi WhichKeySeparator ctermfg=Darkgray guifg=DarkGray ctermbg=NONE  guibg=NONE
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

hi Folded ctermfg=Gray guifg=Gray

hi IndentGuidesOdd  guifg=#282a36 ctermfg=238 gui=nocombine cterm=nocombine
hi IndentGuidesEven guifg=#383a46 ctermfg=242 gui=nocombine cterm=nocombine

hi EndOfBuffer ctermfg=DarkGray guifg=DarkGray ctermbg=NONE guibg=NONE
