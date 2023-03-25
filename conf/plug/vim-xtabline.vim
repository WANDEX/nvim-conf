""" vim-xtabline
" configuration for the plugin 'mg979/vim-xtabline'
" monochrome icons are mostly from old FontAwesome (fa-...)

let g:xtabline_settings = get(g:, 'xtabline_settings', {})
" buffers mode by default, without arglist mode
let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']
let g:xtabline_settings.tab_number_in_left_corner = 0
let g:xtabline_settings.last_open_first = 1
let g:xtabline_settings.recent_buffers = 14
let g:xtabline_settings.wd_type_indicator = 1
let g:xtabline_settings.tab_icon = ["", ""]
let g:xtabline_settings.indicators = {
    \ 'modified': '',
    \ 'pinned': '',
    \}
let g:xtabline_settings.icons = {
    \'book': '',
    \'build': '',
    \'check': '',
    \'cog': '',
    \'cogs': '',
    \'cross': '',
    \'database': '',
    \'exclamation': '',
    \'finish': '',
    \'fire': '',
    \'flag': '',
    \'git': '',
    \'hammer': '🔨',
    \'lens': '🔍',
    \'lightning': '',
    \'linux': '',
    \'lock': '',
    \'palette': '🎨',
    \'pin': '',
    \'star': '⭐',
    \'warning': '',
    \'windows': '',
    \'wrench': '',
    \}
