#!/bin/sh
set -e

echo "=== opencode Zeabur 部署 ==="

if [ -z "$OPENCODE_SERVER_PASSWORD" ]; then
  echo "WARNING: OPENCODE_SERVER_PASSWORD 未设置，服务器将无密码访问！"
fi

# 持久化存储：如果 /data 目录存在（由 Zeabur 持久卷挂载）
# 则将 opencode 的数据和配置重定向到该目录，确保重启后数据不丢失
if [ -d "/data" ]; then
  export XDG_DATA_HOME=/data/share
  export XDG_CONFIG_HOME=/data/config

  mkdir -p /data/share/opencode /data/config/opencode

  # 如果持久卷上没有全局配置文件，复制默认配置
  if [ ! -f /data/config/opencode/opencode.json ]; then
    cp /app/opencode.json /data/config/opencode/opencode.json
    echo "已初始化默认配置文件到持久卷"
  fi
fi

PORT="${PORT:-8080}"

exec opencode web \
  --hostname "0.0.0.0" \
  --port "$PORT"
