#!/bin/zsh

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ".vscode" ]] && continue

  echo "$f"
  eval "ln -sf ~/dotfiles/$f ~/$f"
done

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
rm "$VSCODE_SETTING_DIR/settings.json"
ln -s "$SCRIPT_DIR/.vscode/settings.json" "$VSCODE_SETTING_DIR/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -s "$SCRIPT_DIR/keybindings.json" "${VSCODE_SETTING_DIR}/keybindings.json"

cat .vscode/extensions | while read line
do
  code --install-extension $line
done

code --list-extensions > .vscode/extensions

# source ~/.zshrc
echo "Install completed"
