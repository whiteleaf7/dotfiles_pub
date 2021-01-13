# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# 正確な位置は echo $(brew --prefix fzf)/shell で調べる。遅いので直埋め込み
[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
[ -f "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh" ] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
[ -f "/opt/local/share/fzf/shell/key-bindings.zsh" ] && source "/opt/local/share/fzf/shell/key-bindings.zsh"

# fzf + ag configuration
if _has fzf && _has ag; then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="
    ${FZF_DEFAULT_OPTS}
    --color fg:244,hl:109,fg+:15,hl+:108,gutter:-1
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  "

  # --color fg:244,hl:68,fg+:15,hl+:111,gutter:-1
  # --color info:108,prompt:109,spinner:108,pointer:168,marker:168
fi
