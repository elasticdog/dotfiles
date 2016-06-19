function gbup --description 'Update the Git master branch and rebase against it'

	gmup
	command git rebase master

end
