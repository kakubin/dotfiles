autoload -Uz compinit && compinit
export LANG=ja_JP.UTF-8
setopt print_eight_bit # 日本語表示可能
export EDITOR=vim

export DB_USERNAME='root'
export DB_PASSWORD=''

## PROMPT
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz is-at-least
# autoload -Uz add-zsh-hook
setopt prompt_subst # PROMPT変数内で変数参照するのに必要

# ref:http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
# ref:https://qiita.com/knao124/items/04e3625eb12237de5743
if is-at-least 4.3.10; then
#   zstyle ':vcs_info:git:*' enable git svn hg bzr
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "*"
  zstyle ':vcs_info:git:*' formats '(%b%c%u)'
  zstyle ':vcs_info:git:*' actionformats '(%b%c%u|%a)'
fi

# プロンプト表示直前にvcs_info呼び出し
_update_vcs_info_msg () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
# PROMPT="%F{140}%~%f:%1(v|%F{160}%1v%f|) $ "
PROMPT="%F{220}%~%f:%1(v|%F{202}%1v%f|) $ "
RPROMPT="%F{118}[%*]%f"

## PATH
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
export PATH=$HOME/.yarn/bin:$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export GOPATH="$HOME/go"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$PATH:$GOPATH/bin"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --hidden --files --follow -g "!.git/*"'

ostype() {
  echo ${(L):-$(uname)}
}

os_detect() {
  case "$(ostype)" in
    *'linux'*)  PLATFORM='linux'   ;;
    *'darwin'*) PLATFORM='osx'     ;;
    *'bsd'*)    PLATFORM='bsd'     ;;
    *)          PLATFORM='unknown' ;;
  esac
  export PLATFORM
}

is_osx() {
  os_detect
  if [ "$PLATFORM" = "osx" ]; then
    return 0
  else
    return 1
  fi
}

is_linux() {
  os_detect
  if [ "$PLATFORM" = "linux" ]; then
    return 0
  else
    return 1
  fi
}

command_not_found_handler() {
  echo -e "\\n███    ██  ██████  ████████ ███████  ██████  ██    ██ ███    ██ ██████\\n████   ██ ██    ██    ██    ██      ██    ██ ██    ██ ████   ██ ██   ██\\n██ ██  ██ ██    ██    ██    █████   ██    ██ ██    ██ ██ ██  ██ ██   ██\\n██  ██ ██ ██    ██    ██    ██      ██    ██ ██    ██ ██  ██ ██ ██   ██\\n██   ████  ██████     ██    ██       ██████   ██████  ██   ████ ██████\\n"
}

source ~/dotfiles/zshrc.alias.sh
