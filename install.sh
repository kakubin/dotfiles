#!/usr/bin/env bash

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
