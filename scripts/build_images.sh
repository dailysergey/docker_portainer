#!/bin/bash
count=0
for file in bin/*
do
    filename=$(basename "$file")
    echo "Построение $file"
    docker build $file -t image:5000/$filename
    docker push image:5000/$filename
    count=$((count+1))
done
echo "Загружено $count файлов"
echo "Done"

