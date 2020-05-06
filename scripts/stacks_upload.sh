#!/bin/bash
if [ $# -lt 2 ] 
then
  echo "use \"host user password\" parameters"
else
  key=$(http POST 127.0.0.1:9000/api/auth Username="$1" Password="$2" | jq -r '.jwt')
  swarm_id=$(http GET 127.0.0.1:9000/api/endpoints/1/docker/swarm "Authorization: Bearer $key" | jq -c '.ID'
)
  count=0
  files_count=$(ls -1q stacks/ | wc -l)
  echo "Get key: $key"
  for file in stacks/*
  do
	count=$((count+1))
    echo "Started deploying file $count/$files_count"
	dir=$(readlink -f "$file")
	filename=$(basename "$file" .yml)
	echo "Deploying stack: $filename | ($dir)"
    curl -X POST "http://127.0.0.1:9000/api/stacks?method=file&type=1&endpointId=1" -H "Content-Type: multipart/form-data" -H "Accept: application/json" -H "Authorization: Bearer $key" -F "Name=$filename" -F "SwarmID=$swarm_id" -F "file=@$dir"
	echo "Finished"
  done
fi
