function sleepsafe --description 'Set hibernation mode to be more secure'
	# https://github.com/drduh/macOS-Security-and-Privacy-Guide#full-disk-encryption

	command sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25

end
