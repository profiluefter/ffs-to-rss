#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: generate-rss.sh <CLIENT_ID>"
  exit 1
fi

CLIENT_ID=$1

ffsclient tabs list \
  --ignore-schema-errors \
  --format json \
  --client "$CLIENT_ID" \
  \
  | yq \
  --output-format=xml \
  --from-file=json-to-rss.yq -
