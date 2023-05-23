function kitty-sshkh --description 'SSH via Kitty without using known_hosts protection'

	command kitty +kitten ssh -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv

end
