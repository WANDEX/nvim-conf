"*****************************************************************************
"" Core Mappings For Colemak
"*****************************************************************************
"" MEMO: use :verbose (map/imap) 'key or sequence' - to see if mapping is used
"" hjkl remapped for colemak to
"" hnei i.e. left/down/up/right

" insert mode and modifier inside
noremap <silent> k i

" go low
noremap gl L

" Forward towards the last letter of the word
noremap <silent> l e
noremap <silent> L E

" make zz command silent -> to not clear cmd
nnoremap <silent> zz zz

" Search next/prev result, center on the screen, echo/update search indexes
noremap <silent> <M-n> nzz<cmd>call ShowSearchIndexes()<CR>
noremap <silent> <M-e> Nzz<cmd>call ShowSearchIndexes()<CR>

" Move screen one page
noremap <silent> N <C-f>
noremap <silent> E <C-b>

" prev command
cnoremap <C-E> <C-P>

" Create new empty buffer window. (then disable default mapping)
noremap <C-W><C-N> <C-W>n|map <C-W>n <nop>

" Go to window in direction (then disable original mapping)
noremap <C-W>n <C-W>j|map <C-W>j <nop>
noremap <C-W>e <C-W>k|map <C-W>k <nop>
noremap <C-W>i <C-W>l|map <C-W>l <nop>

" Move window in direction (then disable original mapping)
noremap <C-W>N <C-W>J|map <C-W>J <nop>
noremap <C-W>E <C-W>K|map <C-W>K <nop>
noremap <C-W>I <C-W>L|map <C-W>L <nop>

" colemak home row movement
noremap <silent> n j
noremap <silent> e k
noremap <silent> i l

"" leave mappping to exit from all modes
onoremap <silent><script> <C-L> <Esc>
vnoremap <silent><script> <C-L> <Esc>
"" leave by canceling command
cnoremap <silent><script> <C-L> <C-c>
" original CTRL-L - Clears and redraws the screen.
" clear the highlighting of :set hlsearch & cmd line
nnoremap <silent><script> <C-L> <cmd>nohlsearch<CR><C-L>
" leave insert mode (+move cursor one char right)
inoremap <silent><script> <C-L> <Esc><right>
"" easier terminal Esc
tnoremap <silent> <Esc> <C-\><C-n>
tnoremap <silent> <C-l> <C-\><C-n>

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
cnoremap <C-w> execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

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

