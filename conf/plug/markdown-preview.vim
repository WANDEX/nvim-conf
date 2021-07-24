""" iamcco/markdown-preview.nvim
" configuration for the plugin iamcco/markdown-preview.nvim

" do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0

nmap <localleader>mp <Plug>MarkdownPreview
nmap <localleader>ms <Plug>MarkdownPreviewStop
nmap <localleader>mt <Plug>MarkdownPreviewToggle

