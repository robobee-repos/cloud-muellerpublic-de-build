#!/bin/bash
set -e

EXEC_BASH="bash"

if [[ "$DEBUG" == "true" ]]; then
  set -x
  EXEC_BASH="bash -x"
fi

function create_config() {
  if [ -e "${WEB_ROOT}/config/config.php" ]; then
    return
  fi
  if [ ! -d "${WEB_ROOT}/config" ]; then
    mkdir -p "${WEB_ROOT}/config"
  fi
  cd "${WEB_ROOT}/config"
  cat <<EOF > config.php
<?php
\$CONFIG = array (
  'trusted_domains' => 
  array (
    0 => 'cloud.muellerpublic.de',
  ),
  'datadirectory' => '/data/data',
  'overwrite.cli.url' => 'https://cloud.muellerpublic.de',
  'dbtype' => 'mysql',
  'dbname' => '${DB_OWNCLOUD_DB}',
  'dbhost' => 'db:3306',
  'dbtableprefix' => 'oc_',
  'dbuser' => '${DB_OWNCLOUD_USER}',
  'dbpassword' => '${DB_OWNCLOUD_PASSWORD}',
  'logtimezone' => 'UTC',
  'installed' => false,
  'redis' => 
  array (
    'host' => 'redis',
    'port' => '6379',
  ),
  'memcache.local' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
);
EOF
}

create_config

cd "${WEB_ROOT}"
echo "Running as `id`"
exec ${EXEC_BASH} -- /docker-entrypoint-old.sh "$@"
