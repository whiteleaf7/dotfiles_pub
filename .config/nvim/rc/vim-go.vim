" vim-go による <Shift-k> のドキュメント表示を無効に
" （coc-go で表示するため不要）
let g:go_doc_keywordprg_enabled = 0

let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
" let g:go_list_height = 5

let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_term_height = 10

let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1

function! s:register_command() abort
  command! -buffer -bang A call go#alternate#Switch(<bang>0, 'edit')
  command! -buffer -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  command! -buffer -bang AS call go#alternate#Switch(<bang>0, 'split')
  command! -buffer -bang AT call go#alternate#Switch(<bang>0, 'tabe')
endfunction

augroup VimGoSettings
  autocmd!
  au BufNewFile,BufRead *.go setlocal shiftwidth=4
  au FileType go nmap <leader>g [VimGo]
  au FileType go nmap [VimGo]g <Plug>(go-run)
  au FileType go nmap [VimGo]b <Plug>(go-build)
  au FileType go nmap [VimGo]t <Plug>(go-test)
  au FileType go nmap [VimGo]r <Plug>(go-test-func)
  au FileType go nmap [VimGo]c <Plug>(go-coverage-toggle)
  au FileType go nmap [VimGo]f <Plug>(go-files)
  au FileType go nmap [VimGo]d :GoDecls<CR>
  au FileType go nmap [VimGo]D :GoDeclsDir<CR>
  au FileType go nmap [VimGo]i <Plug>(go-info)
  au FileType go nmap [VimGo]v <Plug>(go-vet)

  au BufEnter *.go :call s:register_command()
augroup END
