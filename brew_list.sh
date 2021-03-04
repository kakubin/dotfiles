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
brew install docker
brew install tmux
brew install tig

brew install goenv
brew install nodenv
brew install yarn
brew install ffmpeg
brew install coreutils
brew install graphviz
brew install virtualbox

brew install mysql@5.7
brew install postgresql
brew install redis

brew install --cask postman
brew install --cask skitch
brew install --cask wkhtmltopdf
brew install --cask mysqlworkbench

# regularly executed
brew cleanup

