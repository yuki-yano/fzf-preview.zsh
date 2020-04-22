FZF_PREVIEW_BIN_PATH="${0:a:h}/bin"
FZF_PREVIEW_CONFIG_DIR="${0:a:h}/config"
FZF_PREVIEW_DISABLE_DEFAULT_SETTING=${FZF_PREVIEW_DISABLE_DEFAULT_SETTING:-0}
FZF_PREVIEW_USER_CONFIG_DIR=${FZF_PREVIEW_USER_CONFIG_DIR:-"${XDG_CONFIG_HOME}/fzf-preview.zsh"}
FZF_PREVIEW_DEFAULT_BIND=${FZF_PREVIEW_DEFAULT_BIND:-'ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'}

fpath+=${0:a:h}/src/completion/util
for f in ${0:h}/src/completion/util/*(N-.); do
  local function_name="${f:t}"
  autoload -Uz -- "${function_name}"
done
unset f

fpath+=${0:a:h}/src/completion/widget
for f in ${0:h}/src/completion/widget/*(N-.); do
  local function_name="${f:t}"
  autoload -Uz -- "${function_name}"
  zle -N -- "${function_name}"
done
unset f

if [[ $FZF_PREVIEW_DISABLE_DEFAULT_SETTING -eq 0 ]]; then
  fpath+=${0:a:h}/config
  for f in ${0:h}/config/*(N-.); do
    local function_name="${f:t}"
    autoload -Uz -- "${function_name}"
  done
  unset f
fi

if [[ $FZF_PREVIEW_USER_CONFIG_DIR != '' ]]; then
  fpath+=$FZF_PREVIEW_USER_CONFIG_DIR
  for f in $FZF_PREVIEW_USER_CONFIG_DIR/*(N-.); do
    local function_name="${f:t}"
    autoload -Uz -- "${function_name}"
  done
fi
unset f
