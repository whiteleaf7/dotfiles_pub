```sh
export PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
    count=`ps aux | grep tmux | grep -v grep | wc -l`
    if test $count -eq 0; then
        echo `tmux -u2`
    #elif test $count -eq 1; then
        #echo `tmux a`
    else
        echo `tmux -u2 a`
    fi
fi
```

```sh
# install wkhtmltopdf
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox-0.12.6-1.amazonlinux2.x86_64.rpm
sudo yum install -y wkhtmltox-0.12.6-1.amazonlinux2.x86_64.rpm
rm -f wkhtmltox-0.12.6-1.amazonlinux2.x86_64.rpm

# install font
mkdir ~/.fonts
cp .fonts/* ~/.fonts
# cp .fonts/* /usr/share/fonts
# fc-cache -fv
```
