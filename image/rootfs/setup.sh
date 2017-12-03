#!/bin/bash
set -e

function setup_owncloud() {
  cd "$WEB_ROOT"
  if [ ! -e 'version.php' ]; then
    return
  fi
  if [ ! -e 'config/config.php' ]; then
    return
  fi
  if ! grep "'installed' => true," "config/config.php"; then
    return
  fi
  php occ app:enable encryption
  php occ encryption:enable
}

source /docker-entrypoint-utils.sh
set_debug
setup_owncloud
