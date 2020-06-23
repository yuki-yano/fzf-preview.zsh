: ${FZF_PREVIEW_DISABLE_DEFAULT_BINDKEY:=0}

if [[ $FZF_PREVIEW_DISABLE_DEFAULT_BINDKEY -eq 0 ]]; then
  bindkey '^r'   fzf-history-selection
  bindkey '^x^v' fzf-grep-vscode
  bindkey '^x^c' fzf-cd
  bindkey '^x^g' fzf-ghq
  bindkey '^x^s' fzf-snippet-selection
fi
