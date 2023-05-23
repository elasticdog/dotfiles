function ini-section --description 'Read a single section from an INI file'

	if set -q $argv
		echo 'Usage: ini-section <section> <file>'
		echo 'Read a single section from an INI file'
	else
		command sed -n "/\[$argv[1]\]/,/\[.*\]/p" $argv[2]
	end

end
