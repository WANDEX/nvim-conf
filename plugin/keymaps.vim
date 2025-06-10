"*****************************************************************************
"" Extra Mappings
"*****************************************************************************

" easier moving of code blocks, without losing of selection block
vnoremap < <gv
vnoremap > >gv

" replace f/t with one-character Sneak,
" use ;/, to move forth/back 'justinmk/vim-sneak':
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"unmap in Select mode (to not break snippets expansion)
sunmap f|sunmap F|sunmap t|sunmap T

nnoremap <F3> <cmd>TagbarToggle<CR>

nnoremap <F4> <cmd>set relativenumber!<CR>

" toggle spell check F7 S-F7 C-F7
nnoremap <F7>  <cmd>setlocal spell! spelllang=en_us,ru_yo,ru_ru<CR>
nnoremap <F19> <cmd>setlocal spell! spelllang=en_us<CR>
nnoremap <F31> <cmd>setlocal spell! spelllang=ru_yo,ru_ru<CR>

" see encoding-values
menu Encoding.utf-8         <cmd>e ++enc=utf-8<CR>
menu Encoding.latin1        <cmd>e ++enc=latin1<CR>
menu Encoding.default       <cmd>e ++enc=default<CR>
menu Encoding.koi8-r        <cmd>e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251  <cmd>e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866         <cmd>e ++enc=cp866  ++ff=dos<CR>
" use TAB to cycle between menu variants
nnoremap <F8> :emenu Encoding.

" re-indent whole file / fix indentation, or V selection -> =
nnoremap <F12> gg=G''

" toggle highlight of word under the cursor
nnoremap <silent><expr><C-h> HighlightCword()

" add blank line below/above cursor without entering insert mode (returning to prev cursor line)
nnoremap <M-o> mjo<Esc>`j
nnoremap <M-O> mjO<Esc>`j

" 'moll/vim-bbye' plugin mappings
nnoremap <Leader>q <cmd>Bdelete<CR>
nnoremap <Leader>w <cmd>Bwipeout<CR>

" toggle between background transparency
nnoremap <silent> <localleader>b <cmd>call BgToggle()<CR>

" Clear trailing whitespace
nnoremap <localleader>cw <cmd>%s/\s\+$//g<CR><cmd>nohlsearch<CR>

" Colorizer toggle color highlight
nnoremap <localleader>Ct <cmd>ColorizerToggle<CR>

" toggle colored column at lines which character length exceed N
nnoremap <silent> <localleader>ct <cmd>call ColumnToggle()<CR>

" execute command and paste output in current buffer
nnoremap <silent> <localleader>P :call Paste('')<Left><Left>

" Save file as sudo on files that require root permission
cnoremap <C-w> execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Encode visual selection into qr code
vnoremap Q !curl -s -F-=\<- https://qrenco.de
