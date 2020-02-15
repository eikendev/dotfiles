" Reload all buffers and enable syntax highlighting again.
command! ReloadAndSyntaxOn :e | :syntax on
command! ReloadAllBuffers :call self#misc#buffer_do('ReloadAndSyntaxOn') | :syntax on

command! TryWrite call self#command#try_write#()

command! VimEdit :e $MYVIMRC
command! VimSource :source $MYVIMRC

command! CdGit call self#command#cd_git#(v:false)
command! CdFile :cd %:p:h

" Write with root permissions.
command! W :w suda://%
command! Wq :W | :q

" TODO: Resize to relative size.
command! -nargs=* Gc :exec "Gcommit --verbose " . <q-args> | resize 30 | startinsert

command! ToggleQuickfixList call self#command#toggle_somelist#('quickfix')
command! ToggleLocationList call self#command#toggle_somelist#('location')

command! ToggleHexEdit call self#command#toggle_hex_edit#()
command! ToggleConceallevel call self#command#toggle_conceallevel#()

command! SmartClose call self#command#smart_close#()

" Toggle semicolon at the end of the line.
command! ToggleSemicolon call self#misc#toggle_end_char(';') | call repeat#set("\<Plug>(self-toggle-semicolon)")
nnoremap <silent> <Plug>(self-toggle-semicolon) :ToggleSemicolon<CR>

command! TerminalOpen call self#terminal#open#()
command! TerminalToggle call self#terminal#toggle#()
command! -nargs=* -complete=shellcmd TerminalExecute call self#terminal#execute#(<q-args>)

command! TmuxOpen call self#terminal#tmux_open#()
command! TmuxToggle call self#terminal#tmux_toggle#()
command! -nargs=* -complete=shellcmd TmuxExecute call self#terminal#tmux_execute#(<q-args>)
