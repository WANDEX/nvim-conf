""" auto.vim
""" autogroups and autocommands
"*****************************************************************************
" autocmd
"*****************************************************************************
if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    " nvim builtin yank highlight :h lua-highlight
    au TextYankPost * silent! lua vim.highlight.on_yank {timeout=1500}

    aug HelpPages
        au!
        au FileType help nested call ILikeHelpToTheRight()
    aug END

    " close loclist/Quickfix - window when buffer is closed
    aug CloseLoclistWindowGroup
        au!
        " Close the window showing the location list for the current window
        au QuitPre * if empty(&buftype) | lclose | endif
        " Close the Quickfix window.
        au QuitPre * if empty(&buftype) | cclose | endif
    aug END

    " Disables automatic commenting on newline:
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " run xrdb whenever Xresources are updated.
    au BufWritePost \(*/.Xresources\|*/xres/*\) !xrdb ~/.Xresources

    " run wal right after previous xrdb when this specific file is updated.
    "au BufWritePost ~/.config/xres/core4w !wal -q -tn -i ~/.config/wallpaper.jpg

    aug OverrideHighlights
        au!
        au ColorScheme * source ~/.config/nvim/conf/hi.vim
    aug END

    " update binds when sxhkdrc is updated.
    au BufWritePost *sxhkdrc !pkill -USR1 sxhkd

    " Have dwmblocks automatically recompile and run when you edit this file in
    au BufWritePost ~/source/projects/core/fork/dwmblocks/config.h !cd ~/source/projects/core/fork/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

    " fix in case of memory leak vim issue. Should be at the end.
    au BufWinLeave * call clearmatches()
endif

