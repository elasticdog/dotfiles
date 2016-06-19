function fish_user_key_bindings --description 'Custom key bindings'

	# bind Ctrl-l to clear the screen
	bind -M insert \cl 'clear; commandline -f repaint'

end
