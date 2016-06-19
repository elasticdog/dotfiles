function fish_right_prompt --description 'Write out the right prompt'

	# only display user and hostname when connected via ssh
	if set -q SSH_CONNECTION
		if not set -q __fish_prompt_hostname
			set -g __fish_prompt_hostname (hostname -s)
		end

		if not set -q __fish_prompt_normal
			set -g __fish_prompt_normal (set_color normal)
		end

		# make it obvious if the current user is root
		switch $USER
			case root
				set -g __fish_prompt_color_user (set_color red)
			case '*'
				set -g __fish_prompt_color_user (set_color blue)
		end

		# write out the right prompt
		printf '%s%s%s at %s%s' (set_color cyan) $USER $__fish_prompt_normal $__fish_prompt_color_user $__fish_prompt_hostname
	end

end
