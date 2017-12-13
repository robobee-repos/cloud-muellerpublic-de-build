FROM robobeerun/nextcloud:v12.0.4-fpm-r1

LABEL maintainer "Erwin Mueller <erwin.mueller@deventm.com>"

USER root

ADD rootfs/ /

RUN set -x \
  && chmod +x /*.sh \
  && mv /docker-entrypoint.sh /docker-entrypoint-old.sh \
  && mv /docker-entrypoint-in.sh /docker-entrypoint.sh

# Finishing up.

USER www-data

WORKDIR ${WEB_ROOT}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]
