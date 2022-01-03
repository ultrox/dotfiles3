export PATH=~/.local/bin:$PATH
export N_PREFIX="$HOME/.config/n"
export PATH="$N_PREFIX/bin:$PATH"

export FILE='ranger'
export TERMINAL='kitty'
export EDITOR='nvim'
export BROWSER='google-chrome'
export READER='zathura'

export PAGER='less'
export WM='i3'

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export DOTFILES=$HOME/dotfiles
export GIT_EDITOR=$VIM

# # Cleanup
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# # setxkbmap -option caps:swapescape

if [ -f ~/.git-completion.bash ]; then
   . ~/.git-completion.bash
fi
