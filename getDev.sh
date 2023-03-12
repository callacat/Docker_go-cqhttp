#!/bin/bash

# 从文件中读取链接到数组
mapfile -t links < devUrl.txt

# 循环下载所有链接中的文件
for link in "${links[@]}"; do
    name=$(basename "$link")
    curl \
        -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
        -H "Accept: application/vnd.github.v3+json" \
        -L "$link" \
        -o "download/$name.zip"
done

# 输出 download 目录下的所有文件
ls -l download/