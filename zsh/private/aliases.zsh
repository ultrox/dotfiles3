#!/bin/bash

alias zcompfix='rm -rf ~/.zcomp* && exec zsh'

# habits making, habits breaking
function clear { echo "ctrl+l" ; }

alias lsof.who='lsof -nP -iTCP -sTCP:LISTEN'
alias listen='lsof -nP -iTCP -sTCP:LISTEN'

#git
alias gs='git status'
alias gst='git stash'
alias sl="git rev-parse --show-toplevel |xargs -I {} jq ".scripts" {}/package.json"
alias ep="git rev-parse --show-toplevel |xargs -I {} nvim {}/package.json"
alias gc="git commit -am"


alias gco="git checkout"
alias gcm="git commit -m"
alias gcf="git commit --fixup"
alias gri="git rebase -i"

# some other alias would take presidence if not like this

function glf() { git lg ${1--10} }
alias gl=glf
alias gla="git lg"
alias gd='git diff ":(exclude)yarn.lock"'
alias gds='git diff --staged'

alias glsf='git ls-files'
alias vim='nvim'

alias lsh="ls -ld .?* "
alias ick='ack -i --pager="less -R -S -X"'

# need more work
alias 'tldru'='~/.tldrc/tldr-master/update.sh'

# save your life
# Installed by brew completion by .zim 
# ~/.zim/modules/zsh-completions/src

alias rm=trash-put
alias rmf="rm -rf"

#alias ls="ls -GF --color=always" # not mac copatable
alias r!="source ~/.zshrc;echo done"
alias oldvim='/usr/share/vim'

#others
alias vim='nvim'
alias v='f -e nvim'

alias t='task'
alias tm='t minimal'

alias edit.i3='vim ~/.config/i3/config'
alias edit.kitty='vim ~/.config/kitty/kitty.conf'
alias npmplease="rm -rf node_modules/ && rm -f package-lock.json && npm install"
alias npmprettyplease="npm cache clean -f && rm -rf ./node_modules/ && rm -f package-lock.json && npm install"
alias rgf='rg --files | rg'

## Git Cli stuff
alias propen='gh pr view -w'

# https://github.com/sindresorhus/clipboard-cli
# npm install --global clipboard-cli
alias cb=clipboard
alias ls='exa --icons --color=always --group-directories-first -s extension'
alias last='ls -s time --long|tail -5'

alias incognito='unset HISTFILE'
alias pbcopy='xsel --clipboard --input' 
alias pbpaste='xsel --clipboard --output'

