" vim-airline
" configuration for the plugin vim-airline/vim-airline

" show buffer number for easier switching between buffer
" see https://github.com/vim-airline/vim-airline/issues/1149

let g:airline_theme='base16color' " .Xresources terminal colorscheme

let g:airline_powerline_fonts                    = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamecollapse   = 1 " full/col path in tab line
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#branch#enabled          = 1
let g:airline#extensions#branch#format           = 1
let g:airline#extensions#hunks#enabled           = 0
let g:airline#extensions#tagbar#enabled          = 0
let g:airline#extensions#neomake#enabled         = 1
let g:airline_skip_empty_sections                = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
    " unicode symbols
    let g:airline#extensions#tabline#left_sep       = ' '
    let g:airline#extensions#tabline#left_alt_sep   = '|'
    let g:airline_left_sep                          = ' '
    let g:airline_left_alt_sep                      = '»'
    let g:airline_right_sep                         = ' '
    let g:airline_right_alt_sep                     = '«'
    let g:airline#extensions#branch#prefix          = '⤴' "➔, ➥, ⎇
    let g:airline#extensions#readonly#symbol        = '⊘'
    let g:airline#extensions#linecolumn#prefix      = '¶'
    let g:airline#extensions#paste#symbol           = 'ρ'

    let g:airline_symbols.linenr                    = '␊'
    let g:airline_symbols.linenr                    = '␤'
    let g:airline_symbols.linenr                    = '¶'
    let g:airline_symbols.branch                    = '⎇'
    let g:airline_symbols.paste                     = 'ρ'
    let g:airline_symbols.paste                     = 'Þ'
    let g:airline_symbols.paste                     = '∥'
    let g:airline_symbols.whitespace                = 'Ξ'
else
    let g:airline#extensions#tabline#left_sep       = ''
    let g:airline#extensions#tabline#left_alt_sep   = ''
    let g:airline_left_sep                          = ''
    let g:airline_left_alt_sep                      = ''
    let g:airline_right_sep                         = ''
    let g:airline_right_alt_sep                     = ''
    "" powerline symbols
    "let g:airline#extensions#tabline#left_sep       = ''
    "let g:airline#extensions#tabline#left_alt_sep   = ''
    "let g:airline_left_sep                          = ''
    "let g:airline_left_alt_sep                      = ''
    "let g:airline_right_sep                         = ''
    "let g:airline_right_alt_sep                     = ''
    let g:airline_symbols.branch                    = ''
    let g:airline_symbols.readonly                  = ''
    let g:airline_symbols.linenr                    = ''
    let g:airline_symbols.paste                     = 'ρ'
    let g:airline_symbols.whitespace                = 'Ξ'
endif

