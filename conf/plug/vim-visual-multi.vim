""" vim-visual-multi
" configuration for the plugin mg979/vim-visual-multi

let g:VM_maps = {}

" use these built-in mappings for all cursors
let g:VM_custom_noremaps = {'==': '==', '<<': '<<', '>>': '>>'}

" cursor mode only!
" change surroundings is built in, so add other commands with motions & etc.
let VM_user_operators = [
\   {'cs': 2}, {'cS': 2}, {'ys': 3}, {'yS': 3}, {'ds': 1}, {'ca': 1}, {'ck': 1}, {'da': 1}, {'dk': 1},
\   ]

" remap for colemak layout
let g:VM_custom_motions = {
\   'h': 'l',
\   'i': 'l',
\   'l': 'e',
\   'L': 'E',
\   }

" remap preserving original function
let g:VM_custom_remaps = {
\   '<M-S-I>': '<M-S-Right>',
\   '<M-S-H>': '<M-S-Left>',
\   }

let g:VM_maps["i"] = 'K' " insert
let g:VM_maps["Exit"] = '<C-l>' " leave/exit mode

" enable undo/redo
let g:VM_maps["Undo"] = 'u'
let g:VM_maps["Redo"] = '<C-r>'

let g:VM_maps["Find Next"] = '<Enter>'
let g:VM_maps["Find Prev"] = '<BS>'

let g:VM_maps['Find Under']          = '<C-j>' " replace C-n
let g:VM_maps['Find Subword Under']  = '<C-j>' " replace visual C-n

let g:VM_maps["Add Cursor Down"]     = '<C-n>'
let g:VM_maps["Add Cursor Up"]       = '<C-e>'

let g:VM_maps["Erase Regions"]       = '\\gr'
