"*****************************************************************************
"" Core Mappings For Colemak
"*****************************************************************************
"" MEMO: use :verbose map 'key or sequence' - (imap) to see if mapping is used
"" hjkl remapped for colemak to
"" hnei i.e. left/down/up/right

" insert mode and modifier inside
nnoremap k i|xnoremap k i|onoremap k i|vnoremap k i
" nnoremap k i|onoremap k i|xnoremap k i

" go low
nnoremap gl L

" Forward towards the last letter of the word
nnoremap l e|onoremap l e|vnoremap l e
vnoremap l e|onoremap l e|vnoremap l e
nnoremap L E|onoremap L E|vnoremap L E
vnoremap L E|onoremap L E|vnoremap L E

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap <M-n> nzzzv
nnoremap <M-e> Nzzzv

" Move screen one page
nnoremap N <C-f>
nnoremap E <C-b>

" Move windows with C-Direction
nnoremap <C-W>n <C-W>j
nnoremap <C-W>e <C-W>k
nnoremap <C-W>h <C-W>h
nnoremap <C-W>i <C-W>l

nnoremap n j|xnoremap n j|onoremap n j|vnoremap n j
nnoremap e k|xnoremap e k|onoremap e k|vnoremap e k
nnoremap i l|xnoremap i l|onoremap i l|vnoremap i l
" nnoremap i l|xnoremap i l|onoremap i l

"" leave mappping to exit from all modes
onoremap <silent><script> <C-L> <Esc>
vnoremap <silent><script> <C-L> <Esc>
xnoremap <silent><script> <C-L> <Esc>
"" leave by canceling command
cnoremap <silent><script> <C-L> <C-c>
" original CTRL-L - Clears and redraws the screen.
" clear the highlighting of :set hlsearch & cmd line
nnoremap <silent><script> <C-L> <cmd>nohlsearch<CR><C-L>
" leave insert mode (+move cursor one char right)
inoremap <silent><script> <C-L> <Esc><right>

"*****************************************************************************
"" Extra Mappings
"*****************************************************************************

" replace f/t with one-character Sneak,
" use ;/, to move forth/back 'justinmk/vim-sneak':
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" TODO dont go to next buf if next buf is empty
" Move to next/previous bufpage :bnext,:bprev
nnoremap <silent>]b <cmd>bn<CR>
nnoremap <silent>[b <cmd>bp<CR>

" Move to next/previous tab :tabNext,:tabprevious
nnoremap <silent>]t <cmd>tabN<CR>
nnoremap <silent>[t <cmd>tabp<CR>

" create Qlist with word :vim bar %
" Jump to next/previous Quickfix list item :cn,:cp
nnoremap <silent>]q <cmd>cn<CR>
nnoremap <silent>[q <cmd>cp<CR>

" create Llist with word :lvim bar %
" Jump to next/previous Location list item :lne,:lp
nnoremap <silent>]l <cmd>lne<CR>
nnoremap <silent>[l <cmd>lp<CR>

" To navigate to the previous or next trailing whitespace
nnoremap ]w <cmd>NextTrailingWhitespace<CR>
nnoremap [w <cmd>PrevTrailingWhitespace<CR>

nnoremap <F3> <cmd>TagbarToggle<CR>

nnoremap <F4> <cmd>set relativenumber!<CR>

" run current python buffer in nvim term
"nnoremap <F5><F5> :vs <CR> :term python % <CR>
"nnoremap <F5>h :15sp <CR> :term python % <CR>

" toggle spell check
nnoremap <F7> <cmd>setlocal spell! spelllang=en_us<CR>

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

" easier terminal Esc
tnoremap <Esc> <C-\><C-n>
tnoremap <C-l> <C-\><C-n>

" easier moving of code blocks, without losing of selection block
vnoremap < <gv
vnoremap > >gv

" Reload vim configuration
nnoremap <localleader>rc <cmd>ReloadConfig<CR>

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
cnoremap W execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" unmap mouse wheel up
nmap <ScrollWheelUp> <nop>
imap <ScrollWheelUp> <nop>
vmap <ScrollWheelUp> <nop>
" unmap mouse wheel down
nmap <ScrollWheelDown> <nop>
imap <ScrollWheelDown> <nop>
vmap <ScrollWheelDown> <nop>

" Disable C-z suspend
map  <C-z> <nop>
map! <C-z> <nop>

" Disable Ex mode
nnoremap Q <nop>

" Encode visual selection into qr code
vnoremap Q !curl -s -F-=\<- https://qrenco.de

" CDC = Change to Directory of Current file
command CDC cd %:p:h

