function gh_issue() {
  local id="gh_issue"

  local candidate_command="gh issue list --limit 100"

  local -a fzf_options
  fzf_options+=("--ansi")
  fzf_options+=("--height=100%")
  fzf_options+=("--prompt='Issue> '")
  fzf_options+=("--header='C-o: open, C-c: closed, C-a: all'")
  fzf_options+=('--preview="gh issue view {1}"')

  local -a bind=("${FZF_PREVIEW_DEFAULT_BIND}")
  bind+=("ctrl-o:reload(gh issue list --limit 100 --state open)")
  bind+=("ctrl-c:reload(gh issue list --limit 100 --state closed)")
  bind+=("ctrl-a:reload(gh issue list --limit 100 --state all)")
  fzf_options+=("--bind=\"${(j:,:)bind}\"")

  local callback=("awk '{ print \$1 }'")

  local complete_func_name="_fzf_complete_${id}"
  _create_complete_func $complete_func_name  "${callback}"
  FZF_COMPLETION_OPTS=${(j: :)${fzf_options}}
  eval $complete_func_name "\"${candidate_command}\""
}

function gh_pr() {
  local id="gh_pr"

  local candidate_command="gh pr list --limit 100"

  local -a fzf_options
  fzf_options+=("--ansi")
  fzf_options+=("--height=100%")
  fzf_options+=("--prompt='PullRequest> '")
  fzf_options+=("--header='C-o: open, C-c: closed, C-m: merged, C-a: all'")
  fzf_options+=('--preview="gh pr view {1}"')

  local -a bind=("${FZF_PREVIEW_DEFAULT_BIND}")
  bind+=("ctrl-o:reload(gh issue list --limit 100 --state open)")
  bind+=("ctrl-c:reload(gh issue list --limit 100 --state closed)")
  bind+=("ctrl-m:reload(gh issue list --limit 100 --state merged)")
  bind+=("ctrl-a:reload(gh issue list --limit 100 --state all)")
  fzf_options+=("--bind=\"${(j:,:)bind}\"")

  local callback=("awk '{ print \$1 }'")

  local complete_func_name="_fzf_complete_${id}"
  _create_complete_func $complete_func_name  "${callback}"
  FZF_COMPLETION_OPTS=${(j: :)${fzf_options}}
  eval $complete_func_name "\"${candidate_command}\""
}
