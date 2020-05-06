#!/bin/bash
if [ $# -lt 3 ] 
then
  echo "use \"host user password\" parameters"
else
  key=$(http POST $1:9000/api/auth Username="$2" Password="$3" | jq -r '.jwt')
  for var in $(http GET $1:9000/api/stacks "Authorization: Bearer $key" | jq -c '.[]?')
  do
    name=$(echo $var | jq -r '.Name')
    id=$(echo $var | jq -r '.Id')
    http GET $1:9000/api/stacks/$id/file "Authorization: Bearer $key" | jq -r '.StackFileContent' > $name.yml
  done
fi
