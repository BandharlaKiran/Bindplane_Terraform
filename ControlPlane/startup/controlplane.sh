#!/bin/bash
set -e

LOG=/var/log/startup.log
echo "===== Bindplane Control Plane Startup =====" | tee -a $LOG

apt-get update -y
apt-get install -y postgresql postgresql-contrib curl jq

systemctl enable postgresql
systemctl start postgresql

sudo -u postgres psql <<EOF
CREATE USER bindplane WITH PASSWORD 'bindplane';
CREATE DATABASE bindplane OWNER bindplane;
EOF

curl -fsSL https://storage.googleapis.com/bindplane-op-releases/bindplane/latest/install-linux.sh -o install-linux.sh 
bash install-linux.sh --version 1.96.7

bindplane init \
  --accept-eula \
  --mode=server \
  --database-url "postgres://bindplane:bindplane@localhost:5432/bindplane?sslmode=disable" \
  --listen-addr "0.0.0.0:3001" \
  --opamp-addr "0.0.0.0:4320" \
  --auth-mode single-user \
  --username admin \
  --password admin123

systemctl enable bindplane
systemctl start bindplane
