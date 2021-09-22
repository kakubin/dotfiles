# dotfiles

```sh
<!-- curl -OL https://raw.githubusercontent.com/mrbigass/dotfiles/master/setup.sh ~/setup.sh && sh ~/setup.sh -->
curl -fsSL https://raw.githubusercontent.com/mrbigass/dotfiles/master/setup.sh | sh
```


## Darwin
1. capsLockとctrlを入れ替える
2. 入力言語の切り替えを<⌘-Space>にする
3. [Chromeを入れる](https://www.google.com/intl/ja_jp/chrome/)

## setup vim daily build env

```sh
git clone https://github.com/vim/vim $HOME/vim-garage/vim
cd $HOME/vim-garage/vim
make
sudo make install
```
