function tunnel --description 'Establish an sshuttle tunnel for all traffic'

	if set -q $argv
		echo 'Usage: tunnel <remote>'
		echo 'Establish an sshuttle tunnel through the <remote> host for all traffic'
	else
		sshuttle --dns --daemon --pidfile=/tmp/sshuttle.pid --remote="$argv[1]" 0/0
	end

end
