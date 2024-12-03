# FROM postgres:16
FROM postgres:17.0-alpine3.20

RUN apk update && \
	apk upgrade --available

RUN apk add --upgrade apk-tools bash su-exec

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN rm /usr/local/bin/gosu
