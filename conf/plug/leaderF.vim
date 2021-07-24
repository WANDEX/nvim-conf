""" leaderF
" configuration for the plugin Yggdroot/LeaderF

let g:Lf_CacheDirectory = $XDG_CACHE_HOME
"let g:Lf_StlColorscheme = 'powerline'
"let g:Lf_StlSeparator   = { 'left': '', 'right': '' }

let g:Lf_ShortcutF = '<Leader>Lf'
let g:Lf_ShortcutB = '<Leader>Lb'

" <C-V> - open in vertical split
let g:Lf_CommandMap     = {
    \               '<C-K>': ['<C-E>'],
    \               '<C-J>': ['<C-N>'],
    \               '<C-V>': ['<C-B>'],
    \               '<C-]>': ['<C-V>'],
    \ }

" after pressing TAB: u - move up one dir, h - move to home dir
let g:Lf_NormalMap      = {
    \ "File":   [["u", ':LeaderfFile ..<CR>'],
    \            ["h", ':LeaderfFile ~<CR>'],
    \            ["e", ':LeaderfFile /etc/<CR>'],
    \            ["r", ':LeaderfFile /<CR>'],
    \           ],
    \ }

