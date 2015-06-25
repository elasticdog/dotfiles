function gmup --description 'Update the Git master branch'

	if git config --get 'branch.master.remote'
		set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
		pushd $PWD
		gcd
		command git checkout master
		command git pull --rebase
		command git remote prune origin
		command git checkout $current_branch
		popd
	end

end
