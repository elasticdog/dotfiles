function smart_pwd

	if set prefix (command git rev-parse --show-prefix ^ /dev/null)
		printf '%s⠵ %s%s/%s\n' (set_color green) (set_color normal) (command git rev-parse --show-toplevel | sed -e "s|.*/||") $prefix
	else
		printf '%s\n' $PWD | sed -e "s|^$HOME|~|"
	end

end
