FZF_PREVIEW_BIN_PATH="${0:a:h}/bin"
FZF_PREVIEW_CONFIG_DIR="${0:a:h}/config"
: ${FZF_PREVIEW_DISABLE_DEFAULT_SETTING:=0}
: ${FZF_PREVIEW_USER_CONFIG_DIR:="${XDG_CONFIG_HOME:-$HOME/.config}/fzf-preview.zsh"}
: ${FZF_PREVIEW_DEFAULT_SETTING:='--sync --height="80%" --preview-window="down:60%" --expect="ctrl-space" --header="C-Space: continue fzf completion"'}
: ${FZF_PREVIEW_DEFAULT_BIND:='ctrl-d:preview-page-down,ctrl-u:preview-page-up,?:toggle-preview'}
: ${FZF_PREVIEW_ENABLE_TMUX:=0}

FZF_PREVIEW_SNIPPET_CONFIG_DIR="${FZF_PREVIEW_USER_CONFIG_DIR}/snippet"
FZF_PREVIEW_SNIPPET_EDITOR=${EDITOR:-vim}
FZF_PREVIEW_SNIPPET_FILE="#{FZF_PREVIEW_USER_CONFIG_DIR}/_snippet"

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

fpath+=${0:a:h}/src/widget
for f in ${0:h}/src/widget/*(N-.); do
  local function_name="${f:t}"
  autoload -Uz -- "${function_name}"
  zle -N -- "${function_name}"
done
unset f

fpath+=${0:a:h}/src/snippet/util
for f in ${0:h}/src/snippet/util/*(N-.); do
  local function_name="${f:t}"
  autoload -Uz -- "${function_name}"
done
unset f

fpath+=${0:a:h}/src/snippet/widget
for f in ${0:h}/src/snippet/widget/*(N-.); do
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

if [[ "${FZF_PREVIEW_USER_CONFIG_DIR}/completion" != '' ]]; then
  fpath+="${FZF_PREVIEW_USER_CONFIG_DIR}/completion"
  for f in ${FZF_PREVIEW_USER_CONFIG_DIR}/completion/*(N-.); do
    local function_name="${f:t}"
    autoload -Uz -- "${function_name}"
  done
fi
unset f

source ${0:h}/src/bind.zsh
