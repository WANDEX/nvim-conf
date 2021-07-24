""" NERDTree
" configuration for the plugin scrooloose/nerdtree

" disable bookmark and 'press ? for help ' text
let NERDTreeMinimalUI  = 1
" the ignore patterns are regular expression strings and separated by comma
let NERDTreeIgnore     = ['\.pyc$', '^__pycache__$', '\~$']
" show current root as relative path from $HOME in NERDTree status bar
let NERDTreeStatusline = "%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

let NERDTreeMapOpenExpl     = "E"
let NERDTreeMapOpenSplit    = "v"       " default is i
let NERDTreeMapPreviewSplit = "gv"      " default is gi
let NERDTreeMapCloseDir     = "h"
let NERDTreeMenuDown        = "n"
let NERDTreeMenuUp          = "e"
let NERDTreeMapActivateNode = "i"


" close NERDTree
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \ b:NERDTree.isTabTree()) | q | endif

" If more than one window and previous buffer was NERDTree, go back to it.
au BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

" Nerdtree mappings.
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>

