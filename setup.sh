#!/bin/bash

for FILE in .??*
do
  # 無視するファイル
  if [ $FILE = ".git" -o $FILE = ".vscode" -o $FILE = ".DS_Store" -o $FILE = ".gitignore" -o $FILE = ".github" ]; then
    continue
  fi

  # 既に存在する場合、上書きを行うか確認
  if [ -e $HOME/$FILE ]; then
    echo "File exists: $FILE"
    read -p "override? y/n " yn
  else
    yn=y
  fi

  if [ $yn = "y" ]; then
    echo "make symbol $FILE"
    ln -sf $HOME/dotfiles/$FILE $HOME/$FILE
  fi
done

if [[ $OSTYPE = *darwin* ]]; then
#  # brewのインストール
#  xcode-select --install
#  sudo xcodebuild -license
#
#  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#  brew doctor
#  bash ./brew_list.sh
#
  # finderで隠しファイルを表示する
  read -p "Do you wish to show hidden files with Finder? y/n " yn
  if [ $yn = "y" -o $yn = "Y" ]; then
      defaults write com.apple.finder AppleShowAllFiles TRUE
      echo "done!!"
      echo "...restart finder\n"
      killall Finder
  fi

  # DS_Storeを作るか確認
  read -p "Never create .DS_Store? y/n" yn
  if [ $yn = "y" -o $yn = "Y" ]; then
    defaults write com.apple.desktopservices DSDontWriteNetworkStores True
    echo "...success"
  fi
else # linux
  cat apt_list | xargs sudo apt-get install
fi

if [ -e $HOME/.vim/autoload/plug.vim ]; then
  echo You have already installed vim-plug!
else
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ -e $HOME/.rbenv ]; then
  echo already installed rbenv! when have you done?
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi

# SCRIPT_DIR=$(cd $(dirname $0) && pwd)
# VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
# rm "$VSCODE_SETTING_DIR/settings.json"
# ln -s "$SCRIPT_DIR/.vscode/settings.json" "$VSCODE_SETTING_DIR/settings.json"

# rm "$VSCODE_SETTING_DIR/keybindings.json"
# ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

# cat .vscode/extensions | while read line
# do
#   code --install-extension $line
# done

# code --list-extensions > .vscode/extensions

# source $HOME/.zshrc
echo "==============================>>"
echo "Installation completed"
echo "You only have to DO execute :PlugInstall on vim :)"
