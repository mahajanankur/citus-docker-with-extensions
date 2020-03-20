FROM python:3-alpine
LABEL maintainer="Ankur Mahajan" \
      org.label-schema.name="Citus Manager" \
      org.label-schema.description="Citus Manager to manage citus cluster" \
      org.label-schema.url="https://www.citusdata.com" \
      org.label-schema.vcs-url="https://github.com/citusdata/membership-manager" \
      org.label-schema.vendor="Citus Data, Inc." \
      org.label-schema.version=${VERSION} \
      org.label-schema.schema-version="1.0"

RUN apk add --no-cache \
            --virtual psycodeps \
        gcc \
        musl-dev \
        postgresql-dev \
        python3-dev && \
    pip install docker psycopg2 && \
    apk add --no-cache libpq && \
    apk del psycodeps

ADD manager.py /

# the manager creates a file when ready to consume events
HEALTHCHECK --interval=1s --start-period=1s CMD /bin/sh -c 'test -f /manager-ready'

# -u necessary to flush logging to docker in a timely manner
CMD [ "python", "-u", "./manager.py"]
