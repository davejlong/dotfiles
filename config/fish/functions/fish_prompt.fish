function fish_prompt --description "Write out the prompt"
  set -l color_cwd
  set -l suffix
  switch $USER
    case root toor
      if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
      else
        set color_cwd $fish_color_cwd
      end
      set suffix '#'
    case '*'
      set color_cwd $fish_color_cwd
      set suffix '>'
  end

  set out

  # Show loadavg when too high
  set -l load1m (uptime | grep -o '[0-9]\+\.[0-9]\+' | head -n 1 | sed 's/ //g')
  set -l load1m_test (math $load1m \* 100 / 1)
  if test $load1m_test -gt 100
      set out "$out" (set_color yellow) "[load:$load1m]" (set_color normal)
  end

  # Show disk usage when too high
  set -l du (df / | tail -n1 | sed "s/  */ /g" | cut -d' ' -f5 | cut -d'%' -f1)
  if test $du -gt 80
    set out "$out" (set_color yellow) "[disk:$du%]" (set_color normal)
  end

  # Show git branch
  git_branch
  if set -q git_branch
      if test $git_dirty_count -gt 0
        set out "$out" (set_color red) "[$git_branch:$git_dirty_count]" (set_color normal)
      else
        set out "$out" (set_color green) "[$git_branch]" (set_color normal)
      end
  end

  set out $out "\n" (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "

  echo -n -s -e $out
end
