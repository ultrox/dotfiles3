export DOTFILES=$HOME/dotfiles

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

source $DOTIFILE/zsh/private/_env.zsh
source $DOTIFILE/zsh/private/aliases.zsh
source $DOTIFILE/zsh/private/functions.zsh
source $DOTIFILE/zsh/private/_fzf_env.zsh




export FILE='ranger'
export TERMINAL='kitty'
export EDITOR='nvim'
export BROWSER='google-chrome'
export READER='zathura'

export PAGER='less'
export WM='i3'

export N_PREFIX="$HOME/.config/n"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export MY_SCRIPTS=$DOTIFILES/scripts
export GIT_EDITOR=$VIM

# # Cleanup
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

addToPath $MY_SCRIPTS
addToPath $N_PREFIX/bin
addToPath ~/.local/bin


# # setxkbmap -option caps:swapescape

if [ -f ~/.git-completion.bash ]; then
   . ~/.git-completion.bash
fi
