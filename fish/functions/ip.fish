function ip --description 'Query us-west-2 for EC2 instance data'

	if test (count $argv) = 2
		set region $argv[2]
	else
		set region us-west-2
	end

	command aws --region $region ec2 describe-instances --filters "Name=tag:Name, Values=$argv[1]" | jq --raw-output '.[][].Instances[].NetworkInterfaces[].PrivateIpAddress' | sort -n

end
