function vim --description 'Alias for Neovim, if available'

	if command -qs nvim
		command nvim $argv
	else
		command vim $argv
	end

end
