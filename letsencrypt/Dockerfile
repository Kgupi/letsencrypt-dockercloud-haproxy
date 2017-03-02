FROM alpine:edge

RUN apk add --update \
		bash \
		certbot \
		tini \
		curl \
	&& rm -rf /var/cache/apk/*

EXPOSE 80
VOLUME /etc/letsencrypt
VOLUME /var/opt/letsencrypt

ENV VIRTUAL_HOST="*/.well-known/acme-challenge/*"
ENV VIRTUAL_HOST_WEIGHT="999"
ENV PATH="/opt/letsencrypt/bin:$PATH"
ENV NOTIFICATION_FOLDER="/var/opt/letsencrypt"

COPY . /opt/letsencrypt/
RUN chmod +x /opt/letsencrypt/bin/*.sh \
	&& /usr/bin/crontab /opt/letsencrypt/bin/crontab \
	&& touch ${NOTIFICATION_FOLDER}/ready

ENTRYPOINT ["tini", "--"]
CMD ["entrypoint.sh", "/usr/sbin/crond", "-f", "-l", "0"]
