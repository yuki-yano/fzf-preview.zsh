function _fzf-or-normal-completion() {
  if [[ $BUFFER[-1] == $FZF_COMPLETION_TRIGGER && $BUFFER[-2] == " " ]]; then
    zle fzf-completion
    return
  fi

  if [[ $BUFFER[-1] != " " ]]; then
    zle expand-or-complete
    return
  fi

  local tokens=(${(z)BUFFER})
  local command=${tokens[1]}

  local -a settings=(git gh)

  if (( $settings[(I)$command] )); then
    zle fzf-completion-selector $command
  else
    zle expand-or-complete
  fi
}

zle -N fzf-or-normal-completion _fzf-or-normal-completion
