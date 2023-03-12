#!/bin/bash
# 获取最新 GitHub Actions 运行链接
LATEST_RUN_URL=$(curl -s https://github.com/Mrs4s/go-cqhttp/actions/ | grep -o -E '/Mrs4s/go-cqhttp/actions/runs/[0-9]+' | head -n 1)
echo $LATEST_RUN_URL
# 根据运行链接获取 Artifacts 下载链接
ARTIFACT_FILTER='/artifacts/[0-9]+'
ARTIFACTS_URLS=$(curl -s "${LATEST_RUN_URL}" | grep -o -E 'https://github.com/Mrs4s/go-cqhttp/suites/[0-9]+/artifacts/[0-9]+' | grep -E "${ARTIFACT_FILTER}")
echo $ARTIFACTS_URLS
# 判断是否获取到了 Artifacts 下载链接
if [ -n "${ARTIFACTS_URLS}" ]; then
  # 如果获取到了下载链接，则遍历链接列表进行下载和解压
  for url in ${ARTIFACTS_URLS}; do
    filename=$(echo "${url}" | awk -F/ '{print $(NF-1)}')
    mkdir -p artifacts # 确保 artifacts 目录存在
    curl -L -o "artifacts/${filename}.zip" "${url}" # 下载 Artifact
    unzip -o "artifacts/${filename}.zip" -d "artifacts/${filename}" # 解压 Artifact
    rm -f "artifacts/${filename}.zip" # 清理 Artifact 压缩包
  done
else
  # 如果没有获取到下载链接，则输出错误信息并退出脚本
  echo "No Artifacts URLs found." >&2
  exit 1
fi