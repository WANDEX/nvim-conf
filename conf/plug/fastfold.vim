""" FastFold
" configuration for the plugin Konfekt/FastFold

" To ensure that sessions do not override the default fold method of the buffer file type (by the value manual)
set sessionoptions-=folds

" does not add default normal mode mapping that updates folds (zuz)
nmap <SID>(DisableFastFoldUpdate) <Plug>(FastFoldUpdate)

" fold mappings: go to next/prev folding and unfold it
nnoremap <silent>zn zczjza
nnoremap <silent>ze zczkza

" remove default: 'zj', 'zk' movements -> breaks vim-sneak dz.. yz.. mappings!
let g:fastfold_fold_movement_commands = [']z', '[z']

"let g:tex_fold_enabled=1
"let g:vimsyn_folding='af'
"let g:xml_syntax_folding = 1
"let g:javaScript_fold = 1
"let g:ruby_fold = 1
"let g:sh_fold_enabled= 7
"let g:php_folding = 1
"let g:perl_fold = 1
