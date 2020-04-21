function git_add() {
  local id="git_add"

  local candidate_command="git status --short"

  local -a fzf_options
  fzf_options+=("--ansi")
  fzf_options+=("--multi")
  fzf_options+=("--height=100%")
  fzf_options+=("--prompt='Git Add Files> '")
  fzf_options+=("--preview='$FZF_PREVIEW_BIN_PATH/git-diff-preview {}'")

  local callback=("awk '{if (substr(\$0,2,1) !~ / /) print \$2}'")

  local complete_func_name="_fzf_complete_${id}"
  _create_complete_func $complete_func_name  "${callback}"
  FZF_COMPLETION_OPTS=${(j: :)${fzf_options}}
  eval $complete_func_name "\"${candidate_command}\""
}

function git_branch() {
  local id="git_branch"

  local candidate_command="git for-each-ref refs/heads refs/remotes --format='[branch] %(refname:short)' 2> /dev/null"

  local -a fzf_options
  fzf_options+=("--ansi")
  fzf_options+=("--multi")
  fzf_options+=("--height=100%")
  fzf_options+=("--prompt='Git Branch> '")
  fzf_options+=("--preview=\"git log \$(echo {} | awk '{ print \$2 }') --graph --color=always 2>/dev/null\"")

  local callback=("awk '{ print \$2 }'")

  local complete_func_name="_fzf_complete_${id}"
  _create_complete_func $complete_func_name  "${callback}"
  FZF_COMPLETION_OPTS=${(j: :)${fzf_options}}
  eval $complete_func_name "\"${candidate_command}\""
}

function git_reset_file() {
  local id="git_reset_file"

  local candidate_command="git status --short"

  local -a fzf_options
  fzf_options+=("--ansi")
  fzf_options+=("--multi")
  fzf_options+=("--height=100%")
  fzf_options+=("--prompt='Git Reset Files> '")
  fzf_options+=("--preview='$FZF_PREVIEW_BIN_PATH/git-diff-preview {}'")

  local callback=("awk '{if (substr(\$0,1,1) ~ /M|A|D/) print \$2}'")

  local complete_func_name="_fzf_complete_${id}"
  _create_complete_func $complete_func_name  "${callback}"
  FZF_COMPLETION_OPTS=${(j: :)${fzf_options}}
  eval $complete_func_name "\"${candidate_command}\""
}
