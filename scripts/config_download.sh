#!/bin/bash
for var in $(curl -s --unix-socket /var/run/docker.sock "http:/v1.40/configs" | jq -r -c '.[]?')
do
 name=$(echo $var | jq -r '.Spec.Name')
 echo $var | jq -r '.Spec.Data' | base64 -d > $name
done
