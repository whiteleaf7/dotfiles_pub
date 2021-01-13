" ウィンドウ間の移動をtmuxに移譲する
" .tmux.conf にも設定する必要がある
" nnoremap <silent> <C-w>h :TmuxNavigateLeft<CR>
" nnoremap <silent> <C-w>j :TmuxNavigateDown<CR>
" nnoremap <silent> <C-w>k :TmuxNavigateUp<CR>
" nnoremap <silent> <C-w>l :TmuxNavigateRight<CR>
" nnoremap <silent> <C-w>o :TmuxNavigatePrevious<CR>
" nnoremap <silent> <C-\> <C-w>p

" .tmux.conf の設定例
" # `C-w` で NAVIGATOR table に切り替え
" bind -n C-w switch-client -T NAVIGATOR
" 
" # See: https://github.com/christoomey/vim-tmux-navigator
" is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
"     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
" 
" # `bind-key -n` のかわりに `bind -T NAVIGATOR` にする
" # `send-keys h` のかわりに `send-keys C-w h` にする
" bind -T NAVIGATOR h if-shell "$is_vim" "send-keys C-w h" "select-pane -L"
" bind -T NAVIGATOR j if-shell "$is_vim" "send-keys C-w j" "select-pane -D"
" bind -T NAVIGATOR k if-shell "$is_vim" "send-keys C-w k" "select-pane -U"
" bind -T NAVIGATOR l if-shell "$is_vim" "send-keys C-w l" "select-pane -R"
" bind -T NAVIGATOR o if-shell "$is_vim" "send-keys C-w o" "select-pane -l"
" 
" # `C-w` が Tmux に喰われてしまうので，2回打つことで Vim に `C-w` を送れるようにして救う
" # 使用頻度の高い Window command がある場合は，明示的に `bind -T NAVIGATOR <key> send-keys C-w <key>` する
" bind -T NAVIGATOR C-w send-keys C-w
" bind -T NAVIGATOR s send-keys C-w s
" bind -T NAVIGATOR q send-keys C-w q
" bind -T NAVIGATOR v send-keys C-w v
" bind -T NAVIGATOR w send-keys C-w w
" bind -T NAVIGATOR p send-keys C-w p
