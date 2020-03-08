#
# Copyright Mehmet Kaplan All Rights Reserved
#
# Centos 7 PostgreSQL 11.7 docker image
# 
# docker build . --tag mehmetkaplaneyesclear/kumocopg11

FROM centos:7

RUN set -eux; \
	groupadd -g 70 postgres ; \
	useradd -u 70 -g postgres -d /var/lib/postgresql postgres ; \
	mkdir -p /var/lib/postgresql/data; \
	chown -R postgres:postgres /var/lib/postgresql

ENV LANG en_US.utf8
ENV LD_LIBRARY_PATH="/usr/local/lib/"
ENV POSTGRES_USER testuser
ENV POSTGRES_PASSWORD testpass
ENV POSTGRES_DB testdb
ENV PGDATA /var/lib/postgresql/data


RUN yum install -y git wget make sudo gcc \
    zlib-devel readline-devel \
    uuid-devel libuuid-devel \
    openssl-devel libicu-devel \
    libxml2-devel libxslt-devel \
    perl-core perl-IPC-Run

RUN echo "postgres        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

RUN set -ex && \
    mkdir /mkaplan && \
    cd /mkaplan && \
    wget https://ftp.postgresql.org/pub/source/v11.7/postgresql-11.7.tar.gz && \
    tar -xzvf postgresql-11.7.tar.gz  && \ 
    cd postgresql-11.7 && \
    ./configure --enable-integer-datetimes --enable-thread-safety \
    --enable-tap-tests --disable-rpath --with-uuid=e2fs --with-gnu-ld \
    --with-pgport=5432 --with-system-tzdata=/usr/share/zoneinfo \
    --prefix=/usr/local --with-includes=/usr/local/include \
    --with-libraries=/usr/local/lib --with-openssl \
    --with-libxml --with-libxslt --with-icu && \
    make world && \
    make install-world && \
    make -C contrib install


RUN set -ex && \
    cd /mkaplan && \
    rm -rf postgresql-11.7

RUN mkdir /docker-entrypoint-initdb.d
COPY docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/

USER postgres
WORKDIR /


COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]


