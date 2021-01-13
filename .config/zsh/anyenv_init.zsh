# anyenv の初期化スクリプトを展開する
# 管理する **env を増やした場合に実行して更新する
__anyenv::make_cache() {
    [[ -d $XDG_CACHE_HOME/anyenv ]] || mkdir -p $XDG_CACHE_HOME/anyenv
    anyenv init - --no-rehash >| $XDG_CACHE_HOME/anyenv/init.zsh
    source $XDG_CACHE_HOME/anyenv/init.zsh
    __anyenv::rehash
}

if _has anyenv; then
    [[ -f $XDG_CACHE_HOME/anyenv/init.zsh ]] || __anyenv::make_cache
    source $XDG_CACHE_HOME/anyenv/init.zsh
fi

# anyenv 管理化の **env すべてで rehash を実行する
__anyenv::rehash() {
    anyenv global | while read line
    do
        local rehash_cmd=${line%:*}
        echo "$rehash_cmd rehash"
        $rehash_cmd rehash
    done
}
