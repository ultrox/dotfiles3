#!/usr/bin/env zsh

# Super cool keyboard stuffs.
# Required for x applications
setxkbmap -option caps:ctrl_modifier

export STOW_FOLDERS="bin,nvim,i3,zsh"

die () {
    echo >&2 "$@"
    exit 1
}

addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

commitDotFiles() {
    pushd $DOTFILES
    pushd personal
    git add .
    git commit -m "automagic messaging from me in the past."
    git push origin master
    popd
    git add .
    git commit -m "automagic messaging from me in the past."
    git push origin master
    popd
}
