let g:goyo_width = 90

nnoremap <silent> \p :Goyo<CR>

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    silent !tmux set status off
  endif
  set showmode
  set noshowcmd
  " set scrolloff=999
  " set nolist
  silent! :IndentGuidesDisable
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set noshowmode
  set showcmd
  " set scrolloff=5
  " set list
  silent! IndentGuidesEnable
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
