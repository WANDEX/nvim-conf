-- AUTHOR: 'WANDEX/nvim-conf'

-- good idea to set following early in the config, because otherwise
-- any mappings set BEFORE doing this, will be set to the OLD Leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

--============================================================================
-- GENERAL
--============================================================================

vim.opt.backup      = false
vim.opt.writebackup = false
vim.opt.swapfile    = false

vim.opt.shortmess   = 'castWOI'       -- no intro message at startup & etc
vim.opt.number      = true
vim.opt.relativenumber = true         -- Show relative line numbers
vim.opt.linebreak   = true            -- Break lines at word (req Wrap lines)
vim.opt.showbreak   = '>>>>'          -- Wrap-broken line prefix
vim.opt.showmatch   = true            -- Highlight matching brace
vim.opt.visualbell  = true            -- Use visual bell (no beeping)

vim.opt.hlsearch    = true            -- Highlight all search results
vim.opt.ignorecase  = true            -- Always case-insensitive
vim.opt.smartcase   = true            -- Enable smart-case search
vim.opt.incsearch   = true            -- Searches for strings incrementally
vim.opt.inccommand  = 'split'         -- :%s/foo/bar/ to preview substitute

vim.opt.autoindent  = true            -- Auto-indent new lines
vim.opt.smartindent = true            -- Enable smart-indent
vim.opt.smarttab    = true            -- Enable smart-tabs

vim.opt.splitbelow  = true            -- Horizontal split below current
vim.opt.splitright  = true            -- Vertical split to right of current

vim.opt.showtabline = 2               -- Always show tabline
vim.opt.laststatus  = 2               -- Always display the status bar
vim.opt.ruler       = true            -- Show row and column ruler information

vim.opt.showcmd     = true            -- Display incomplete commands
vim.opt.showmode    = false

vim.opt.background  = 'dark'
vim.opt.backspace   = 'indent,eol,start' -- Backspace behavior
vim.opt.foldlevel   = 2     -- how much levels of folding are open by default
vim.opt.joinspaces  = true  -- Use one space, not two, after punctuation etc

vim.opt.timeout     = false -- disable timeout -> fixes 'q:' '<nop>' rebind!
vim.opt.timeoutlen  = 800   -- timeout before something
vim.opt.undolevels  = 1000  -- Number of undo levels

vim.opt.scrolloff     = 5   -- Show next 5 lines   while      scrolling
vim.opt.sidescrolloff = 5   -- Show next 5 columns while side-scrolling

vim.opt.clipboard:append { 'unnamedplus' }

vim.opt.list  = true         -- Show problematic characters
local unicode = true
if unicode then
  vim.opt.listchars = {
    lead     = '·',
    extends  = '›',
    nbsp     = '+', -- '␣'
    precedes = '‹',
    tab      = '↦ ', -- '→ '
    trail    = '~',
  }
else -- ascii
  vim.opt.listchars = {
    lead     = '.',
    extends  = '>',
    nbsp     = '+',
    precedes = '<',
    tab      = '> ',
    trail    = '~',
  }
end

vim.opt.wildignore:append {
  '*.pyc', 'node_modules', '*build/*', '*/coverage/*', '*.swp'
}
vim.opt.wildmenu = true     -- Command line tab complete options as a menu
vim.opt.wildmode = { 'list' , 'full' }

--============================================================================
-- ADVANCED
--============================================================================

vim.opt.fileencodings = 'ucs-bom,utf-8,default,cp1251,koi8-r,latin1,cp1250,cp866'
vim.opt.fileencoding  = 'utf-8'
vim.opt.encoding      = 'utf-8'

vim.opt.lazyredraw    = false -- T R U E => S P E E D ?
vim.opt.termguicolors = true

