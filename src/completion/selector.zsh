function _fzf-completion-selector() {
  FZF_PREVIEW_LBUFFER=${LBUFFER/%?/}

  setopt local_options BASH_REMATCH

  for key in ${(k)fzf_preview_commands}; do
    [[ "$FZF_PREVIEW_LBUFFER" =~ $key ]]
    if [[ $BASH_REMATCH[1] != "" ]]; then
      local id=$fzf_preview_commands[$key]
    fi
    unset BASH_REMATCH
  done

  if which $id > /dev/null 2>&1; then
    eval $id
  else
    zle expand-or-complete
  fi
}

zle -N fzf-completion-selector _fzf-completion-selector
