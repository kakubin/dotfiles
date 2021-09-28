#!/bin/bash

not_installed_yet() {
  if type $1 > /dev/null 2>&1; then
    return 1
  else
    return 0
  fi
}

cd $HOME/.ssh & ssh-keygen -t ed25519
if [[ $OSTYPE = *darwin* ]]; then
  pbcopy < $HOME/.ssh/id_ed25519.pub
else # for Debian
  if not_installed_yet xsel;then
    sudo apt-get install xsel
  fi
  xsel --clipboard --input < $HOME/.ssh/id_ed25519.pub
fi

while true; do
  read -p "Input 'Yes' if you have registered your ssh pub-key to GitHub: " registered

  if [ -z $registered ]; then
    continue
  fi
  if [ $registered != "Yes" ]; then
    continue
  fi

  break
done

ssh -T git@github.com

if [ -f $HOME/dotfiles ]; then
  git clone git@github.com:kakubin/dotfiles.git $HOME/dotfiles
fi

readonly HEADER='
    .__       __    _____.__.__
  __| | _____/  |__/ ____\__|  |   ____   ______
 / __ |/  _ \   __\   __\|  |  | _/ __ \ /  ___/
/ /_/ (  <_> )  |  |  |  |  |  |_\  ___/ \___ \
\_____|\____/|__|  |__|  |__|____/\___/  /_____>
                                                   @kakubin
'
echo "${HEADER}"

cd $HOME/dotfiles

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
  xcode-select --install
  sudo xcodebuild -license

  # brewのインストール
  if not_installed_yet brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  brew doctor
  bash ./brew_list.sh

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

# install Deno version manager
if [ -e $HOME/.dvm ]; then
  echo You have already installed dvm!
else
  curl -fsSL https://deno.land/x/dvm/install.sh | sh
fi

DENO_MOST_RECENT_VERSION="$(dvm list-remote | grep \*)"
echo ${DENO_MOST_RECENT_VERSION:8} | dvm install $1

if [ -e $HOME/.rbenv ]; then
  echo already installed rbenv! when have you done?
else
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  cd $HOME/.rbenv && src/configure && make -C src
  mkdir -p $HOME/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git $HOME/rbenv/plugins/ruby-build
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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
