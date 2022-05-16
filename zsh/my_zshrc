# User configuration sourced by interactive shells
# Global: $ZSH_LOC, $HOME  (loaded from profile)

# Start Dev stuff to be disabled later
alias vim=nvim
alias gs='git status'
source ~/dotfiles/zsh/.zprofile
# End Dev stuff to be disabled later

## Most important thing to be in env: The rest are using some fn from it
source $ZSH_LOC/private/_env_needed

typeset -U config_files
config_files=($ZSH_LOC/**/*.zsh)

# load everything but _env_needed
for file in ${config_files}
do
  source $file
done

# This is where the rest stuff goes that people typically 
# throw in .zshrc

eval "`fnm env`" # added to path
eval "$(mcfly init zsh)" 


#
# My Overrides
# 


compdef vman="man"

# Emacs style
zle -N edit-command-line
# The same in vim (open command history to edit)
# Opens current command in temproarly vim buffer
bindkey '^f' edit-command-line
# It used to be like that Ctrl-x-e to edit command line
# autoload -U edit-command-line

# there is vimrc that dose the same in vim
bindkey '^H' backward-kill-word
bindkey -M viins '^H' backward-kill-word

# For when you need stuff you don't want public to see
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
unset config_files


#source /home/mavu/private/tmp/zsh-hist/zsh-hist.plugin.zsh

