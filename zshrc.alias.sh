# common alias
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -AlF'
alias sz='source ~/.zshrc'
alias zshrc='vim ~/.zshrc'
alias e_alias='vim ~/dotfiles/zshrc.alias.sh'
alias attend='cd ~/mf_works/mf_attendance && clear'
alias .f='cd ~/dotfiles'
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash/'
alias be='bundle exec'
alias spec='bundle exec rspec'
alias dice='echo $(($RANDOM % 6 + 1))'
alias bomb=':(){ :|:& };:'

if is_osx; then
  alias ls='ls -G'
  alias -g CP='| pbcopy'
  alias -g CC='| tee /dev/tty | pbcopy'
elif is_linux; then
  alias ls='ls --color=auto'
  # sudo apt-get install xsel
  alias -g CP='| xsel --clipboard --input'
fi

# Git
# http://postd.cc/git-command-line-shortcuts/
alias ga='git add'
alias gaa='ga .'
alias gai='ga -i'
alias gap='ga -p'
alias gan='ga -N'
alias gaaa='ga -A'
alias gb='git branch'
alias gba='gb -a'
alias gbc='git rev-parse --abbrev-ref HEAD'
alias gbd='gb -D'
alias gbm='gb -m'
alias gc='git commit'
alias gca='gc --amend'
alias gcam='gc --allow-empty -m'
alias gcm='gc -m'
alias gcmim='gc --allow-empty -m "Init milestone"'
alias gcmit='gc --allow-empty -m "Init topic"'
alias gcmtw='gc -m "tweak"'
alias gco='git checkout'
alias gfco='git fuzzy-checkout'
alias gcob='gco -b'
alias gcom='gco master'
alias gcop='gco -p'
alias gcln='git clean -n'
alias gclf='git clean -f'
alias gd='git diff'
alias gda='gd HEAD'
alias gdc='gd --cached'
# git fetch --prune
alias gf='git remote update --prune'
alias gi='git init'
alias gl='git line-log'
alias glp='gl -p'
alias glg='gl --graph --oneline --decorate'
alias gld='gl --pretty=format:"%h %ad %s" --date=short'
alias gm='git merge --no-ff'
alias gpl='git pull'
alias gps='git push'
alias gpsf='gps --force'
alias gpso='gps -u origin `git rev-parse --abbrev-ref HEAD`'
alias grb='git rebase'
alias grbum='grb upstream/master'
alias grbom='grb origin/master'
alias grba='grb --abort'
alias grbc='grb --continue'
alias grbs='grb --skip'
alias grv='git revert'
alias grst='git reset'
alias grh='grst HEAD --'
alias grp='grst -p'
alias gs='git status'
alias gss='git status -s'
alias s='gss'
alias gst='git stash save -u'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show'
alias gstsp='git stash show -p'
