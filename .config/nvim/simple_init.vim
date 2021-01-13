scriptencoding utf-8

filetype off
filetype plugin indent off

let mapleader = "m"

" dein settings {{{ -----------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/.cache/dein_simple')

" Required:
set runtimepath+=~/.cache/dein_simple/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC])

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_dir . '/repos/github.com/Shougo/dein.vim')

  call dein#add('whiteleaf7/vim-hybrid')

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

" VIM settings {{{ -------------------------------------------------------------
" ターミナル接続高速化
set ttyfast
" 内容が変更された場合自動読み込み
set autoread
"改行後に「Backspace」キーを押すと上行末尾の文字を1文字消す
set backspace=2

set nowritebackup
set nobackup
" set backupdir=~/.vim/tmp
set noswapfile
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
if has('mouse')
  set mouse=a
endif
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set shortmess+=Ic
set noerrorbells
set novisualbell
set visualbell t_vb=
set shellslash
" set number
set showmatch
set matchtime=3
set cinoptions+=:0
set title
set cmdheight=1
set showcmd
set display=lastline
set list
set listchars=tab:▸\ 
set scrolloff=5
set autoindent
set smartindent
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
set splitright

" 候補ポップアップの表示高さ
set pumheight=15

set matchpairs& matchpairs+=<:>

" インサートモードでペーストがうまく動かないときに
set t_BE=

" 改行時に自動でコメントが継続する機能をオフ
" autocmd FileType * setlocal formatoptions-=ro
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

" }}}

" Clipboard settings {{{ ------------------------------------------------------

set clipboard+=unnamed

let s:clipboard_enabled_on_mac=1

function! s:cmd_ok(cmd) abort
  call system(a:cmd)
  return v:shell_error == 0
endfunction

if has('nvim')
  if has('mac')
    if s:clipboard_enabled_on_mac
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
    else
      " copy, paste の設定をデフォルトのままにしておくと、clipboard+=unnamedplus
      " に設定してなくてもむっちゃ重くなるので消しとく
      let g:clipboard = {
            \   'name': 'myClipboard',
            \   'cache_enabled': 0,
            \ }
    endif
  elseif !exists('$SSH_CLIENT') && filereadable('/proc/sys/fs/binfmt_misc/WSLInterop')
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
  endif
endif

" }}}

" Visual settings {{{ -------------------------------------------------------------
if &t_Co > 2 || has('gui_running')
  syntax on
endif

set termguicolors
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" ステータスラインに文字コード等表示
" if !exists('lightline')
"   set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
" endif

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[%{&fileencoding}]
" 現在行数/全行数
set statusline+=[%l/%L]
" ステータスライン(0:表示しない、1:2つ以上ウィンドウがある時だけ表示、2:常に表示)
set laststatus=0
set showmode

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

" x, s で消した文字はヤンクしない
nnoremap x "_x
nnoremap s "_s

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


" tmux pane No.3 の前回のコマンドを実行する
nnoremap \r :call system("tmux send-keys -t 1.3 -X cancel; tmux send-keys -t 1.3 C-p C-m")<CR>

" dein の plugin のキャッシュを更新する（削除する場合はこれを呼ばないと削除さ
" れない）
nnoremap \e :call dein#recache_runtimepath()<CR>

" スペルチェックを有効にする
" https://vim-jp.org/vimdoc-ja/spell.html
nnoremap \s :setlocal spell! spelllang=en_us,cjk<CR>

" }}}
