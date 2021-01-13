# anyenv init - のキャッシュの作り方

新しい env を追加した有りした時に実行する

```
__anyenv::make_cache
```

起動速度のために rehash はしていないので、必要に応じて

```
__anyenv::rehash
```

も実行する
