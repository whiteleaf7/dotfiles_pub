#!/bin/sh

set -eux

cd ~

brew install gcc
brew install anyenv bat colordiff htop exa fzf neovim yarn tmux entr tig ag git
brew tap bibendi/dip
brew install dip

sudo apt update
sudo apt -y remove git
brew install git

sudo apt -y install libssl-dev

anyenv install rbenv
__anyenv::make_cache
rbenv install 2.6.6
gem i solargraph
solargraph download-cores 2.6.6

# https://github.com/lemonade-command/lemonade
anyenv install goenv
goenv install 1.14.6
go get -d github.com/lemonade-command/lemonade
cd $GOPATH/src/github.com/lemonade-command/lemonade/
make install
sudo ln -s `which lemonade` /usr/local/bin/xdg-open
sudo ln -s `which lemonade` /usr/local/bin/pbcopy
sudo ln -s `which lemonade` /usr/local/bin/pbpaste


ln -s ~/dotfiles/.rbenv ~/.rbenv

# install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sh ./installer.sh ~/.cache/dein_simple
rm -f installer.sh
