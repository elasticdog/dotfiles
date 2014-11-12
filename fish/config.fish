# set up amazon web services credentials
set -x AWS_CONFIG_FILE $HOME/.aws/config
if test -f $AWS_CONFIG_FILE
	set -x AWS_ACCESS_KEY (awk -F= '/^aws_access_key_id/{ print $2 }' $AWS_CONFIG_FILE)
	set -x AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY
	set -x AWS_SECRET_KEY (awk -F= '/^aws_secret_access_key/{ print $2 }' $AWS_CONFIG_FILE)
	set -x AWS_SECRET_ACCESS_KEY $AWS_SECRET_KEY
end

# disable the shell greeting message
set -e fish_greeting

set -x GOPATH $HOME/src/go
set -x GOROOT /usr/local/go
set -x PATH $HOME/bin $PATH
