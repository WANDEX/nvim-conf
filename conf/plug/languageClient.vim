""" :h languageClient
" configuration for the plugin autozimu/LanguageClient-neovim

set hidden
let g:LanguageClient_serverCommands    = {
\   'python': ['~/.local/bin/pyls'],
\   }
"\   'python': ['pyls'],

let g:LanguageClient_changeThrottle    = 5

" linters and fixers are from other plugins, no need in extra gutter signs!
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_autoStart         = 1 " Automatically start language servers.

aug LanguageClient_config
    au!
    au User LanguageClientStarted setlocal signcolumn=yes
    au User LanguageClientStopped setlocal signcolumn=auto
aug END

