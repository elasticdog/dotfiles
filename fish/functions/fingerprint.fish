function fingerprint --description 'Generate an AWS key pair fingerprint'
	# https://github.com/aws/aws-cli/issues/191

	if set -q $argv
		echo 'Usage: fingerprint <pubkey>'
		echo 'Generate the fingerprint of an SSH public key that matches the format used by AWS'
	else
		command ssh-keygen -f "$argv[1]" -e -m PKCS8 | command openssl pkey -pubin -outform DER | command openssl md5 -c
	end

end
