#!/bin/bash
LATEST_WORKFLOW_URL=$(curl -s "https://github.com/Mrs4s/go-cqhttp/actions/workflows/ci.yml" | grep -oP 'https://github.com/Mrs4s/go-cqhttp/actions/runs/\d+' | head -n 1)
ARTIFACTS_URLS=$(curl -s "${LATEST_WORKFLOW_URL}" | grep -Eo "https://.*?/artifacts/.*?/download" | sed "s/\\\\\//\//g")

if [ -n "${ARTIFACTS_URLS}" ]; then
  for url in ${ARTIFACTS_URLS}; do
    filename=$(echo "${url}" | awk -F/ '{print $(NF-1)}')
    curl -L -o "artifacts/${filename}".zip "${url}"
    unzip -o "artifacts/${filename}".zip
    rm -f "artifacts/${filename}".zip
  done
else
  echo "No Artifacts URLs found." >&2
  exit 1
fi