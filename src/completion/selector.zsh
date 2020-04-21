function _fzf-completion-selector() {
  setopt local_options BASH_REMATCH

  local command=$1
  eval "fzf-preview-symbol-${command}"

  for regex in ${(k)symbols}; do
    [[ ${LBUFFER/%?/} =~ $regex ]]
    if [[ ${BASH_REMATCH[1]} != "" ]]; then
      local symbol=$symbols[$regex]
    fi
    unset BASH_REMATCH
  done

  local completion_function="fzf-preview-command-${symbol}"
  if [[ $symbol != "" ]] && which $completion_function > /dev/null 2>&1; then
    eval "fzf-preview-command-${symbol}"
  else
    zle expand-or-complete
  fi
}

zle -N fzf-completion-selector _fzf-completion-selector
