#!/bin/sh
set -e
echo "=== Starting Taskcafe on PORT=${PORT:-3333} ==="
cat > /root/config.yml << EOF
server:
  rootPath: "/"
  port: ${PORT:-3333}
  secret: "${SECRET_KEY:-changeme}"
database:
  host: "${PGHOST}"
  port: ${PGPORT:-5432}
  name: "${PGDATABASE}"
  user: "${PGUSER}"
  pass: "${PGPASSWORD}"
  sslmode: disable
redis:
  addr: "${REDISHOST}:${REDISPORT:-6379}"
  password: "${REDIS_PASSWORD}"
  db: 0
EOF
exec ./taskcafe web --migrate --config /root/config.yml
