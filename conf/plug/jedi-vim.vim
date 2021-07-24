""" jedi-vim
" configuration for the plugin davidhalter/jedi-vim

" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled    = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#show_call_signatures   = 0

