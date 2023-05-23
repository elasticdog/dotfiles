function gbdf --description 'Show diff of commits in current Git branch but not master'

	set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
	printf 'Commits in branch "%s", but not "master":\n' $current_branch
	command git diff master..$current_branch

end
