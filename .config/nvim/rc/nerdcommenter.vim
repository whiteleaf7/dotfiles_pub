" https://github.com/preservim/nerdcommenter

let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'

nmap gc <Plug>NERDCommenterToggle
vmap gc <Plug>NERDCommenterToggle

" MEMO:
" 強制的にコメントアウトするなら <leader>cc
" アンコメントするなら <leader>cu
