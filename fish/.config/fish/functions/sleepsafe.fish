function sleepsafe --description 'Set hibernation mode to be more secure'

	command sudo pmset -a destroyfvkeyonstandby 1 hibernatemode 25

end
