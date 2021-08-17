""" auto.vim
""" autogroups and autocommands
"*****************************************************************************
" autocmd
"*****************************************************************************
if !exists('autocommands_loaded')
    let autocommands_loaded = 1

    aug VimPlugAutoInstall
        if expand("$HOME") =~ '/home/' " to make sure that we are regular user (not root)
            if exists("$XDG_DATA_HOME")
                let PlugVimPath = $XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'
            else
                let PlugVimPath = glob('~/.local/share/nvim/site/autoload/plug.vim')
            endif
            if empty(PlugVimPath) " silently install vim-plug if file does not exist
                execute 'silent !curl -fL --create-dirs -o ' . PlugVimPath . \
                ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
            endif
        endif
    aug END

    aug HelpPages
        au!
        au FileType help nested call ILikeHelpToTheRight()
    aug END

    aug i3config_ft_detection
        au!
        au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
    aug END

    " close loclist/Quickfix - window when buffer is closed
    aug CloseLoclistWindowGroup
        au!
        " Close the window showing the location list for the current window
        au QuitPre * if empty(&buftype) | lclose | endif
        " Close the Quickfix window.
        au QuitPre * if empty(&buftype) | cclose | endif
    aug END

    " hide status line if vim-which-key plugin pop-up is shown
    aug WhichKeyHideStatusline
        au! FileType which_key
        au  FileType which_key set laststatus=0 noshowmode noruler
        \| au BufLeave <buffer> set laststatus=2 showmode ruler
    aug END

    " Disables automatic commenting on newline:
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " run xrdb whenever Xresources are updated.
    au BufWritePost \(*/.Xresources\|*/xres/*\) !xrdb ~/.Xresources

    " run wal right after previous xrdb when this specific file is updated.
    "au BufWritePost ~/.config/xres/core4w !wal -q -tn -i ~/.config/wallpaper.jpg

    " update binds when sxhkdrc is updated.
    au BufWritePost *sxhkdrc !pkill -USR1 sxhkd

    " Have dwmblocks automatically recompile and run when you edit this file in
    au BufWritePost ~/source/projects/core/fork/dwmblocks/config.h !cd ~/source/projects/core/fork/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

    " fix in case of memory leak vim issue. Should be at the end.
    au BufWinLeave * call clearmatches()
endif

