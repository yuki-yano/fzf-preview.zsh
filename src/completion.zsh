function _fzf-or-normal-completion() {
  local tokens cmd
  setopt localoptions noshwordsplit

  if [[ $BUFFER[-1] == $FZF_COMPLETION_TRIGGER && $BUFFER[-2] == " " ]]; then
    zle fzf-completion
    return
  fi

  if [[ $BUFFER[-1] != " " ]]; then
    zle expand-or-complete
    return
  fi

  tokens=(${(z)BUFFER})
  cmd=${tokens[1]}

  local -a settings
  for f in $FZF_PREVIEW_CONFIG_DIR/**/*.yml(D); do
    settings+=("${${f##*/}%.*}")
  done
  unset f

  if [[ $FZF_PREVIEW_USER_CONFIG_DIR != '' ]]; then
    for f in $FZF_PREVIEW_USER_CONFIG_DIR/**/*.yml(D); do
      settings+=("${${f##*/}%.*}")
    done
  fi
  unset f

  if (( $settings[(I)$cmd] )); then
    zle fzf-preview-completion $cmd
  else
    zle expand-or-complete
  fi
}
zle -N fzf-or-normal-completion _fzf-or-normal-completion

function _fzf-preview-completion() {
  local cmd=$1

  FZF_PREVIEW_LBUFFER=${LBUFFER/%?/}
  local symbol=$fzf_preview_commands['${FZF_PREVIEW_LBUFFER}']

  if [[ -v "fzf_preview_${symbol}_symbol" ]]; then
    local candidate_command="fzf_preview_${symbol}_candidate"

    local bind_val="fzf_preview_${symbol}_bind"
    local bind=${(j:,:)${(P)$(echo $bind_val)}}

    if [[ -n $bind ]]; then
      bind="${FZF_PREVIEW_DEFAULT_BIND},${bind}"
    else
      bind="${FZF_PREVIEW_DEFAULT_BIND}"
    fi

    local options="fzf_preview_${symbol}_fzf_options"
    local preview="fzf_preview_${symbol}_preview"
    FZF_COMPLETION_OPTS="--bind=\"${bind}\" --height=100% ${$(eval echo '$'${options})//\":\"/:} --preview=\"$(eval echo '$'${preview})\""

    local complete_func_name="_fzf_complete_${symbol}"
    _create_complete_func $complete_func_name $symbol

    eval $complete_func_name $candidate_command
  else
    zle expand-or-complete
  fi
}

function _create_complete_func() {
  local complete_func_name=$1
  local symbol=$2

  complete_func=$(cat << EOS
function ${complete_func_name} () {
  local candidate_command=\$1
  local candidates=\$(eval \${(P)candidate_command})
  _fzf_complete '' "\$BUFFER" < <( echo \$candidates )
}
EOS
)
  eval $complete_func

  local callback_val="fzf_preview_${symbol}_callback"
  local callback="$(eval echo '$'${callback_val})"
  complete_func_post=$(cat << EOS
function ${complete_func_name}_post () {
  ${callback}
}
EOS
)
  eval $complete_func_post
}

zle -N fzf-preview-completion _fzf-preview-completion
