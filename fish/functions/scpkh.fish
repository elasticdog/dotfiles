function scpkh --description 'secure copy without using known_hosts protection'

	command scp -o LogLevel=ERROR -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $argv

end
