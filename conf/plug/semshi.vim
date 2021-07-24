""" semshi plugin for python syntax
" configuration for the plugin numirias/semshi

" do not highlight variable under cursor, it is distracting
let g:semshi#mark_selected_nodes = 0
" do not show error sign since neomake is specialized for that
let g:semshi#error_sign          = v:false

