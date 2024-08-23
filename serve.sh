#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: serve.sh <FFS_DEVICE_ID> [PORT]"
  exit 1
fi

DEVICE_ID=${1}
PORT=${2:-1234}

echo "Starting server on port ${PORT} for device ${DEVICE_ID}..."

socat -v "TCP-LISTEN:${PORT},crlf,reuseaddr,fork" \
  SYSTEM:"echo HTTP/1.0 200; echo Content-Type\: application/rss+xml; echo; ./generate-rss.sh ${DEVICE_ID}"
