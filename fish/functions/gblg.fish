function gblg --description 'Show log of commits in current Git branch but not master'

	set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
	printf 'Commits in branch "%s", but not "master":\n' $current_branch
	command git log master..$current_branch --pretty=format:'%C(yellow)%h%C(green)%d%C(reset) %s %C(cyan)[%cr]%C(reset)' --graph --date=relative -M -C

end
