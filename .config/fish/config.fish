
function edit_cmd --description 'Edit cmdline in editor'
	set -l f (mktemp --tmpdir=.)
	set -l p (commandline -C)
	commandline -b > $f
	$EDITOR -c set\ ft=fish $f
	commandline -r (more $f)
	commandline -C $p
	rm $f
end

bind \cv edit_cmd


function fish_prompt -d "Write out the prompt"
  printf '\n%s%s@%s%s %s%s\n%s%s%s > ' (set_color 5a5) $USER (set_color 779) $hostname (set_color 9c7) $(git branch --show-current 2>/dev/null || echo '') \
	  (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

