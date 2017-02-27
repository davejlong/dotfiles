function git_branch
  set -g git_branch (git rev-parse --abbrev-ref HEAD ^ /dev/null)
  if [ $status -ne 0 ]
    set -ge git_branch
    set -g git_dirty_count 0
  else
    set -g git_dirty_count (git status --porcelain | wc -l | sed "s/ //g")
  end
end
