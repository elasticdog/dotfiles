function fish_prompt --description 'Write out the prompt'

	# save the return status and duration of the previous command
	set -l previous_command_info (command printf '%s\n%s' $status $CMD_DURATION)

	# change the prompt color if the previous command returned an error
	set -l previous_status $previous_command_info[1]
	if test $previous_status -eq 0
		set -g __fish_prompt_color_status (set_color --bold yellow)
	else
		set -g __fish_prompt_color_status (set_color red)
	end

	# display the previous command's duration if it was > 1 sec
	#
	# NOTE: this will be changing soon due to:
	#     https://github.com/fish-shell/fish-shell/pull/1590
	# ...and I'll have to do something like this instead:
	#     date -u -d @$CMD_DURATION "+%kh %Mm %Ss"
	set -l previous_duration
	if test (count $previous_command_info) = 2
		set previous_duration $previous_command_info[2]
	end
	if not set -q __fish_prompt_color_duration
		set -g __fish_prompt_color_duration (set_color yellow)
	end

	# set desired output options for the __fish_git_prompt function
	set -g __fish_git_prompt_color 666
	set -g __fish_git_prompt_color_branch white
	set -g __fish_git_prompt_showcolorhints true
	set -g __fish_git_prompt_showdirtystate true
	set -g __fish_git_prompt_showuntrackedfiles

	# make it obvious if the current user is root
	switch $USER
		case root
			set -g __fish_prompt_color_pwd (set_color $fish_color_cwd_root)
			set -g __fish_prompt_character '#'
		case '*'
			set -g __fish_prompt_color_pwd (set_color normal)
			set -g __fish_prompt_character '❯'
	end

	# write out the prompt
	printf '\n%s%s%s %s%s\n' $__fish_prompt_color_pwd (smart_pwd) (__fish_git_prompt) $__fish_prompt_color_duration $previous_duration
	printf '%s%s ' $__fish_prompt_color_status $__fish_prompt_character

end
