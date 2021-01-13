let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 4

let s:is_set_colors = v:false

function! s:set_colors()
  if !s:is_set_colors
    " ターミナルの背景色 #1B1D1F を元に調整
    highlight IndentGuidesEven guibg=#22252b guifg=grey30 ctermbg=235 ctermfg=black
    let s:is_set_colors = v:true
  endif
endfunction

function! s:on_enter()
  if strlen(&ft)
    call s:set_colors()
  else
    " fzf とかのバッファで変な感じでインデントが表示されないように
    " highlight はグローバルなので消したり表示したりしてなんとかする
    call s:clear_colors()
  endif
endfunction

function! s:restore_colors()
  if &ft == "fzf"
    call s:set_colors()
  endif
endfunction

function! s:clear_colors()
  if s:is_set_colors
    highlight IndentGuidesEven guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
    let s:is_set_colors = v:false
  endif
endfunction

autocmd VimEnter,Colorscheme * call s:on_enter()
autocmd BufEnter * call s:on_enter()
autocmd BufLeave * call s:restore_colors()
