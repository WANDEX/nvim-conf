"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin('~/.local/share/nvim/plugged')

"" visual
Plug 'jeffkreeftmeijer/vim-dim' " (Xresources) consistent term colors w invers
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'ap/vim-css-color'
Plug 'lilydjwg/colorizer'
Plug 'kabbamine/vcoolor.vim'
Plug 'machakann/vim-highlightedyank'

"" syntax
Plug 'kovetskiy/sxhkd-vim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " python

Plug 'Valloric/ListToggle'
Plug 'metakirby5/codi.vim'

"" advanced (other)
Plug 'preservim/tagbar'
Plug 'voldikss/vim-translator'
Plug 'mg979/vim-visual-multi' " This is awesome!
Plug 'farmergreg/vim-lastplace'
Plug 'justinmk/vim-gtfo'

" Plug 'dbeniamine/cheat.sh-vim'

call plug#end()
