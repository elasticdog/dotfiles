function vim --description 'Alias for Neovim, if available'

	if command -s nvim >/dev/null
		command nvim $argv
	else
		command vim $argv
	end

end
