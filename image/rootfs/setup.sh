#!/bin/bash
set -xe

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
  php occ market:install customgroups richdocuments files_texteditor files_pdfviewer gallery
  php occ app:enable encryption
  php occ encryption:enable
}

setup_owncloud
