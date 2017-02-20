function c
  set -l CDPATH $PROJECTS
  echo $argv
  cd "$PROJECTS/$argv"
end
