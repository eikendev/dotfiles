" Reload all buffers and enable syntax highlighting again.
command! ReloadAndSyntaxOn :e | :syntax on
command! ReloadAllBuffers :call self#misc#buffer_do('ReloadAndSyntaxOn') | :syntax on

command! TryWrite call self#command#try_write#()

command! VimEdit :e $MYVIMRC
command! VimSource :source $MYVIMRC

command! CdGit call self#command#cd_git#(v:false)
command! CdFile :cd %:p:h

command! ToggleQuickfixList call self#command#toggle_somelist#('quickfix')
command! ToggleLocationList call self#command#toggle_somelist#('location')

command! ToggleConceallevel call self#command#toggle_conceallevel#()

command! SmartClose call self#command#smart_close#()

" Toggle semicolon at the end of the line.
command! ToggleSemicolon call self#misc#toggle_end_char(';') | call repeat#set("\<Plug>(self-toggle-semicolon)")
nnoremap <silent> <Plug>(self-toggle-semicolon) :ToggleSemicolon<CR>

command! -nargs=1 PreserveNormal call self#mapping#preserve#normal(<q-args>)
command! -nargs=1 PreserveExecute call self#mapping#preserve#execute(<q-args>)
