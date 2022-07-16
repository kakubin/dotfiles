# set -eu
set -o pipefail

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

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

stty -ixon

bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

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
# PROMPT="%F{220}%~%f:%1(v|%F{208}%1v%f|) %F{001}》%f"
# PROMPT="%F{248}%~%f:%1(v|%F{065}%1v%f|)%F{001}ᚩ %f"
# PROMPT=%F{208}%~%f:%1(v|%F{065}%1v%f|)%F{001}$'%{\e[5m%}❯❯❯ %{\e[0m%}'%f
PROMPT=%F{208}%~%f:%1(v|%F{110}%1v%f|)%F{001}$'%{\e[5m%}❯❯❯ %{\e[0m%}'%f
RPROMPT=%F{115}[%*]%f

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
  if [[ "$PLATFORM" = "osx" ]]; then
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

## PATH
eval "$(nodenv init -)"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# 基本ここにあると思う
# export BUNDLE_BUILD__MYSQL2='--with-ldflags=-L/usr/local/opt/openssl@1.1/lib'

if [[ -e $HOME/.deno/bin ]]; then
  export DENO_INSTALL="$HOME/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
fi

if is_linux; then
  export PATH="$PATH:$HOME/snap/flutter/common/flutter/bin"
else
  export PATH="$PATH:$HOME/flutter/bin"
fi

export PATH="$HOME/.tfenv/bin:$PATH"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --hidden --files --follow -g "!.git/*"'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --bind up:preview-up,down:preview-down'

# snippets
# https://www.rasukarusan.com/entry/2020/04/19/193450
show_snippets() {
  local snippets=$(cat ~/dotfiles/zsh_snippets | fzf | cut -d':' -f2-)
  LBUFFER="${LBUFFER}${snippets}"
  zle reset-prompt
}

zle -N show_snippets
bindkey '^B' show_snippets


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

if [[ $SHLVL = 1 ]]; then
  tmux
fi

source ~/dotfiles/common_aliases

# function pssh() {
#   local host=$(grep -r 'Host ' $HOME/.ssh/* | cut -d' ' -f2 | sort | peco)
#   if [ ! -z "$host" ]; then
#     ssh "$host"
#   fi
# }

if is_osx; then
  . /usr/local/opt/asdf/libexec/asdf.sh
  export PATH="/usr/local/opt/sbt@0.13/bin:$PATH"
fi

eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=""
