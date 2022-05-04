#!/usr/bin/bash

# latest home Homebrew
brew update
# update already-installed formula
brew upgrade

brew install fzf
brew install ripgrep
brew install tree
brew install tmux
brew install tig
brew install ghq

brew install asdf
# brew install nodenv
brew install direnv
# brew install fvm
# brew install yarn
brew install ffmpeg
brew install coreutils
brew install graphviz
brew install virtualbox
brew install mariadb-connector-c
brew install openssl@1.1

brew install postgresql
brew install redis
brew install lynx

brew install --cask docker
brew install --cask slack
brew install --cask skitch
brew install --cask postman
brew install --cask wkhtmltopdf
brew install --cask mysqlworkbench
brew install --cask yt-music
# brew install --cask visual-studio-code
brew install --cask android-studio

# regularly executed
brew cleanup
