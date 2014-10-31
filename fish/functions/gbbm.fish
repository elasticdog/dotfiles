function gbbm --description 'Manually squash/fixup commits and merge into master, preserving the merge commit'
	# used for bigger branches; allows you to manually squash/fixup
	# branch commits into smaller, more logical/manageable chunks

	if gbup
		set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
		pushd $PWD
		gcd
		command git rebase --interactive --autosquash master
		command git checkout master
		command git merge --no-ff --no-commit $current_branch
		command git commit
		popd
	end

end
