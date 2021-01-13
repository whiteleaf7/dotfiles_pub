scriptencoding utf-8

filetype off
filetype plugin indent off

let mapleader = "m"

" Dein Settings: {{{ -----------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/.cache/dein')
let g:dein#install_github_api_token = 'GITHUB_API_TOKEN'

" プラグインリストを収めた TOML ファイル
" 予め TOML ファイル（後述）を用意しておく
let g:rc_dir         = expand('~/.config/nvim/rc')
let g:dein_toml      = g:rc_dir . '/dein.toml'
let g:dein_lazy_toml = g:rc_dir . '/dein_lazy.toml'

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, g:dein_toml, g:dein_lazy_toml])

  call dein#load_toml(g:dein_toml,      {'lazy': 0})
  call dein#load_toml(g:dein_lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" }}}

" VIM Settings: {{{ -------------------------------------------------------------
" ターミナル接続高速化
set ttyfast
" 内容が変更された場合自動読み込み
set autoread
"改行後に「Backspace」キーを押すと上行末尾の文字を1文字消す
set backspace=2

set nowritebackup
set nobackup
" set backupdir=~/.vim/tmp
set swapfile
set nrformats-=octal
set timeout timeoutlen=3000 ttimeoutlen=100
set hidden
set switchbuf=useopen
set history=100
set formatoptions+=mM
set virtualedit=block
set whichwrap=b,s,[,],<,>
" set lazyredraw
set backspace=indent,eol,start
" set ambiwidth=double
set wildmenu
set wildmode=full
if has('mouse')
  set mouse=a
endif
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set nowrap

" https://vim-jp.org/vimdoc-ja/options.html#'shortmess'
"   I     Vimの開始時に挨拶メッセージを表示しない :intro。
"   c     ins-completion-menu 関連のメッセージを表示しない。例えば、
"         "-- XXX補完 (YYY)"、"1 番目の該当 (全該当 2 個中)"、"唯一の該
"         当"、"パターンは見つかりませんでした"、"始めに戻る"、など。
set shortmess+=Ic

set noerrorbells
set novisualbell
set visualbell t_vb=
set shellslash
set nonumber
set showmatch
set matchtime=3
set cinoptions+=:0
set title
set cmdheight=1
" ステータスライン(0:表示しない、1:2つ以上ウィンドウがある時だけ表示、2:常に表示)
set laststatus=2
set noshowmode
set showcmd
set display=lastline
set nolist
" set listchars=eol:¬,tab:▸\ 
set scrolloff=7
" set autoindent
" set smartindent
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=0
set splitbelow
set tw=0
set nocursorline
set undodir=~/.vim/undo
set modeline
set iminsert=0
set imsearch=0
set imdisable
set re=0
if $TERM_PROGRAM == 'Apple_Terminal'
  set showtabline=1
else
  set showtabline=2
endif
set splitright
set matchpairs& matchpairs+=<:>
" set pyxversion=3

" 候補の表示高さ
set pumheight=15

" 候補の半透明度(termguicolors が有効じゃないとひどいことになる)
set pumblend=5
set winblend=5

set foldmethod=marker

" ダッシュ繋がりの単語をひとつのものとして認識する
set isk+=-

" インサートモードでペーストがうまく動かないときに
" set t_BE=

" }}}

" Clipboard Settings: {{{ ------------------------------------------------------
set clipboard+=unnamed

let s:clipboard_enabled_on_mac=1

function! s:cmd_ok(cmd) abort
  call system(a:cmd)
  return v:shell_error == 0
endfunction

function! s:running_wsl_directly()
  if !exists('s:is_running_wsl_directly')
    let s:is_running_wsl_directly = !exists('$SSH_CLIENT') && filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
  endif
  return s:is_running_wsl_directly
endfunction

if has('nvim')
  if has('mac')
    if s:clipboard_enabled_on_mac
      " set clipboard+=unnamedplus
      let g:clipboard = {
            \   'name': 'myClipboard',
            \   'cache_enabled': 1,
            \   'copy': {
            \      '+': 'pbcopy',
            \      '*': 'pbcopy',
            \    },
            \    'paste': {
            \      '+': v:null,
            \      '*': v:null,
            \    },
            \ }
            " \    'paste': {
            " \      '+': v:null,
            " \      '*': v:null,
            " \    },
    else
      " copy, paste の設定をデフォルトのままにしておくと、clipboard+=unnamedplus
      " に設定してなくてもむっちゃ重くなるので消しとく
      let g:clipboard = {
            \   'name': 'myClipboard',
            \   'cache_enabled': 0,
            \ }
    endif
  elseif s:running_wsl_directly()
    " WSL で直接実行していることを想定
    let g:clipboard = {
          \   'name': 'myClipboard',
          \   'cache_enabled': 1,
          \   'copy': {
          \      '+': 'win32yank.exe -i --crlf',
          \      '*': 'win32yank.exe -i --crlf',
          \    },
          \    'paste': {
          \      '+': v:null,
          \      '*': v:null,
          \    },
          \ }
  elseif executable('lemonade')
    " let s:copy['+'] = 'lemonade copy'
    " let s:paste['+'] = 'lemonade paste'
    " let s:copy['*'] = 'lemonade copy'
    " let s:paste['*'] = 'lemonade paste'
    let g:clipboard = {
          \   'name': 'myClipboard',
          \   'cache_enabled': 1,
          \   'copy': {
          \      '+': 'lemonade copy',
          \      '*': 'lemonade copy',
          \    },
          \    'paste': {
          \      '+': v:null,
          \      '*': v:null,
          \    },
          \ }
  " elseif exists('$DISPLAY') && executable('xsel') && s:cmd_ok('xsel -o -b')
  "   let g:clipboard = {
  "         \   'name': 'myClipboard',
  "         \   'cache_enabled': 1,
  "         \   'copy': {
  "         \      '+': 'xsel --nodetach -i -b',
  "         \      '*': 'xsel --nodetach -i -b',
  "         \    },
  "         \    'paste': {
  "         \      '+': 'xsel -o -b',
  "         \      '*': 'xsel -o -b',
  "         \    },
  "         \ }
  endif
endif

" }}}

" Visual Settings: {{{ -------------------------------------------------------------
if &t_Co > 2 || has('gui_running')
  syntax on
endif

set termguicolors
set background=dark

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

augroup my_colors
  autocmd!
  autocmd ColorScheme * call s:set_my_colors()
augroup END

function! s:set_my_colors()
  highlight GitGutterAdd    guifg=#99ee00 ctermfg=2 guibg=#222230 ctermbg=NONE
  highlight GitGutterChange guifg=#ffbb00 ctermfg=3 guibg=#222230 ctermbg=NONE
  highlight GitGutterDelete guifg=#ff4444 ctermfg=1 guibg=#222230 ctermbg=NONE
endfunction
call s:set_my_colors()

" colorscheme gruvbox
" let g:gruvbox_contrast_dark = "hard"

" iceberg を使う場合は termguicolors を有効にしないと正確な色は出ない
" colorscheme iceberg

" " カーソル行の色を変更
" augroup cch
"   autocmd! cch
"   autocmd WinLeave * set nocursorline
"   autocmd WinEnter,BufRead * set cursorline
" augroup END
" 
" hi clear CursorLine
" highlight CursorLine ctermbg=NONE guibg=#34363a

" hybrid 用の行番号の色
" highlight LineNr ctermfg=8 guifg=#555555
" iceberg 用の行番号の色
" highlight LineNr ctermfg=66 ctermbg=NONE
" highlight LineNr ctermfg=66 ctermbg=NONE guifg=#9fa7bd guibg=NONE



" 色の独自設定の課題。
" Goyo.vim を使って戻ってくるとき、カラーテーマへ復帰するという処理が走るため、" 自分で設定した色がテーマの色に戻ってしまう。ちゃんとテーマの色を書き換える
" 方法があるのだろうか？　なければテーマをフォークして書き換えるしかない

" ここから
" hi LineNr ctermbg=NONE ctermfg=66 guibg=NONE guifg=#678686
" " #678686
" hi VertSplit ctermfg=60 guifg=#5F6084

" " highlight Normal ctermbg=NONE guibg=NONE
" " highlight NonText ctermbg=NONE guibg=NONE
" " highlight SpecialKey ctermbg=NONE guibg=NONE
" " highlight EndOfBuffer ctermbg=NONE guibg=NONE

" " " highlight Search cterm=underline ctermfg=none ctermbg=236
" highlight Search cterm=underline gui=underline ctermfg=none ctermbg=none guifg=NONE guibg=NONE

" " hi Statement guifg=#8EAFD3
" " hi String guifg=#AFAE69
" hi SpecialKey guifg=#666666

" " hi Quote ctermbg=109 guifg=#83a598

" hi MatchParen cterm=bold ctermbg=239 ctermfg=177 guibg=#4E4E4E guifg=#CB8EF8
" ここまで




" floating window
" hi NormalFloat guifg=#2e3440 guibg=#a3be8c


" "フォーカスしていない時の背景色(23を好きな値・色に変更)
" let g:InactiveBackGround = 'ctermbg=235'
" 
" "Neovim内でフォーカスしていないペインの背景色設定
" execute ('hi NormalNC '.g:InactiveBackGround)
" execute ('hi NontextNC '.g:InactiveBackGround)
" execute ('hi SpecialkeyNC '.g:InactiveBackGround)
" execute ('hi EndOfBufferNC '.g:InactiveBackGround)
" 
" "Neovim自体からフォーカスを外したりした際の切替設定
" "(フォーカスした時の設定はcolorschemeに合わせて変更）
" augroup ChangeBackGround
" autocmd!
" " フォーカスした時(colorscheme準拠に切替)
" autocmd FocusGained * hi Normal ctermbg=234 " :hi Normalで取得した値
" autocmd FocusGained * hi NonText ctermbg=234 " :hi NonTextで取得した値
" autocmd FocusGained * hi SpecialKey ctermbg=234 " :hi SpecialKeyで取得した値
" autocmd FocusGained * hi EndOfBuffer ctermbg=none " EndOfBufferの設定は恐らくclearなのでnoneを入れる
" " フォーカスを外した時（フォーカスしていない時の背景色に切替)
" autocmd FocusLost * execute('hi Normal '.g:InactiveBackGround)
" autocmd FocusLost * execute('hi NonText '.g:InactiveBackGround)
" autocmd FocusLost * execute('hi SpecialKey '.g:InactiveBackGround)
" autocmd FocusLost * execute('hi EndOfBuffer '.g:InactiveBackGround)
" augroup end

" autoread のチェックタイミングを増やす
augroup vimrc_checktime
  autocmd!
  autocmd InsertEnter,WinEnter * checktime
augroup END


" ステータスラインに文字コード等表示
if !exists('lightline')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif


" }}}

" Keybinding: ----------------------------------------------------------------- {{{
"
" キーマップ設定
"
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" 保存しないですべて閉じる
nnoremap <Leader>qq :qa!<CR>

" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <silent> <Down> gj
nnoremap <silent> <Up>   gk
nnoremap <silent> h <Left>zv
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> l <Right>zv
nnoremap <silent> gb :bn<CR>
nnoremap <SPACE>[ :nohlsearch<CR><ESC>
inoremap <silent> jj <ESC>
inoremap <silent> Jj <ESC>
inoremap <silent> <C-d> <ESC>
" inoremap <silent> <C-K> <ESC>d$i

" 選択候補選択中だった場合は選択をキャンセルして元の入力途中までの状態に戻る。
" 候補を表示していなかった場合は文字列の最後尾に移動する
imap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<END>"

imap <C-a> <ESC>I
nnoremap <C-\> <C-w>p

" インサートから抜けたらIME解除
" inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" inoremap <silent> <C-c> <ESC>:set iminsert=0<CR>

" インサートモードを抜けるときのオートインデントがESCにしか割り当てられていない場合の対策
imap <silent> <C-c> <ESC>
imap <silent> <C-[> <ESC>

" Ctrl + Shift + 矢印でウィンドウサイズを変更
nnoremap <C-S-Left>  2<C-w><
nnoremap <C-S-Right> 2<C-w>>
nnoremap <C-S-Up>    2<C-w>+
nnoremap <C-S-Down>  2<C-w>-

" ペイン間の移動
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" インデントライン強調のトグル
nnoremap _C :IndentLinesToggle<CR>

" 選択中にC-pで同じ内容を連続貼り付け
vnoremap <silent> <C-p> "0p

" 消した文字をヤンクしない
nnoremap x "_x
" nnoremap s "_s

" タブ設定
nnoremap [Tab] <Nop>
nmap mt [Tab]

" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tab]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" 新しいタブを一番右に作る
nnoremap <silent> [Tab]c :tablast <bar> tabnew<CR>
" タブを閉じる
nnoremap <silent> [Tab]x :tabclose<CR>
" 次のタブ
nnoremap <silent> [Tab]n :tabnext<CR>
nnoremap <silent> [Tab]t :tabnext<CR>
nnoremap <silent> [Tab]<C-t> :tabnext<CR>
" 前のタブ
nnoremap <silent> [Tab]p :tabprevious<CR>


" カーソル位置の色がどの highlight group に所属しているかを表示する
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" 真下にある tmux pane の前回のコマンドを実行する
" nnoremap \r :call system("tmux send-keys -t 1.3 -X cancel; tmux send-keys -t 1.3 C-p C-m")<CR>
nnoremap \r :call system("tmux send-keys -t {down-of} -X cancel; tmux send-keys -t {down-of} C-p C-m")<CR>

" dein の plugin のキャッシュを更新する（削除する場合はこれを呼ばないと削除さ
" れない）
nnoremap \e :call dein#recache_runtimepath()<CR>

" スペルチェックを有効にする
" https://vim-jp.org/vimdoc-ja/spell.html
nnoremap \s :setlocal spell! spelllang=en_us,cjk<CR>

" ファイル名をコピーする
nnoremap <silent> \\ :call CopyFileToClipboard()<CR>
" 行番号付きファイル名をコピーする
nnoremap <silent> \^ :call CopyFileToClipboard(v:true)<CR>

function! CopyFileToClipboard(...)
  let with_lineinfo = (a:0 ? a:1 : v:false)
  if s:running_wsl_directly()
    let argv = ["win32yank.exe", "-i", "--crlf"]
  else
    let argv = ["pbcopy"]
  endif
  let path = expand("%:s")
  let path = substitute(path, "^".getcwd()."/", "", "")
  if with_lineinfo
    let path = path.":".line(".")
  endif
  call systemlist(argv, path, 1)
  echomsg "copied file path `".path."`"
endfunction

" }}}


" 簡易スニペット ----------------------------------------------------------

" ファイルの先頭に frozen_string_literal 挿入
nnoremap <silent> _fsl ggO# frozen_string_literal: true<CR><ESC>0


"
" ファイルを開いたら前回のカーソル位置へ移動
"
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Vim終了時に現在のセッションを保存する
"au VimLeave * mks!  <file>

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"
" 全角スペースを表示
"
function! ZenkakuSpace()
  silent! let hi = s:GetHighlight('ZenkakuSpace')
  if hi =~ 'E411' || hi =~ 'cleared$'
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  endif
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif


" 改行時に自動でコメントが継続する機能をオフ
" autocmd FileType * setlocal formatoptions-=ro
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o

"
" Ruby
"
runtime macros/matchit.vim
au FileType ruby set expandtab
au FileType ruby call s:ruby_my_settings()
function! s:ruby_my_settings()
  " if !exists('loaded_matchit')
  "   " matchitを有効化
  "   runtime macros/matchit.vim
  " endif
  " ctags --langmap=RUBY:.rb --exclude="*.js" --exclude=".git*" -R .
endfunction

" ruby highlight (ruby_hl_lvar.vim)
" Highligt group name for local variable
" Default: 'Identifier'
"let g:ruby_hl_lvar_hl_group = 'RubyLocalVariable'
" Auto enable and refresh highlight when text is changed. Useful but bit slow.
" Default: 1
"let g:ruby_hl_lvar_auto_enable = 1
" If you wish to control the plugin manually, map these functions.
"nmap <leader>he <Plug>(ruby_hl_lvar-enable)
"nmap <leader>hd <Plug>(ruby_hl_lvar-disable)
"nmap <leader>hr <Plug>(ruby_hl_lvar-refresh)
"let g:syntastic_mode_map = { 'mode': 'passive' }
            "\ 'active_filetypes': ['ruby'] }
"let g:syntastic_ruby_checkers = ['rubocop']

"
" Markdown
"
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
autocmd BufNewFile,BufRead *.md set filetype=markdown expandtab tabstop=2 shiftwidth=2 textwidth=78

" 80桁以上の部分に色を付ける
" ついでに縦ラインハイライトもトグルする
let g:match_turn = 0
function! Toggle_turn_over_80()
    if g:match_turn
        " disable
        call matchdelete(g:match_turn)
        let g:match_turn = 0
        let &colorcolumn = len(&colorcolumn) > 0 ? '' : join(range(80, 9999), ',')
        set nocursorcolumn
    else
        " enable
        highlight turn gui=standout cterm=standout
        let g:match_turn = matchadd("turn", '.\%>80v')
        let &colorcolumn = len(&colorcolumn) > 0 ? '' : join(range(80, 9999), ',')
        set cursorcolumn
    endif
endfunction
nmap _c :call Toggle_turn_over_80()<CR>


" クリップボードの有効無効をトグル
let g:toggle_clipboard = 0
function! ToggleClipboard()
  if g:toggle_clipboard
    set clipboard-=unnamedplus
    let g:toggle_clipboard = 0
  else
    set clipboard+=unnamedplus
    let g:toggle_clipboard = 1
  endif
endfunction
nmap _x :call ToggleClipboard()<CR>

"
" CoffeeScript
"
" au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" " インデント設定
" autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" " オートコンパイル
"   "保存と同時にコンパイルする
" "autocmd BufWritePost *.coffee silent make! 
"   "エラーがあったら別ウィンドウで表示
" autocmd QuickFixCmdPost * nested cwindow | redraw! 
" " Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
" "nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

"
" Slim
"
" autocmd BufRead,BufNewFile *.slim setf slim


"
" jsx
"

" .js ファイルでも jsx 構文を有効にする
let g:jsx_ext_required = 0

"
" es6
"
autocmd BufNewFile,BufRead *.{es,es6} set filetype=javascript

"
" Syntatic
"
" nnoremap <silent> ;s :SyntasticCheck<CR>

" let g:syntastic_mode_map = { 'mode': 'passive' }
" " エラー行に sign を表示
" let g:syntastic_enable_signs = 1
" " location list を常に更新
" let g:syntastic_always_populate_loc_list = 0
" " location list を常に表示
" let g:syntastic_auto_loc_list = 0
" " ファイルを開いた時にチェック
" let g:syntastic_check_on_open = 0
" " :wq で終了する時にチェック
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_ruby_checkers = ['rubocop'] " or ['rubocop', 'mri']
" let g:syntastic_javascript_checkers = ['eslint']
" " let g:syntastic_coffee_checkers = ['coffeelint']
" let g:syntastic_scss_checkers = ['scss_lint']
" let g:syntastic_error_symbol = '✗'
" let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" " hi SyntasticErrorSign ctermfg = 160
" " hi SyntasticWarningSign ctermfg = 220



augroup MyVimrc
  autocmd!
augroup END

autocmd MyVimrc BufNewFile,BufRead dein*.toml call s:syntax_range_dein()

function! s:syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \           'add\|source\|post_source\|post_update'.
  \           '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction



let g:tsuquyomi_disable_default_mappings = 1

autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o

if has('vim_starting') && !has('nvim')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif


" let g:deoplete#enable_at_startup = 1
" set completeopt+=noselect
" call deoplete#custom#option({
"       \ 'auto_complete_delay': 200,
"       \ 'smart_case': v:true,
"       \ 'skip_chars': ['(', ')', '[', ']', '{', '}'],
"       \ 'omni_patterns': {
"       \   'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::'],
"       \   'java': '[^. *\t]\.\w*',
"       \   'html': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
"       \   'xhtml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
"       \   'xml': ['<', '</', '<[^>]*\s[[:alnum:]-]*'],
"       \ },
"       \ })


" virtualモードの時にスターで選択位置のコードを検索するようにする
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
