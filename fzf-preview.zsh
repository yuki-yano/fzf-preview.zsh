FZF_PREVIEW_BIN_PATH="${0:a:h}/bin"
FZF_PREVIEW_CONFIG_DIR="${0:a:h}/config"
FZF_PREVIEW_USER_CONFIG_DIR=${FZF_PREVIEW_USER_CONFIG_DIR:-''}
FZF_PREVIEW_DEFAULT_BIND=${FZF_PREVIEW_DEFAULT_BIND:-'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'}

typeset -g -A fzf_preview_commands=()

for f in ${0:h}/src/**/*.zsh(D); do
  source "$f"
done
unset f

for f in ${0:h}/config/**/*.zsh(D); do
  source "$f"
done
unset f

if [[ $FZF_PREVIEW_USER_CONFIG_DIR != '' ]]; then
  for f in $FZF_PREVIEW_USER_CONFIG_DIR/**/*.zsh(D); do
    source "$f"
  done
fi
unset f

for f in ${0:h}/config/**/*.yml(D); do
  eval $(parse_yaml "$f" fzf_preview_)
done
unset f
