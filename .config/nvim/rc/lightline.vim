"
" Lightline.vim configuration
"
set guioptions-=e
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

      " \ 'colorscheme': 'mycolor',
      " \ 'colorscheme': 'default',
      " \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filepath' ], [ 'bufferlist' ] ],
      \   'right': [ [ 'lineinfo', 'percent' ],
      \              [ ],
      \              [ 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filepath' ] ],
      \   'right': [ [ 'percent' ],
      \              [ 'filetype' ] ]
      \ },
      \ 'subseparator': { 'left': "│", 'right': '\uf47d' },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'myfilename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'bufferlist': 'BufferListComponent',
      \   'filepath': 'FilePath',
      \   'gitbranch': 'FugitiveHead',
      \ }
      \ }

let g:lightline.component = {
      \   'lineinfo': 'L %3l',
      \   'dir': '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)',
      \ }
" let g:lightline.component.dir = '%.35(%{expand("%:h:s?\\S$?\\0/?")}%)'

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? ' +' : &modifiable ? '' : ' -'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\uf023" : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \  &ft == 'unite' ? unite#get_status_string() : 
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand("%:h:s?\\S$?\\0/?").expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" 要 tpope/vim-fugitive
function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo'
    let branch_name = FugitiveHead()
    " https://www.nerdfonts.com/cheat-sheet
    " https://github.com/ryanoasis/nerd-fonts/wiki/Codepoint-Conflicts#new-codepoints
    return strlen(branch_name) ? "\uf418 ".branch_name : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return  &ft == 'unite' ? 'Unite' :
          \ &ft == 'vimfiler' ? 'VimFiler' :
          \ &ft == 'vimshell' ? 'VimShell' :
          \ &ft == 'denite' ? 'Denite' :
          \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! BufferListComponent()
    "return expand('%:n')
    return ''
    let bufferlist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufferlist[winnr - 1]
endfunction

let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ] }

let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

function! FilePath()
  let fullpath = expand("%:s")
  let filename = expand("%:t")

  if !empty(matchstr(fullpath, "^term://"))
    let process_name = split(filename, ":")[-1]
    return process_name . " [running]"
  endif

  if winwidth(0) > 90
    return fullpath . MyModified()
  else
    return filename . MyModified()
  endif
endfunction

"let g:lightline.tab_component_function = {
"    \ 'buflist' : 'Mline_buflist',
"}
"let g:lightline.tab_component_function = {}
"let g:lightline.tab_component_function.prefix = 'TalPrefix'
"function! TalPrefix(n)
"  return lightline#tab#tabnum(a:n). TalTabwins(a:n)
"endfunction
"function! TalTabwins(n)
"  return repeat(',', len(tabpagebuflist(a:n)))
"endfunction
"
"let g:lightline.tab_component_function.filename = 'TalFilename'
"function! TalFilename(n)
"  return '['.TalBufnum(a:n).']'. substitute(lightline#tab#filename(a:n), '.\{16}\zs.\{-}\(\.\w\+\)\?$', '~\1', '')
"endfunction
"function! TalBufnum(n)
"  let buflist = tabpagebuflist(a:n)
"  let winnr = tabpagewinnr(a:n)
"  return buflist[winnr - 1]
"endfunction
