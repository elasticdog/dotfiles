function tunnelx --description 'Tear down the existing sshuttle tunnel'

	if test -f /tmp/sshuttle.pid
		pkill -F /tmp/sshuttle.pid; and echo "disconnected"
	end

end
