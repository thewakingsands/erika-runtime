FROM thecodingmachine/php:8.1-v4-apache
COPY SeasClick /usr/local/src/SeasClick
USER root
RUN apt-get update && \
  apt-get install -y php8.1-dev && \
  cd /usr/local/src/SeasClick && \
  chown docker:docker . -R && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  echo "extension=SeasClick.so" > /etc/php/8.1/mods-available/seasclick.ini && \
  touch /var/lib/php/modules/8.1/registry/seasclick && \ 
  apt-get remove -y php8.1-dev && \
  apt-get auto-remove -y && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*
USER docker
