""" auto.vim
""" autogroups and autocommands
"*****************************************************************************
" autocmd
"*****************************************************************************
if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    " aug AutoClearCmd
    "     au!
    "     au BufWritePost * call EmptyMessTimer(1)
    "     au BufWinEnter  * call EmptyMessTimer(3)
    "     au CmdlineLeave * call EmptyMessTimer(5)
    " aug END

    " aug MiscGroup
    "     au!
    "     "" Disables automatic commenting on newline:
    "     au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " aug END

    aug HelpPages
        au!
        au FileType help nested call ILikeHelpToTheRight()
    aug END

    "" close loclist/Quickfix - window when buffer is closed
    " aug CloseLoclistWindowGroup
    "     au!
    "     "" Close the window showing the location list for the current window
    "     au QuitPre * if empty(&buftype) | lclose | endif
    "     "" Close the Quickfix window.
    "     au QuitPre * if empty(&buftype) | cclose | endif
    " aug END

    aug AutoCompileGroup
        au!
        "" run xrdb whenever Xresources are updated.
        au BufWritePost \(*/.Xresources\|*/xres/*\) !xrdb ~/.Xresources

        "" run wal right after previous xrdb when this specific file is updated.
        "au BufWritePost ~/.config/xres/core4w !wal -q -tn -i ~/.config/wallpaper.jpg

        "" update binds when sxhkdrc is updated.
        au BufWritePost *sxhkdrc !pkill -USR1 sxhkd

        "" Have dwmblocks automatically recompile and run when you edit this file in
        au BufWritePost ~/source/projects/core/fork/dwmblocks/config.h
        \ !cd ~/source/projects/core/fork/dwmblocks/;
        \ sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
    aug END

endif
