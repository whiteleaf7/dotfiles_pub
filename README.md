# install

## clone repository

```sh
cd ~
git clone --recursive git@github.com:whiteleaf7/dotfiles.git
```

# update repository

```sh
git pull
git submodule update --init --recursive
```

## setup

```sh
ln -s dotfiles/.gitconfig
ln -s dotfiles/.config
ln -s dotfiles/.Brewfile
# sudo ln -s ~/.config/zsh/ide /usr/local/bin/ide

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sh ./installer.sh ~/.cache/dein_simpl
rm -f ./installer.sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt update
sudo apt install build-essential
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew bundle --global

# install exa (https://the.exa.website/install/linux#manual)
# Ubuntu 20.10 から apt install exa できるらしい
sudo apt install unzip
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
sudo exa-linux-x86_64 /usr/local/bin/exa
rm -f exa-linux-x86_64-0.9.0.zip


# change shell to zsh
sudo apt install zsh
sudo chsh -s /bin/zsh

# (ターミナル再起動する。その時、zsh の初回ダイアログは q を選択する)

git clone --recursive git@github.com:whiteleaf7/prezto.git ~/.zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
exec $SHELL -l


sudo apt install neovim


# install docker for WSL2
# https://qiita.com/amenoyoya/items/ca9210593395dbfc8531
```

nvim が起動できるようになったら、

```
:CocInstall coc-pairs
:CocInstall coc-emmet
:CocInstall coc-vimlsp
:CocInstall coc-tsserver
:CocInstall coc-solargraph
:CocInstall coc-json
:CocInstall coc-docker
:CocInstall coc-css
```

## docker config

config.json
```
{
  "detachKeys" : "ctrl-[,q"
}
```

```
mkdir ~/.docker
vim ~/.docker/config.json
sudo service docker restart
```

## setup for ubuntu

```sh
sudo apt install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8
# 監視ファイル数上限を引き上げ
echo fs.inotify.max_user_watches= 65536 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

lemonade をインストールする  
https://github.com/lemonade-command/lemonade

# install ruby and solargraph

```sh
# for ubuntu
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)" 
sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
# brew install make
sudo apt install gcc-multilib -y
sudo apt-get install -y zlib1g-dev -y
```

```sh
anyenv install rbenv
__anyenv::make_cache
rbenv install 2.6.6
gem i solargraph
solargraph download-core 2.6.6
# solargraph bundle もしたいけど、bundle install を通さないといけないので面倒
# だしそこまで不便でもない
```

# Mac で supervisor を自動起動させるためのメモ

~/Library/LaunchAgents/supervisord.plist

launchctl start ~/Library/LaunchAgents/supervisord.plist

設定ファイル

/etc/supervisor/supervisord.conf

/usr/local/etc/supervisor/conf.d/lemonade.conf
