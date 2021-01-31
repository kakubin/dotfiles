# dotfiles

1. capsLockとctrlを入れ替える
2. 入力言語の切り替えを<command-Space>にする

cd .ssh & ssh keygen -t rsa
pbcopy < ~/.ssh/id_rsa.pub
ssh -T git@github.com

```Darwin
xcode-select --install
sudo xcodebuild -license

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

git clone https://github.com/mrbigass/dotfiles.git
cd dotfiles

sh ./brewfile.sh
sh ./dotsetup.sh
```

```Linux
sudo apt install curl
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install npm
```
