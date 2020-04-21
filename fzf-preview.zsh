FZF_PREVIEW_BIN_PATH="${0:a:h}/bin"
FZF_PREVIEW_CONFIG_DIR="${0:a:h}/config"
FZF_PREVIEW_USER_CONFIG_DIR=${FZF_PREVIEW_USER_CONFIG_DIR:-''}
FZF_PREVIEW_DEFAULT_BIND=${FZF_PREVIEW_DEFAULT_BIND:-'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'}

for f in ${0:h}/src/**/*.zsh(D); do
  source "$f"
done
unset f

fpath+=${0:a:h}/config
for f in ${0:h}/config/*(N-.); do
  autoload -Uz $f
done
unset f

if [[ $FZF_PREVIEW_USER_CONFIG_DIR != '' ]]; then
  fpath+=$FZF_PREVIEW_USER_CONFIG_DIR
  for f in $FZF_PREVIEW_USER_CONFIG_DIR/*(N-.); do
    autoload -Uz $f
  done
fi
unset f
