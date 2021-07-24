""" editorconfig
" configuration for the plugin editorconfig/editorconfig-vim

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

aug EditorConfig
    au!
    au FileType gitcommit let b:EditorConfig_disable = 1
aug END
