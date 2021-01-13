" nnoremap <silent> <Space>o :execute 'Deol' '-cwd='.fnamemodify(expand('%'), ':h') '-split=floating'<CR>
nnoremap <silent> <Space>o :Deol -split=horizontal<CR>
nnoremap <silent> <Space>i :Deol -split=vertical tig<CR>
tnoremap <silent> <C-[> <C-\><C-n>

augroup TerminalStuff
  autocmd!
  autocmd TermOpen * setlocal signcolumn=no
augroup END
