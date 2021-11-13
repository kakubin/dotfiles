#!/usr/bin/env sh

sudo apt build-dep vim
sudo apt install python3-dev
cd vim/src
./config --with-features=huge \
  --enable-python3interp \
  --enable-fail-if-missing

make
make install
hash -r
vim --version | grep clip
