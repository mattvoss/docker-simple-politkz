#!/bin/bash
set -e

MYSQL_HOST=${MYSQL_HOST:-172.17.42.1}
MYSQL_USERNAME=${MYSQL_USERNAME:-votingModel}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-password}
MYSQL_DATABASE=${MYSQL_DATABASE:-votingModel}

PORT=${PORT:-5001}

# configure simple-politkz settings.json
sed 's/{{MYSQL_HOST}}/'${MYSQL_HOST}'/' -i /data/disney-dining-server/config/settings.json
sed 's/{{MYSQL_USERNAME}}/'${MYSQL_USERNAME}'/' -i /data/disney-dining-server/config/settings.json
sed 's/{{MYSQL_PASSWORD}}/'${MYSQL_PASSWORD}'/' -i /data/disney-dining-server/config/settings.json
sed 's/{{MYSQL_DATABASE}}/'${MYSQL_DATABASE}'/' -i /data/disney-dining-server/config/settings.json
sed 's/{{PORT}}/'${PORT}'/' -i /data/disney-dining-server/config/settings.json
touch /data/installed
