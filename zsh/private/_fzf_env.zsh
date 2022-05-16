# Use ag to respect .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

LOC="$HOME/.tldr/tldr/pages"

# trigger it with tldr **
_fzf_complete_tldr() {
  _fzf_complete "--multi --reverse" "$@" < <(
    find $LOC/{linux,common} -type f -printf "%f\n"
  )
}

_fzf_complete_tldr_post() {
    sed 's/\.md//'
}

fzf-tldr-widget() {
  local tldrmatch="$(find $LOC/{linux,common} -type f -printf "%f\n" \
  | sed 's/\.md//' \
  | FZF_DEFAULT_OPTS="
     --height ${FZF_TMUX_HEIGHT:-40%} 
     --reverse $FZF_DEFAULT_OPTS" fzf +m)"

  if [[ -z "$tldrmatch" ]]; then
    zle redisplay
    return 0
  fi
  tldr "$tldrmatch"
  local ret=$?
  zle fzf-redraw-prompt
  return $ret
}
zle     -N    fzf-tldr-widget
bindkey '^O'  fzf-tldr-widget
