function compile-ssh-config --description 'Generate a combined ssh config from ~/.ssh/config.d/ files'

	printf '# WARNING: This file is generated by fish; local changes will be overwritten!\n' > $HOME/.ssh/config

	for file in $HOME/.ssh/config.d/*
		printf '\n##### SOURCE: %s\n\n' "$file" >> $HOME/.ssh/config
		cat "$file" >> $HOME/.ssh/config
	end

end
