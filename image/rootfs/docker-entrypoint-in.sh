#!/bin/bash
set -e

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
  'dbtype' => 'pgsql',
  'dbname' => '${NEXTCLOUD_DB_DATABASE}',
  'dbhost' => '${NEXTCLOUD_DB_HOST}:${NEXTCLOUD_DB_PORT}',
  'dbtableprefix' => 'oc_',
  'dbuser' => '${NEXTCLOUD_DB_USER}',
  'dbpassword' => '${NEXTCLOUD_DB_PASSWORD}',
  'logtimezone' => 'UTC',
  'installed' => false,
  'redis' => 
  array (
    'host' => 'redis',
    'port' => '6379',
  ),
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
);
EOF
}

source /docker-entrypoint-utils.sh
set_debug
echo "Running as `id`"
create_config
cd "${WEB_ROOT}"
exec ${BASH_CMD} -- /docker-entrypoint-old.sh "$@"
