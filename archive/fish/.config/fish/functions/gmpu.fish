function gmpu --description 'Push the Git master branch'

	if git config --get 'branch.master.remote'; then
		set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
		pushd $PWD
		gcd
		command git checkout master
		command git push
		command git checkout $current_branch
		popd
	end

end
