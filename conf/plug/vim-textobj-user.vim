""" kana/vim-textobj-user
" configuration for the plugin textobj-user and related plugins based on it!

" fix 'inside' modifier for vim-textobj-indent in colemak layout
xmap ak <Plug>(textobj-indent-a)
omap ak <Plug>(textobj-indent-a)
xmap kk <Plug>(textobj-indent-i)
omap kk <Plug>(textobj-indent-i)

" fix 'inside' modifier for vim-textobj-python in colemak layout
xmap kf <Plug>(textobj-python-function-i)
omap kf <Plug>(textobj-python-function-i)
xmap kc <Plug>(textobj-python-class-i)
omap kc <Plug>(textobj-python-class-i)

