"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin('~/.local/share/nvim/plugged')

"" format
"Plug 'brooth/far.vim' " didn't tried yet
Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

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
Plug 'mboughaba/i3config.vim'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' } " python

Plug 'jiangmiao/auto-pairs'
Plug 'Valloric/ListToggle'
Plug 'metakirby5/codi.vim'

"" motion
Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"" new text objects | more info: 'https://github.com/kana/vim-textobj-user/wiki'
Plug 'kana/vim-textobj-user'    " CORE
Plug 'kana/vim-textobj-indent'  " ai/ii aI/iI
Plug 'kana/vim-textobj-line'    " al/il
Plug 'kana/vim-textobj-entire'  " ae/ie
Plug 'glts/vim-textobj-comment' " ac/ic aC
Plug 'kana/vim-textobj-diff'    " adh/idh
Plug 'bps/vim-textobj-python'   " af/if ac/ic | [pf / ]pf [pc / ]pc

"" git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'

"" advanced (other)
Plug 'preservim/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'voldikss/vim-translator'
Plug 'mg979/vim-visual-multi' " This is awesome!
Plug 'farmergreg/vim-lastplace'
Plug 'justinmk/vim-gtfo'

Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'

"" Language Server Protocol support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"" completion
Plug 'Shougo/neco-vim' " completions for Vim commands
Plug 'deathlyfrantic/deoplete-spell' " for English word auto-completion
Plug 'davidhalter/jedi-vim' " python3 completions
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " javascript
Plug 'dbeniamine/cheat.sh-vim'

"" python code folding
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'

"" at the end
Plug 'liuchengxu/vim-which-key'
Plug 'neomake/neomake'

call plug#end()
