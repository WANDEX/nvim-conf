""" vim-xtabline
" configuration for the plugin 'mg979/vim-xtabline'

let g:xtabline_settings = get(g:, 'xtabline_settings', {})
" buffers mode by default, without arglist mode
let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']
let g:xtabline_settings.tab_number_in_left_corner = 0
let g:xtabline_settings.wd_type_indicator = 1
let g:xtabline_settings.tab_icon = ["", ""]
