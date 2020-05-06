#!/bin/bash
echo "Загрузка образов для Docker"
count=0
for file in images/*
do
    filename=$(basename "$file")
    echo "Регистрация $filename"
    result=$(docker load -i $file)
	result=$(echo $result | cut -d":" --complement -s -f1)
	echo "Push $result в docker registry:" 
	docker push $result
    count=$((count+1))
done
echo "Загружено $count файлов"
echo "Done"

