""" vim-gtfo
" configuration for the plugin justinmk/vim-gtfo

" MEMO: How to Make gof working:
" to get ranger.desktop for gof
" curl --output-dir ~/Desktop/ --create-dirs -O https://raw.githubusercontent.com/ranger/ranger/master/doc/ranger.desktop
" edit Exec line to -> Exec=setsid -f st -e ranger
" if gof command opens dir in browser ->
" gio files path differ from xdg-open, so check 'man gio' and copy .desktop file into applications dir
" for me it's: $XDG_DATA_HOME/applications/mimeapps.list.
" add to mimeapps.list and mimeinfo.cache same two lines after [Default Applications] | [MIME Cache]
" application/x-directory=ranger.desktop;
" inode/directory=ranger.desktop;
" then -> check output of commands:
" gio mime inode/directory
" xdg-mime query default inode/directory

" for st -d workingdir patch required
let g:gtfo#terminals = { 'unix': 'setsid -f st -d' } " works both (got & goT)
