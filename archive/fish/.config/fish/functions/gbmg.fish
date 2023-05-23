function gbmg --description 'Squash all branch commits and merge into master'
	# most commonly used merge strategy

	if gbup
		set -l current_branch (command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
		pushd $PWD
		gcd
		command git checkout master

		# validate that the merge happens since we have to forcefully delete the branch
		if git merge --ff-only --squash $current_branch
			set -l message
			begin
				set -l IFS
				set message (printf 'Squashed commit of the following:\n\n'; git log master..$current_branch --pretty=format:'    * %ad %h - %s' --date=short)
			end
			command git commit --verbose --edit -m "$message"
			command git branch -D $current_branch
		end

		popd
	end

end
