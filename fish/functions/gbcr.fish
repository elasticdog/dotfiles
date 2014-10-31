function gbcr --description 'Create a new Git branch off of master'

	if test -z $argv[1]
		echo 'Usage: gbcr <branchname>'
		echo 'Creates a new branch named <branchname> with master as its start point'
	else
		git checkout -b "$argv[1]" master
	end

end
