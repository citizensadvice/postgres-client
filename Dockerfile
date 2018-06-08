FROM debian:stretch-slim

ENV PG_MAJOR 9.6
ENV PG_VERSION 9.6.9-2.pgdg90+1

RUN apt-get update && \
		apt-get install -y --no-install-recommends gnupg dirmngr && \
    key='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" && \
    gpg --export "$key" > /etc/apt/trusted.gpg.d/postgres.gpg && \
    rm -rf "$GNUPGHOME" && \
    apt-key list && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main $PG_MAJOR" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y "postgresql-client-$PG_MAJOR=$PG_VERSION" && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
