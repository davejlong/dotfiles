function gitauthorship () {
  git ls-files -z |
  xargs -0 -n1 -E'\n' -i{} git blame --date short -wCMcp '{}' |
  perl -pe 's/^.*?\((.*?) +\d{4}-\d{2}-\d{2} +\d+\).*/\1/' |
  sort |
  uniq -c |
  sort -rn
}
