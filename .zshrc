autoload -Uz compinit && compinit
export LANG=ja_JP.UTF-8
setopt print_eight_bit # 日本語表示可能
export EDITOR=vim

## PROMPT
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz is-at-least
autoload -Uz add-zsh-hook
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
eval "$(nodenv init -)"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export GOPATH="$HOME/go"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$PATH:$GOPATH/bin"
PYENV_ROOT="${HOME}/.pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

#java
# export PATH="/usr/local/opt/sbt@0.13/bin:$PATH"

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# 基本ここにあると思う
# export BUNDLE_BUILD__MYSQL2='--with-ldflags=-L/usr/local/opt/openssl@1.1/lib'

# TODO: dvm入れるたびに環境変数がzshrc一番下に追加されちゃう
export DVM_DIR="$HOME/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

if [ -e $HOME/.deno/bin ]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

# export PATH="$HOME/fvm/default/bin:$PATH"
# export PATH="$HOME/.pub-cache/bin:$PATH"

export PATH="$HOME/.tfenv/bin:$PATH"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --hidden --files --follow -g "!.git/*"'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --bind up:preview-up,down:preview-down'

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

# snippets
# https://www.rasukarusan.com/entry/2020/04/19/193450
show_snippets() {
  local snippets=$(cat ~/dotfiles/zsh_snippets | fzf | cut -d':' -f2-)
  LBUFFER="${LBUFFER}${snippets}"
  zle reset-prompt
}

zle -N show_snippets
bindkey '^n' show_snippets


fzf-src() {
  local selected=$(ghq list --full-path | fzf)
  if [ -n "$selected" ]; then
    LBUFFER="builtin cd $selected"
    zle accept-line
  fi
  zle reset-prompt
}

zle -N fzf-src
bindkey '^Xs' fzf-src

command_not_found_handler() {
  echo -e "\\n███    ██  ██████  ████████ ███████  ██████  ██    ██ ███    ██ ██████\\n████   ██ ██    ██    ██    ██      ██    ██ ██    ██ ████   ██ ██   ██\\n██ ██  ██ ██    ██    ██    █████   ██    ██ ██    ██ ██ ██  ██ ██   ██\\n██  ██ ██ ██    ██    ██    ██      ██    ██ ██    ██ ██  ██ ██ ██   ██\\n██   ████  ██████     ██    ██       ██████   ██████  ██   ████ ██████\\n"
}

if [ $SHLVL = 1 ]; then
  tmux
fi

source ~/dotfiles/common_aliases

. /usr/local/opt/asdf/libexec/asdf.sh
