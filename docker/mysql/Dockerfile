FROM mysql:5.7

RUN apt-get update && \
  apt-get install -y apt-utils \
  locales && \
  rm -rf /var/lib/apt/lists/* && \
  echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
ADD ./docker/mysql/charset.cnf /etc/mysql/conf.d/charset.cnf
