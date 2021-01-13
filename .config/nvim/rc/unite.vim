"
" Unite.vim
"
let g:unite_winheight = 18
let g:unite_source_file_mru_limit = 300
" let g:unite_source_line_enable_highlight = 1
call unite#custom#profile("default", "context", {
            \ "start_insert": 1,
            \ "direction": "botright",
            \ "prompt": "≫ ",
            \ "prompt_direction": "top",
            \ })
call unite#custom#profile("file", "context", {
            \ "prompt": "# ",
            \ })
call unite#custom#default_action('file,buffer' , 'open')
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
let g:unite_source_grep_max_candidates = 200
let g:unite_source_menu_menus = {
            \ "shortcut": {
            \       "description": "my shortcut",
            \       "command_candidates": [
            \           ["edit init.vim", "edit $MYVIMRC"],
            \           ["edit dein.toml", "edit ".g:dein_toml],
            \           ["edit dein_lazy.toml", "edit ".g:dein_lazy_toml],
            \           ["edit unite.vim", "edit ~/.config/nvim/rc/unite.vim"],
            \           ["edit .zshrc", "edit ~/.zshrc"],
            \           ["edit tmux.conf", "edit ~/.config/tmux/tmux.conf"],
            \           ["reload settings", "source $MYVIMRC"],
            \       ],
            \   },
            \}
" file_mru でファイル名を先頭に持ってくるフィルター
" basyura/unite-converter-file-directory と
" basyura/unite-matcher-file-name が必要
call unite#custom#source(
      \ 'file_mru', 'converters',
      \ ['converter_file_directory'])
nnoremap [Unite] <Nop>
nmap <Space> [Unite]
nnoremap <silent> [Unite]<Space> :<C-u>Unite file_mru buffer tab<CR>

nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [Unite]b :<C-u>Unite buffer -default-action=open<CR>
nnoremap <silent> [Unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> [Unite]r :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [Unite]l :<C-u>Unite line<CR>
nnoremap <silent> [Unite]k :<C-u>Unite buffer -default-action=delete -no-quit -no-start-insert<CR>
nnoremap <silent> [Unite]s :<C-u>Unite menu:shortcut<CR>
nnoremap <silent> [Unite]w :<C-u>Unite window<CR>
nnoremap <silent> [Unite]u <Nop>

" nnoremap <silent> [Unite]g :<C-u>Unite grep/git:/ -buffer-name=search-buffer<CR>
nnoremap <silent> [Unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> [Unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer> <C-e> <END>
  inoremap <silent> <C-j> <Nop>
  nmap <buffer> <C-n> j
  nmap <buffer> <C-p> k
  " ひとつ上のディレクトリに移動
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  imap <buffer> <C-c> <C-g>
  nmap <buffer> <C-c> <C-g>
endfunction

" for rails
nnoremap <silent> [Unite];m :<C-u>Unite rails/model rails/mailer file_rec:app/domains file_rec:app/decorators<CR>
nnoremap <silent> [Unite];c :<C-u>Unite rails/controller<CR>
nnoremap <silent> [Unite];v :<C-u>Unite rails/view file_rec:app/cells<CR>
nnoremap <silent> [Unite];h :<C-u>Unite rails/helper<CR>
nnoremap <silent> [Unite];s :<C-u>Unite rails/spec<CR>
nnoremap <silent> [Unite];d :<C-u>Unite file_rec:db<CR>
nnoremap <silent> [Unite];i :<C-u>Unite rails/initializer<CR>
nnoremap <silent> [Unite];a :<C-u>Unite rails/asset file_rec:app/javascript/stylesheets<CR>
nnoremap <silent> [Unite];r :<C-u>Unite rails/route rails/gemfile file_rec:config/routes<CR>
nnoremap <silent> [Unite];n :<C-u>Unite rails/config<CR>
nnoremap <silent> [Unite];j :<C-u>Unite rails/javascript file_rec:app/javascript/packs file_rec:app/javascript/javascripts<CR>
nnoremap <silent> [Unite];l :<C-u>Unite rails/lib file_rec:app/libraries<CR>
nnoremap <silent> [Unite];t :<C-u>Unite file_rec:app/services<CR>
nnoremap <silent> [Unite];g :<C-u>Unite file_rec:app/graphql file_rec:app/finders<CR>

" .gitignoreで指定したファイルと.git/以下のファイルを候補から除外する
function! s:unite_gitignore_source()
  let sources = []
  if filereadable('./.gitignore')
    for file in readfile('./.gitignore')
      " コメント行と空行は追加しない
      if file !~ "^#\\|^\s\*$"
        call add(sources, file)
      endif
    endfor
  endif
  if isdirectory('./.git')
    call add(sources, '.git')
  endif
  let pattern = escape(join(sources, '|'), './|')
  call unite#custom#source('file_rec', 'ignore_pattern', pattern)
  call unite#custom#source('grep', 'ignore_pattern', pattern)
endfunction
call s:unite_gitignore_source()
