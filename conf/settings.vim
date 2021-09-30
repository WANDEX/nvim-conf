"*****************************************************************************
"" General
"*****************************************************************************
set shortmess=castWOI           " no intro message at startup & etc.
set number relativenumber       " Show relative line numbers
set linebreak                   " Break lines at word (requires Wrap lines)
set showbreak=>>>>              " Wrap-broken line prefix
set showmatch                   " Highlight matching brace
set visualbell                  " Use visual bell (no beeping)

set hlsearch                    " Highlight all search results
set ignorecase                  " Always case-insensitive
set smartcase                   " Enable smart-case search
set incsearch                   " Searches for strings incrementally
set inccommand=split            " :%s/foo/bar/ to preview substitute

set autoindent                  " Auto-indent new lines
set smartindent                 " Enable smart-indent
set smarttab                    " Enable smart-tabs
" set shiftwidth=4                " Number of auto-indent spaces
" set softtabstop=4               " Number of spaces per Tab
" set shiftround                  " Round the indentation nearest to shift width
" set expandtab                   " Use spaces instead of tabs

set splitbelow                  " Horizontal split below current.
set splitright                  " Vertical split to right of current.

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,cp1251,cp866,koi8-r,latin1,cp1250
set nobackup
set nowritebackup
set noswapfile

set undolevels=1000             " Number of undo levels
set backspace=indent,eol,start  " Backspace behavior

set laststatus=2                " Always display the status bar.
set ruler                       " Show row and column ruler information
set scrolloff=5                 " Show next 5 lines while scrolling.
set sidescrolloff=5             " Show next 5 columns while side-scrolling.

set showcmd                     " Display incomplete commands
set showtabline=2               " Always show tabline
set noshowmode
set wildmenu                    " Command line tab complete options as a menu.
set wildmode=list,full          " Enable autocompletion
set wildignore+=*.pyc,*_build/*,*/coverage/*,*.swp

set listchars=tab:>\ ,trail:~\,extends:>,precedes:<,nbsp:+
set list                        " Show problematic characters.
set nojoinspaces                " Use one space, not two, after punctuation.
set clipboard+=unnamedplus
set timeoutlen=800 " used by vim-which-key as timeout before showing guide popup

set foldlevel=2                 " how much levels of folding are open by default

"*****************************************************************************
"" Advanced
"*****************************************************************************
set lazyredraw " S P E E D ?
set termguicolors
" colorscheme xresources
colorscheme monokai_pro
set t_Co=256

let mapleader="\<SPACE>"
let maplocalleader="\\"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" fix: to be able to override formatoptions inherited from ftplugins
" ':verbose set formatoptions?' - to check for current filetype
" (https://github.com/neovim/neovim/issues/4684)
filetype plugin indent on

