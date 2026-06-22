#!/bin/sh
set -e
echo "=== Starting Taskcafe on PORT=${PORT:-3333} ==="

# Δημιουργία του TOML με τις πραγματικές τιμές των variables
cat > /root/config.toml << EOF
[server]
rootPath = "/"
port = "${PORT}"
secret = "${SECRET_KEY}"

[database]
host = "${PGHOST}"
port = "${PGPORT}"
name = "${PGDATABASE}"
user = "${PGUSER}"
pass = "${PGPASSWORD}"
sslmode = "disable"

[redis]
addr = "${REDISHOST}:${REDISPORT}"
password = "${REDIS_PASSWORD}"
db = 0
EOF

echo "=== Config Content (TOML): ==="
cat /root/config.toml
echo "=== End of Config ==="

exec ./taskcafe --config /root/config.toml web --migrate
