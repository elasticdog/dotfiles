function gbcl --description 'Clean up local branches that have already been merged upstream'

	if gmup
		set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
		pushd $PWD
		gcd
		command git checkout master
		command git branch --merged master | grep -v '^* master$' | xargs -n 1 git branch -d
		popd
	end

end
