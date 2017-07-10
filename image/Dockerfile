FROM erwin82/owncloud:10.0.2-fpm-r4-2
LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

USER root

ADD rootfs/docker-entrypoint.sh /docker-entrypoint-in.sh
ADD rootfs/setup.sh /setup.sh

RUN set -x \
  && chmod +x /setup.sh \
  && chmod +x /docker-entrypoint-in.sh \
  && mv /docker-entrypoint.sh /docker-entrypoint-old.sh \
  && mv /docker-entrypoint-in.sh /docker-entrypoint.sh

# Finishing up.

USER www-data

WORKDIR $WEB_ROOT

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
