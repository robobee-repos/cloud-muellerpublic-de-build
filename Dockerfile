FROM owncloud:10.0.2-fpm
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

RUN set -x \
  && php occ encryption:enable

RUN set -x \
  && php occ app:enable encryption

RUN set -x \
  && php occ market:install gallery

RUN set -x \
  && php occ market:install customgroups
