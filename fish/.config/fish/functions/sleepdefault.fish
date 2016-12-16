function sleepdefault --description 'Set hibernation mode to the system default'

	command sudo pmset -a destroyfvkeyonstandby 0 hibernatemode 3

end
