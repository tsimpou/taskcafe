#!/bin/sh
set -e
echo "=== Starting Taskcafe on PORT=${PORT:-3333} ==="
cat > /root/config.yml << EOF
server:
  rootPath: "/"
  port: ${PORT:-3333}
  secret: "${SECRET_KEY:-changeme}"
database:
  host: "${PGHOST:-postgres.railway.internal}"
  port: ${PGPORT:-5432}
  name: "${PGDATABASE:-railway}"
  user: "${PGUSER:-postgres}"
  pass: "${PGPASSWORD}"
  sslmode: disable
redis:
  addr: "${REDISHOST:-redis.railway.internal}:${REDISPORT:-6379}"
  password: "${REDIS_PASSWORD}"
  db: 0
EOF

echo "=== Config Content: ==="
cat /root/config.yml
echo "=== End of Config ==="

exec ./taskcafe web --migrate --config /root/config.yml
