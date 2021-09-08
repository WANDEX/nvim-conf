""" vimagit
" configuration for the plugin jreybert/vimagit

let g:magit_show_magit_mapping='<leader>Mv'
" redefining E-edit -> O-open
let g:magit_edit_mapping='O'
let g:magit_jump_next_hunk='<C-N>'
let g:magit_jump_prev_hunk='<C-E>'

" original
"let g:magit_folding_toggle_mapping=[ '<CR>' ]
let g:magit_folding_toggle_mapping=[ '<C-O>', '<C-Z>' ]

let g:magit_commit_title_limit=69
let g:magit_scrolloff=5
let g:magit_refresh_gitgutter=0
let g:magit_default_fold_level=1
