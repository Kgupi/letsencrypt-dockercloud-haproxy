FROM alpine:edge

RUN apk add --update \
		bash \
		certbot \
		tini \
		curl \
	&& rm -rf /var/cache/apk/*

EXPOSE 80
VOLUME /etc/letsencrypt

ENV VIRTUAL_HOST="*/.well-known/acme-challenge/*"
ENV VIRTUAL_HOST_WEIGHT="999"
ENV PATH="/opt/letsencrypt/bin:$PATH"

COPY . /opt/letsencrypt/
RUN chmod +x /opt/letsencrypt/bin/*.sh \
	&& /usr/bin/crontab /opt/letsencrypt/bin/crontab

ENTRYPOINT ["tini", "--"]
CMD ["entrypoint.sh", "/usr/sbin/crond", "-f", "-l", "0"]
