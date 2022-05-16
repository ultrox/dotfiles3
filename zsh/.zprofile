export DOTFILES=$HOME/dotfiles
export ZSH_LOC=$DOTFILES/zsh

# not needed zim handles it (probably)
#source /usr/share/fzf/completion.zsh
#source /usr/share/fzf/key-bindings.zsh

#source $DOTIFILE/zsh/private/_env.zsh
#source $DOTIFILE/zsh/private/aliases.zsh
#source $DOTIFILE/zsh/private/functions.zsh
#source $DOTIFILE/zsh/private/_fzf_env.zsh

export FILE='ranger'
export TERMINAL='kitty'
export EDITOR='nvim'
export BROWSER='google-chrome'
export READER='zathura'

export PAGER='less'
export WM='i3'

# (fnm for the win)
# export N_PREFIX="$HOME/.config/n"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export MY_SCRIPTS=$DOTFILES/scripts
export GIT_EDITOR=$VIM

# Hitory config
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
export HISTSIZE=12000


# # Cleanup
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

#source $DOTIFILE/zsh/private/paths.zsh

# # setxkbmap -option caps:swapescape

if [ -f ~/.git-completion.bash ]; then
   . ~/.git-completion.bash
fi
