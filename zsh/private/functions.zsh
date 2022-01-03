#!/bin/bash

function duh() {du -hs .[^.]*}
function killport() { lsof -i tcp:"$@" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}
function freeport() { lsof -t -i:$1 | xargs kill ;}

function gj() {
  cd $(git rev-parse --show-toplevel)
}

function listkeys() {  
  for keyfile in ~/.ssh/id_*; do ssh-keygen -l -f "${keyfile}"; done | uniq
}

function genkey() {
  ssh-keygen -o -a 100 -t ed25519 -f $HOME/.ssh/$1 -C "$2" -N ''
}

# directorys 
function t() {
  tree -L ${1-2} -I 'node_modules' --dirsfirst -a
}

function myip() {
  ip a |grep "inet "| grep -v 127.0.0.1 | awk '{print $2}'
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

function take () { mkdir -p "$@" && cd "$@"; }

# missing piece for tldr
add() {
    local files
    IFS=$'\n' files=($(find ~/.tldrc/tldr-master/pages -type f \( ! -name "\.DS_Store" \)| fzf-tmux --preview 'head -30 {}' --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  }


kill-p-ports () {
	kill-port 8001,8091, 8092, 11210
}
