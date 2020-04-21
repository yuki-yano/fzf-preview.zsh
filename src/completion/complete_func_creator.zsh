function _create_complete_func() {
  local complete_func_name=$1
  local callback=$2

  complete_func=$(cat << EOS
function ${complete_func_name} () {
  local candidate_command=\$1
  local candidates=\$(eval \$candidate_command)
  _fzf_complete '' "\$BUFFER" < <( echo \$candidates )
  BUFFER=\${BUFFER//\#/}
  zle reset-prompt
}
EOS
)
  eval $complete_func

  complete_func_post=$(cat << EOS
function ${complete_func_name}_post () {
  ${callback}
}
EOS
)
  eval $complete_func_post
}
