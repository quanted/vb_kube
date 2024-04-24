# FROM nginx:stable

FROM nginx:stable-alpine3.17-slim

ARG CONFIG=nginx.conf

RUN apk update && \
	apk upgrade

RUN rm -rf /usr/share/nginx/html/* && \
	rm /etc/nginx/conf.d/default.conf

# RUN rm /etc/nginx/conf.d/default.conf

COPY $CONFIG /etc/nginx/conf.d/

# COPY --from=ghcr.io/usepa/cyanweb-angular:dev-kube /app/dist /usr/share/nginx/html
COPY --from=ghcr.io/quanted/vb-angular:dev /app/dist /usr/share/nginx/html
