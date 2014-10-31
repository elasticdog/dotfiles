function smart_pwd --description 'Print the current working directory, dynamically tailored based on the environment'

	if not set -q __fish_prompt_color_vcs_indicator
		set -g __fish_prompt_color_vcs_indicator (set_color green)
	end

	if not set -q __fish_prompt_color_pwd
		set -g __fish_prompt_color_pwd (set_color normal)
	end

	if set prefix (command git rev-parse --show-prefix ^ /dev/null)
		printf '%s⠵ %s%s/%s\n' $__fish_prompt_color_vcs_indicator $__fish_prompt_color_pwd (command git rev-parse --show-toplevel | sed -e "s|.*/||") $prefix
	else
		printf '%s\n' $PWD | sed -e "s|^$HOME|~|"
	end

end
