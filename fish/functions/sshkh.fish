function sshkh --description 'SSH without using known_hosts protection'

	command ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv

end
