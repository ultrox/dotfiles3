  # User configuration sourced by interactive shells
#
# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
export ZSH=$HOME/dotfiles/zsh

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# Start zim - completion is init here
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# load everything but the path and completion files After .zim
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# load every completion after autocomplete loads in zim
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done
#
# My Overrides
# 

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line

compdef vman="man"

# Emacs style
zle -N edit-command-line
# The same in vim (open command history to edit)
bindkey '^f' edit-command-line

# there is vimrc that dose the same in vim
bindkey '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word

# For when you need stuff you don't want public to see
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
unset config_files

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Put it in profile
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
export HISTSIZE=12000

#source /home/mavu/private/tmp/zsh-hist/zsh-hist.plugin.zsh

