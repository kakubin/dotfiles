#!/usr/bin/env sh

cd $HOME/vim
git pull origin master
./configure --with-features=huge \
  --enable-python3interp \
  --enable-fail-if-missing
make
sudo make install
hash -r
