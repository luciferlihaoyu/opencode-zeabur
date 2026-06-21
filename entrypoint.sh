#!/bin/sh
set -e

echo "=== opencode Zeabur 部署 ==="

if [ -z "$OPENCODE_SERVER_PASSWORD" ]; then
  echo "WARNING: OPENCODE_SERVER_PASSWORD 未设置，服务器将无密码访问！"
fi

PORT="${PORT:-8080}"

exec opencode web \
  --hostname "0.0.0.0" \
  --port "$PORT"
