""" deoplete
" configuration for the plugin Shougo/deoplete.nvim

" deoplete-jedi
let g:python3_host_prog      = '/usr/bin/python'
let g:loaded_python_provider = 1                "disable python 2 support


call deoplete#custom#source('_',
\   'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('_',
\   'sorters',  ['sorter_rank']) "or 'sorter_word'

" Use auto delimiter feature
call deoplete#custom#source('_', 'converters',
\  ['converter_auto_delimiter',
\   'converter_remove_overlap',
\   'converter_auto_paren'])

call deoplete#custom#option({
\   'min_pattern_length': 1,
\   'auto_complete_delay': 100,
\   'ignore_case': v:true,
\   'smart_case': v:true,
\   'max_list': 500,
\   'on_insert_enter': v:true,
\   'on_text_changed_i': v:true,
\   'refresh_always': v:false,
\   'prev_completion_mode': 'filter',
\   })

let g:deoplete#enable_at_startup             = 1    " Use deoplete.
let g:deoplete#sources#jedi#statement_length = 150  "Maximum length description
let g:deoplete#sources#jedi#enable_typeinfo  = 1    " If 0 faster!
let g:deoplete#sources#jedi#show_docstring   = 1    " if 1 causing comp. flickering
let g:deoplete#sources#jedi#python_path      = '/usr/bin/python'
"let g:deoplete#sources#jedi#extra_path =
let g:deoplete#sources#jedi#ignore_errors    = 0

inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <silent><expr> <C-Space> deoplete#manual_complete()
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

