"
" denite.vim
"

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

" key bindings {{{ ----------------------------------------------------------------------

call denite#custom#map('insert', '<C-N>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-P>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-W>', '<denite:move_up_path>', 'noremap')

nnoremap [Denite] <Nop>
nmap _ [Denite]

nnoremap <silent> [Denite], :<C-u>Denite file_mru buffer<CR>
nnoremap <silent> [Denite]f :<C-u>DeniteBufferDir file<CR>
nnoremap <silent> [Denite]e :<C-u>DeniteBufferDir file_rec/git<CR>
nnoremap <silent> [Denite]b :<C-u>Denite buffer<CR>
nnoremap <silent> [Denite]k :<C-u>Denite buffer -default-action=delete<CR>
nnoremap <silent> [Denite]t :<C-u>Denite unite:tab<CR>
nnoremap <silent> [Denite]y :<C-u>Denite neoyank<CR>
nnoremap <silent> <Space>o :<C-u>Denite outline<CR>

" nnoremap <silent> [Denite]g :<C-u>Denite grep/git:/ -buffer-name=search-buffer<CR>
nnoremap <silent> [Denite]g :<C-u>Denite grep -buffer-name=search-buffer<CR>

" grep 検索したバッファを再表示
nnoremap <silent> [Denite]r :<C-u>Denite -resume -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
" nnoremap <silent> [Denite]cg :<C-u>Denite grep/git:/ -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> [Denite]cg :<C-u>DeniteCursorWord grep -buffer-name=search-buffer<CR>

nnoremap <silent> [Denite]l :<C-u>Denite line<CR>
nnoremap <silent> [Denite]s :<C-u>Denite menu:shortcuts<CR>
nnoremap <silent> [Denite]w :<C-u>Denite unite:window<CR>
nnoremap <silent> [Denite]c :<C-u>Denite change<CR>
nnoremap <silent> [Denite]u <Nop>

" for rails
nnoremap <silent> [Denite];m :<C-u>Denite rails:model<CR>
nnoremap <silent> [Denite];c :<C-u>Denite rails:controller<CR>
nnoremap <silent> [Denite];v :<C-u>Denite rails:view<CR>
nnoremap <silent> [Denite];h :<C-u>Denite rails:helper<CR>
nnoremap <silent> [Denite];s :<C-u>Denite rails:spec<CR>
nnoremap <silent> [Denite];d :<C-u>Denite rails:db<CR>
nnoremap <silent> [Denite];i :<C-u>Denite unite:rails/initializer<CR>
nnoremap <silent> [Denite];a :<C-u>Denite rails:asset<CR>
nnoremap <silent> [Denite];r :<C-u>Denite unite:rails/route unite:rails/gemfile<CR>
nnoremap <silent> [Denite];n :<C-u>Denite rails:config<CR>
nnoremap <silent> [Denite];j :<C-u>Denite unite:rails/javascript<CR>
nnoremap <silent> [Denite];l :<C-u>Denite unite:rails/lib<CR>
nnoremap <silent> [Denite];o :<C-u>Denite rails:dwim<CR>

" }}}

" customize sources {{{ --------------------------------------------------------------------

call denite#custom#source('file'    , 'matchers', ['matcher_cpsm', 'matcher_fuzzy'])
call denite#custom#source('buffer'  , 'matchers', ['matcher_regexp'])
call denite#custom#source('file_mru', 'matchers', ['matcher_regexp'])

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \ ['git', 'ls-files', '-co', '--exclude-standard'])

" }}}

" customize grep {{{ --------------------------------------------------------------------

" 検索関係のコマンドを ag を使うように変
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

" }}}

" custom menus {{{ ---------------------------------------------------------------------

let s:menus = {}

let s:menus.shortcuts = {
  \ 'description': 'Shortcuts'
  \ }
let s:menus.shortcuts.command_candidates = [
      \ ["edit .vimrc", "edit $MYVIMRC"],
      \ ["edit .gvimrc", "edit $MYGVIMRC"],
      \ ["edit dein.toml", "edit ".g:dein_toml],
      \ ["edit dein_lazy.toml", "edit ".g:dein_lazy_toml],
      \ ["reload .vimrc", "source $MYVIMRC"],
      \ ]

call denite#custom#var('menu', 'menus', s:menus)

" }}}

" converters {{{ ---------------------------------------------------------------------

" call unite#custom#source(
"       \ 'file_mru', 'converters',
"       \ ['converter_file_directory'])

" call denite#custom#source('file_mru',
"       \ 'converters', ['converter_file_directory'])
" 
" call denite#custom#source('grep',
"       \ 'converters', ['converter/relative_abbr'])

call denite#custom#source('grep',
\ 'converters', ['converter/abbr_word'])

call denite#custom#source('file_mur',
\ 'converters', ['converter/abbr_word'])

" }}}
