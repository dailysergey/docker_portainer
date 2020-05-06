#!/bin/bash
echo "Настройка config-файлов для Docker"
count=0
for file in config/*
do
    filename=$(basename "$file")
    echo "Проверка $file"
    echo "docker config create $filename $file"
    docker config create $filename $file
    count=$((count+1))
done
echo "Проверено $count файлов"
echo "Done"

