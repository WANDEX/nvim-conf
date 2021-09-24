""" better-whitespace
" configuration for the plugin 'ntpeters/vim-better-whitespace'

let g:better_whitespace_enabled             = 1
let g:strip_whitespace_on_save              = 1
let g:strip_whitelines_at_eof               = 0
let g:show_spaces_that_precede_tabs         = 1
let g:current_line_whitespace_disabled_soft = 1
let g:better_whitespace_ctermcolor          = 'Gray'
let g:better_whitespace_guicolor            = 'Gray'
let g:strip_max_file_size                   = 1000
let g:better_whitespace_filetypes_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'man', 'magit']
let g:better_whitespace_operator = '<leader>dW'
