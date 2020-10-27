#!/bin/zsh

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue

    echo "$f"
    eval "ln -sf ~/dotfiles/$f ~/$f"
done

# source ~/.zshrc
echo "Install completed"
