typeset -g -A fzf_preview_commands=()

fzf_preview_commands[(git add)]="git_add"
fzf_preview_commands[(git branch -(d|D))]="git_branch"
fzf_preview_commands[(git reset --)]="git_reset_file"
fzf_preview_commands[((git reset)|git reset (--soft|--hard))]="git_reset_branch"
fzf_preview_commands[(git diff --)]="git_diff_file"
fzf_preview_commands[(git diff)]="git_diff_branch"
fzf_preview_commands[(git checkout --)]="git_checkout_file"
fzf_preview_commands[(git (checkout|switch))]="git_checkout_branch"
fzf_preview_commands[(git checkout?( -t))]="git_checkout_branch"

fzf_preview_commands[(gh issue view)]="gh_issue"
fzf_preview_commands[(gh issue view --web)]="gh_issue"
fzf_preview_commands[(gh pr view)]="gh_pr"
fzf_preview_commands[(gh pr view --web)]="gh_pr"
fzf_preview_commands[(gh pr view checkout)]="gh_pr"
