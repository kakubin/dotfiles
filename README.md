# dotfiles
## 共通

```
cd $HOME/.ssh & ssh-keygen -t ed25519
if [[ $OSTYPE = *darwin* ]]; then
  pbcopy < $HOME/.ssh/id_ed25519.pub
else # for Debian
  sudo apt-get install xsel
  xsel --clipboard --input < $HOME/.ssh/id_ed25519.pub
fi

while true; do
  read -p "Input 'Yes' if you have registered your ssh pub-key to GitHub" registered

  if [ -z $registered ]; then
    continue
  fi
  if [ $registered != "Yes" ]; then
    continue
  fi

  break
done
ssh -T git@github.com

bash ./setup.sh
```

## Darwin
1. capsLockとctrlを入れ替える
2. 入力言語の切り替えを<⌘-Space>にする

## Linux

```
chsh -s /bin/zsh
mysqlのソケットを/tmp/mysql.sockに切り替え
```
