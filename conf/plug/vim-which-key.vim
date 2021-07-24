""" :h vim-which-key
" configuration for the plugin liuchengxu/vim-which-key

" Executes native commands if keymap is not defined.
" For example, you can use `:WhichKey 'g'` and get `gg` work correct
let g:which_key_fallback_to_native_key = 1

"" Define prefix dictionary
let g:which_key_map =  {}
let g:which_key_map_local =  {}

call which_key#register(mapleader, "g:which_key_map")
call which_key#register(maplocalleader, "g:which_key_map_local")

"" vim-which-key
nnoremap <silent> <leader>         :WhichKey       mapleader<cr>
vnoremap <silent> <leader>         :WhichKeyVisual mapleader<cr>
nnoremap <silent> <localleader>    :WhichKey       maplocalleader<cr>
vnoremap <silent> <localleader>    :WhichKeyVisual maplocalleader<cr>
nnoremap <silent> <leader><leader> :WhichKey       nr2char(getchar())<cr>
vnoremap <silent> <leader><leader> :WhichKeyVisual nr2char(getchar())<cr>

""" create menus not based on existing mappings -> define new mappings

" Add a semicolon to the end of the line
nnoremap <leader>a; m'A;<esc>`'
""" add
let g:which_key_map.a = {
\ 'name' : '+add',
\ ';' : '$a;',
\ }

""" delete
let g:which_key_map.d = {
\ 'name' : '+delete',
\ 'd' : [':bd!', 'del buffer'],
\ }

""" LeaderF [f/b] / List[l/q] -> already mapped
let g:which_key_map.L = {
\ 'name' : '+LeaderF/List/Limeligh',
\ 'r' : [':LeaderfFile /', 'LeaderF /'],
\ 'L' : [':Limelight!!', 'Limelight!!'],
\ }

""" LanguageClient
let g:which_key_map.l = {
\ 'name' : '+lsp',
\ 'c' : {
    \ 'name': '+code',
    \ 'l' : ['LanguageClient#textDocument_codeLens()'       , 'code lens']                  ,
    \ 'a' : ['LanguageClient#handleCodeLensAction()'        , 'code lens action']           ,
    \ 'A' : ['LanguageClient#textDocument_codeAction()'     , 'code action']                ,
    \ },
\ 'C' : ['LanguageClient#clearDocumentHighlight()'          , 'clear highlighting']         ,
\ 'e' : ['LanguageClient#explainErrorAtPoint()'             , 'explain this error']         ,
\ 'f' : {
    \ 'name': '+format',
    \ 'd' : ['LanguageClient#textDocument_formatting()'     , 'format document']            ,
    \ 'l' : ['LanguageClient#textDocument_rangeFormatting()', 'format selected lines']      ,
    \ },
\ 'g' : {
    \ 'name': '+goto',
    \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']                 ,
    \ 'i' : ['LanguageClient#textDocument_implementation()' , 'implementation']             ,
    \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']            ,
    \ },
\ 'h' : ['LanguageClient#textDocument_hover()'              , 'hover']                      ,
\ 'H' : ['LanguageClient#textDocument_documentHighlight()'  , 'highlight']                  ,
\ 'm' : ['LanguageClient_contextMenu()'                     , 'menu']                       ,
\ 'r' : ['LanguageClient#textDocument_references()'         , 'references']                 ,
\ 'R' : ['LanguageClient#textDocument_rename()'             , 'rename']                     ,
\ 's' : ['LanguageClient#textDocument_documentSymbol()'     , 'document-symbol']            ,
\ 'w' : {
    \ 'name': '+workspace',
    \ 'e' : ['LanguageClient#workspace_applyEdit()'         , 'apply a workspace edit']     ,
    \ 'c' : ['LanguageClient#workspace_executeCommand()'    , 'execute a workspace command'],
    \ 's' : ['LanguageClient#workspace_symbol()'            , 'list of projects symbols']   ,
    \ },
\ }

""" Magit
let g:which_key_map.M = {
\ 'name' : '+Magit',
\ 'h' : ["magit#show_magit('h')", 'hrz'],
\ 'o' : ["magit#show_magit('c')", 'only'],
\ 'v' : ["magit#show_magit('v')", 'vrt'],
\ }

""" cheat
let g:which_key_map.C = {
\ 'name' : '+cht',
\ 'b' : ['cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 0, "!")', 'buffer'],
\ 'c' : ['cheat#navigate(0, "C")', 'comments toggle'],
\ 'e' : ['cheat#cheat("", -1, -1 , -1, 5, "!")', 'error explain'],
\ 'f' : {
    \ 'name': '+framework',
    \ 't' : ['cheat#frameworks#cycle(0)', 'cycle(0)'],
    \ 'T' : ['cheat#frameworks#autodetect(1)', 'autodetect'],
    \ },
\ 'n' : {
    \ 'name': '+next',
    \ 'q' : ['cheat#navigate(1,"Q")', 'question'],
    \ 'a' : ['cheat#navigate(1,"A")', 'answer'],
    \ 'h' : ['cheat#navigate(1,"H")', 'history'],
    \ 's' : ['cheat#navigate(1,"S")', 'see also'],
    \ 'f' : ['cheat#frameworks#cycle(1)', 'framework'],
    \ },
\ 'p' : {
    \ 'name': '+prev',
    \ 'q' : ['cheat#navigate(-1,"Q")', 'question'],
    \ 'a' : ['cheat#navigate(-1,"A")', 'answer'],
    \ 'h' : ['cheat#navigate(-1,"H")', 'history'],
    \ 's' : ['cheat#navigate(-1,"S")', 'see also'],
    \ 'f' : ['cheat#frameworks#cycle(-1)', 'framework'],
    \ },
\ 'P' : {
    \ 'name': '+paste',
    \ 'p' : ['cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 3, "!")', 'paste'],
    \ 'P' : ['cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 4, "!")', 'paste'],
    \ },
\ 'r' : ['cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 1, "!")', 'replace'],
\ }

nnoremap <leader>sr :%s///gc<Left><Left><Left><Left>
vnoremap <leader>sr :s///gc<Left><Left><Left><Left>
nnoremap <leader>ss :sort<cr>
vnoremap <leader>ss :sort<cr>
""" Search and Replace / sort visual selection
let g:which_key_map.s = {
\ 'name' : '+sort/replace',
\ 'r' : 'replace',
\ 's' : 'sort',
\ }

""" non existing mappings for manual visual selection
let g:which_key_map.t = {
\ 'name' : '+t/trans',
\ 'W' : ['TranslateW', 'Word'],
\ 'w' : [":'<,'>TranslateW", 'windowV'],
\ 'r' : [":'<,'>TranslateR", 'replaceV'],
\ 'x' : ['TranslateX', 'clipboard'],
\ 'l' : ['TranslateL', 'display log'],
\ 'a' : {
    \ 'name' : '+ -sl auto ',
    \ 'w' : [":'<,'>TranslateW source_lang=auto", 'windowV'],
    \ 'r' : [":'<,'>TranslateR source_lang=auto", 'replaceV'],
    \ 'x' : ['TranslateX source_lang=auto', 'clipboard'],
    \ '!' : {
        \ 'name' : '+trans!',
        \ 'w' : [":'<,'>TranslateW! source_lang=auto target_lang=en", 'windowV'],
        \ 'r' : [":'<,'>TranslateR! source_lang=auto target_lang=en", 'replaceV'],
        \ 'x' : ['TranslateX! source_lang=auto target_lang=en', 'clipboard'],
        \ },
    \ },
\ '!' : {
    \ 'name' : '+trans!',
    \ 'W' : ['TranslateW!', 'Word'],
    \ 'w' : [":'<,'>TranslateW!", 'windowV'],
    \ 'r' : [":'<,'>TranslateR!", 'replaceV'],
    \ 'x' : ['TranslateX!', 'clipboard'],
    \ },
\ 'N' : {
    \ 'name' : '+Ntrans',
    \ 'c' : ['Translate', 'cmd'],
    \ 'w' : ['TranslateW', 'window'],
    \ 'r' : ['TranslateR', 'replace'],
    \ '!' : {
        \ 'name' : '+Ntrans!',
        \ 'c' : ['Translate!', 'cmd'],
        \ 'w' : ['TranslateW!', 'window'],
        \ 'r' : ['TranslateR!', 'replace'],
        \ },
    \ },
\ }

""" window
let g:which_key_map.w = {
\ 'name' : '+window',
\ 't' : ['TabToNewWindow()', 'tab -> new Window'],
\ }

""" copy to X clipboard <= @" return last yanked text
let g:which_key_map.X = {
\ 'name' : '+X',
\ 'c' : [':call system("xclip -selection clipboard", @")', 'xclip'],
\ }

""" yank path of current file to system clipboard
let g:which_key_map.y = {
\ 'name' : '+yank',
\ 'p' : [':let @+ = expand("%:p") | :echom "Copied " . @+', 'file path'],
\ }


""" change description text in which-key pop-up menu on already existing mappings
"let g:which_key_map_local.l = {
"\ 'name' : '+local',
"\ 'c' : 'context-menu' ,
"\ }

