# dotfiles
## Darwin
1. capsLockとctrlを入れ替える
2. 入力言語の切り替えを<⌘-Space>にする

```
./setup.sh
```

## Linux

```
./setup.sh
chsh
```

## 共通

```
cd .ssh & ssh keygen -t rsa
pbcopy < ~/.ssh/id_rsa.pub
ssh -T git@github.com
```
