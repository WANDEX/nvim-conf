""" kana/vim-textobj-user
" configuration for the plugin textobj-user and related plugins based on it!
" contains fixes for colemak layout!

" vim-textobj-indent {{{1
let g:textobj_indent_no_default_key_mappings = 1
omap ak <Plug>(textobj-indent-a)
omap kk <Plug>(textobj-indent-i)
omap kI <Plug>(textobj-indent-same-i)
xmap ak <Plug>(textobj-indent-a)
xmap kk <Plug>(textobj-indent-i)
xmap kI <Plug>(textobj-indent-same-i)

" vim-textobj-python {{{1
let g:textobj_python_no_default_key_mappings = 1
call textobj#user#map('python', {
\   'class': {
\     'select-a': '<buffer>ac',
\     'select-i': '<buffer>kc',
\     'move-n': '<buffer>]pc',
\     'move-p': '<buffer>[pc',
\   },
\   'function': {
\     'select-a': '<buffer>af',
\     'select-i': '<buffer>kf',
\     'move-n': '<buffer>]pf',
\     'move-p': '<buffer>[pf',
\   }
\ })

" vim-textobj-entire {{{1
let g:textobj_entire_no_default_key_mappings = 1
omap ae <Plug>(textobj-entire-a)
omap ke <Plug>(textobj-entire-i)
xmap ae <Plug>(textobj-entire-a)
xmap ke <Plug>(textobj-entire-i)

" vim-textobj-line {{{1
let g:textobj_line_no_default_key_mappings = 1
omap al <Plug>(textobj-line-a)
omap kl <Plug>(textobj-line-i)
xmap al <Plug>(textobj-line-a)
xmap kl <Plug>(textobj-line-i)

" vim-textobj-line {{{1
let g:textobj_line_no_default_key_mappings = 1
omap al <Plug>(textobj-line-a)
omap kl <Plug>(textobj-line-i)
xmap al <Plug>(textobj-line-a)
xmap kl <Plug>(textobj-line-i)

" END. {{{1
" vim: foldmethod=marker
