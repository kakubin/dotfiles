# dotfiles

1. capsLockとctrlを入れ替える
2. 入力言語の切り替えを<command-Space>にする

```
xcode-select --install
sudo xcodebuild -license

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

git clone https://github.com/mrbigass/dotfiles.git
cd dotfiles

sh ./brewfile.sh
sh ./dotsetup.sh
```
