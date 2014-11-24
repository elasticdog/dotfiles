function ssha --description 'Generate a salted SHA1 hash for htpasswd use'

	if test (count $argv) -ne 2
		echo 'Usage: ssha <USERNAME> <PASSWORD>'
		echo 'Generate a salted SHA1 hash for an htpasswd authentication file'
	else
		set -l username $argv[1]
		set -l password $argv[2]
		set -l salt (openssl rand -base64 3)
		set -l ssha (printf '%s%s' "$password" "$salt" | openssl dgst -binary -sha1 | begin; set -lx LC_CTYPE C; set -lx LANG C; sed 's/$/'"$salt/"; end | base64)
		printf '%s:{SSHA}%s\n' "$username" "$ssha"
	end

end
