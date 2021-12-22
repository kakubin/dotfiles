#!/bin/bash

echo "Hello! This is a brew list file,"
echo "which automatically install convenient applications"

# latest home Homebrew
brew update
# update already-installed formula
brew upgrade

brew install vim
brew install fzf
brew install ripgrep
brew install tree
brew install tmux
brew install tig
brew install ghq

brew install asdf
brew install goenv
brew install nodenv
brew install direnv
brew install pyenv
brew install fvm
brew install yarn
brew install ffmpeg
brew install coreutils
brew install graphviz
brew install virtualbox
brew install mariadb-connector-c

brew install postgresql
# version切り替えあるのでdockerで管理する
# brew install mysql@5.7
# brew install redis

brew install --cask docker
brew install --cask slack
brew install --cask skitch
brew install --cask postman
brew install --cask wkhtmltopdf
brew install --cask mysqlworkbench
brew install --cask yt-music
# brew install --cask visual-studio-code
# brew install --cask android-studio

# regularly executed
brew cleanup
