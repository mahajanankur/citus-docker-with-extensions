FROM postgres:12.2
ARG VERSION=9.2.2
LABEL maintainer="Ankur Mahajan" \
    org.label-schema.name="Citus" \
    org.label-schema.description="Scalable PostgreSQL for multi-tenant and real-time workloads" \
    org.label-schema.url="https://www.citusdata.com" \
    org.label-schema.vcs-url="https://github.com/citusdata/citus" \
    org.label-schema.vendor="Citus Data, Inc." \
    org.label-schema.version=${VERSION} \
    org.label-schema.schema-version="1.0"

ENV CITUS_VERSION ${VERSION}.citus-1

# install Citus
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && curl -s https://install.citusdata.com/community/deb.sh | bash \
    && apt-get install -y postgresql-$PG_MAJOR-citus-9.2.=$CITUS_VERSION \
    postgresql-$PG_MAJOR-hll=2.14.citus-1 \
    postgresql-$PG_MAJOR-topn=2.3.0 \
    && apt-get purge -y --auto-remove curl \
    && rm -rf /var/lib/apt/lists/*

# Install Partman
RUN apt-get update \
    && apt-get install --no-install-recommends -yy git make gcc postgresql-server-dev-all \
    && git clone https://github.com/pgpartman/pg_partman /tmp/pg_partman \
    && cd /tmp/pg_partman && make install \
    && cd /tmp && rm -fr pg_partman \
    && apt-get remove --purge -yy git make gcc postgresql-server-dev-all \
    && rm -rf /var/lib/apt/lists/*

# add extensions to default PostgreSQL config
RUN echo "shared_preload_libraries='citus,hll,topn,pg_partman_bgw,pg_stat_statements'" >> /usr/share/postgresql/postgresql.conf.sample

# add scripts to run after initdb
COPY 000-configure-stats.sh 001-create-citus-extension.sql /docker-entrypoint-initdb.d/

# add health check script
COPY pg_healthcheck /

HEALTHCHECK --interval=4s --start-period=6s CMD ./pg_healthcheck
