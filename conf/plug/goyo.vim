""" goyo.vim
" configuration for the plugin junegunn/goyo.vim

let g:goyo_width  = 112 " (default: 80)
let g:goyo_height = 85  " (default: 85%)
let g:goyo_linenr = 0   " (default: 0)

function! s:goyo_enter()
    set noshowcmd
    set scrolloff=999
    Limelight
    NeomakeClean " hide warnings highlights etc.
endfunction

function! s:goyo_leave()
    set showcmd
    set scrolloff=5
    Limelight!
    AirlineRefresh
    "e
endfunction

aug goyo_enter_leave
    au!
    au User GoyoEnter nested call <SID>goyo_enter()
    au User GoyoLeave nested call <SID>goyo_leave()
aug END

nnoremap <silent> <localleader>gy :Goyo<CR>

