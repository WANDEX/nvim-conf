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

" END. {{{1
" vim: foldmethod=marker
