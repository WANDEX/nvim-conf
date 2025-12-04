"*****************************************************************************
"" Extra Mappings
"*****************************************************************************

" see encoding-values
menu Encoding.utf-8         <cmd>e ++enc=utf-8<CR>
menu Encoding.latin1        <cmd>e ++enc=latin1<CR>
menu Encoding.default       <cmd>e ++enc=default<CR>
menu Encoding.koi8-r        <cmd>e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251  <cmd>e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866         <cmd>e ++enc=cp866  ++ff=dos<CR>
" <C-F1>==<F25> | use TAB to cycle between menu variants
nnoremap <F25> :emenu Encoding.


" execute command and paste output in current buffer
nnoremap <silent> <localleader>P :call Paste('')<Left><Left>

" Save file as sudo on files that require root permission
cnoremap <C-w> execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Encode visual selection into qr code
vnoremap <silent> <localleader>Q !curl -s -F-=\<- https://qrenco.de
