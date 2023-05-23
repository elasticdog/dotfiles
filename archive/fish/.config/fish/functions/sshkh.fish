function sshkh --description="SSH without using known_hosts protection" --wraps=ssh

	command ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv

end
