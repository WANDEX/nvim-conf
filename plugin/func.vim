""" func.vim
""" function definitions

"clear the last used search pattern +(remove pattern highlighting)
fu! ClearLastSearch()
    let @/ = ""
endf
com! CLS call ClearLastSearch()

" reload vim configuration
if !exists('*ReloadConfig')
    function! ReloadConfig()
        echom 'Reload configuration...'
        luafile $MYVIMRC
    endfunction
    command! ReloadConfig call ReloadConfig()
endif

" clear cmd line message
fu! s:EmptyMess(timer)
    if mode() ==# 'n'
        echon ''
    endif
endf

" clear cmd line message after timer in seconds
fu! EmptyMessTimer(sec)
    let l:sec = a:sec * 1000
    call timer_start(l:sec, funcref('s:EmptyMess'))
endf

" execute command and return output
" !!! vim 8+ has built-in execute()
" let l:h = Exec('hi Normal')
" if l:h =~ 'cleared' ...
fu! Exec(command)
    redir =>output
    silent exec a:command
    redir END
    return output
endf

" use execute() and return only last line of output
" let b:neomake_javascript_eslint_exe = LastLine('!npm-exec -p eslint')
" :echo LastLine('buffers')
fu! LastLine(command)
    let l:v = remove(split(execute(a:command, 'silent!'), '\n'), -1)
    return l:v
endf

" execute command and paste output in current buffer
" :call Paste('hi')
fu! Paste(command)
    redir =>output
    silent exec a:command
    redir END
    let @o = output
    execute "put o"
    return ''
endf

" help to right
fu! ILikeHelpToTheRight()
    if !exists('w:help_is_moved') || w:help_is_moved != "right"
        wincmd L
        let w:help_is_moved = "right"
    endif
endf

" open help in full-window view. If current buffer is not empty, open a new tab
fu! HelpTab(...)
    let cmd = 'tab help %s'
    if bufname('%') ==# '' && getline(1) ==# ''
        let cmd = 'help %s | only'
    endif
    exec printf(cmd, join(a:000, ' '))
endf
command! -nargs=* -complete=help H call HelpTab(<q-args>)

" toggle between background transparency
fu! BgToggle()
    if Exec('hi Normal') =~ 'guibg=Black'
        hi Normal guibg=NONE ctermbg=NONE
    else
        hi Normal guibg=Black ctermbg=0
    endif
endf

" toggle colored column at lines which character length exceed N
fu! ColumnToggle()
    if exists('w:longLineS')
        "silent! call clearmatches()
        silent! call matchdelete(w:longLineS)
        silent! call matchdelete(w:longLineB)
        unlet! w:longLineS w:longLineB
        echo '[OFF] too long columns highlight.'
    else
        let w:longLineS=matchadd('ErrorMsg', '\%81v\+', -1)
        let w:longLineB=matchadd('ErrorMsg', '\%121v\+', -1)
        echo '[ON] too long columns highlight.'
    endif
endf

" open a file in a new vim instance
fu! LaunchVimInstance(...)
    let l:paths = join(a:000, ' ')
    exec 'silent! !$TERMINAL -e /bin/env nvim ' . l:paths
endf
command! -count -nargs=* LaunchVimInstance  call LaunchVimInstance(<q-args>)

" convert the current tab to a new vim instance
fu! TabToNewWindow()
    let l:quit = 0
    let l:path = expand('%:p')
    if l:path ==# ''
        echom 'No file in buffer'
        return
    endif
    if &modified
        echom 'Write file before moving to new window?'
        echohl ErrorMsg | echom 'Unsaved changes will be lost!' | echohl None
        while 1
            let choice = inputlist(['1: Yes', '2: No', '3: Cancel'])
            if choice > 3
                redraw!
                echohl WarningMsg | echo 'Please enter a number between 1 and 3' | echohl None
                continue
            elseif choice == 0 || choice == 3
                return
            elseif choice == 1
                write
            endif
            break
        endwhile
    endif
    try
        confirm pclose!
        confirm close!
    catch
        echom 'This is the last window. Quit vim after opening new window?'
        while 1
            let choice = inputlist(['1: Yes', '2: No', '3: Cancel'])
            if choice > 3
                redraw!
                echohl WarningMsg | echo 'Please enter a number between 1 and 3' | echohl None
                continue
            elseif choice == 0 || choice == 3
                return
            elseif choice == 1
                let l:quit = 1
            endif
            confirm enew!
            break
        endwhile
    endtry
    call LaunchVimInstance(l:path)
    if l:quit == 1
        confirm quit!
    endif
endf

fu! InstallVimPlug()
    if expand("$HOME") =~ '/home/' " to make sure that we are regular user (not root)
        if exists("$XDG_DATA_HOME")
            let PlugVimPath = $XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'
        else
            let PlugVimPath = glob('~/.local/share/nvim/site/autoload/plug.vim')
        endif
        if !filereadable(PlugVimPath) " silently install vim-plug if file or parent dirs does not exist
            execute 'silent !curl -fL --create-dirs -o ' . PlugVimPath .
            \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        endif
    endif
endf
command! InstallVimPlug call InstallVimPlug()

fu! LastSearchCount() abort
    " update search indexes [current/total] and return string (without 99 limit)
    let result = searchcount(#{maxcount: 0})
    if empty(result)
        return ''
    endif
    if result.incomplete ==# 1     " timed out
        return printf('/%s [?/??]', @/)
    elseif result.incomplete ==# 2 " max count exceeded
        if result.total > result.maxcount && result.current > result.maxcount
            return printf('[>%d/>%d]', result.current, result.total)
        elseif result.total > result.maxcount
            return printf('[%d/>%d]',  result.current, result.total)
        endif
    endif
    return printf('[%d/%d]', result.current, result.total)
endf

fu! ShowSearchIndexes()
    " echo right justified info about search indexes
    let l:search = LastSearchCount()
    let l:pad = v:echospace - strwidth(l:search)
    let l:format = "%"..l:pad.."s%s"
    echo printf(l:format, ' ', l:search)
endf
