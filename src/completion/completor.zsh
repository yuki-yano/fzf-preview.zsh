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

  local -a settings
  for f in $FZF_PREVIEW_CONFIG_DIR/**/*.zsh(D); do
    settings+=("${${f##*/}%.*}")
  done
  unset f

  if [[ $FZF_PREVIEW_USER_CONFIG_DIR != '' ]]; then
    for f in $FZF_PREVIEW_USER_CONFIG_DIR/**/*.yml(D); do
      settings+=("${${f##*/}%.*}")
    done
  fi
  unset f

  if (( $settings[(I)$command] )); then
    zle fzf-completion-selector $command
  else
    zle expand-or-complete
  fi
}

zle -N fzf-or-normal-completion _fzf-or-normal-completion
