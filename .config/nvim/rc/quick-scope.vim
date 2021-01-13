
" 指定したキーを押した時のみハイライトする
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" let g:qs_lazy_highlight = 1
let g:qs_second_highlight = 0
let g:qs_buftype_blacklist = ['terminal', 'nofile']

augroup qs_colors
  autocmd!

  " autocmd ColorScheme * highlight QuickScopePrimary   gui=underline cterm=underline ctermfg=221 guifg=#f0c674
  " autocmd ColorScheme * highlight QuickScopeSecondary gui=underline cterm=underline ctermfg=12  guifg=#15aabf

  " autocmd ColorScheme * highlight QuickScopePrimary   gui=underline cterm=underline ctermfg=221 guifg=#f0c674
  " autocmd ColorScheme * highlight QuickScopeSecondary                               ctermfg=12  guifg=#15aabf

  autocmd ColorScheme * highlight QuickScopePrimary    ctermfg=9   guifg=#ea0050
  autocmd ColorScheme * highlight QuickScopeSecondary  ctermfg=12  guifg=#15aabf
  autocmd ColorScheme * highlight QuickScopeCursor     ctermfg=16  ctermbg=8 guifg=#222222 guibg=#888888
augroup END
