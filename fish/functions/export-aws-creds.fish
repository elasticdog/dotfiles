function export-aws-creds --description 'Export AWS credentials into the shell environment'

	if set -q $argv
		echo 'Usage: export-aws-creds <profile>'
		echo 'Export the AWS credentials defined by the given profile into the shell environment'
	else
		set -l AWS_CREDENTIALS_FILE $HOME/.aws/credentials
		if test -f $AWS_CREDENTIALS_FILE
			set -xg AWS_ACCESS_KEY (ini-section $argv[1] $AWS_CREDENTIALS_FILE | awk '/^aws_access_key_id/{ print $3 }')
			set -xg AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY
			set -xg AWS_SECRET_KEY (ini-section $argv[1] $AWS_CREDENTIALS_FILE | awk '/^aws_secret_access_key/{ print $3 }')
			set -xg AWS_SECRET_ACCESS_KEY $AWS_SECRET_KEY
		end
	end

end
