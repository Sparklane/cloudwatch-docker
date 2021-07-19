FROM alpine:3.14.0
LABEL maintainer="devops@sparklane.fr"

ARG CLOUDWATCH_MONITORING_SCRIPTS_ZIP_URL
RUN apk -Uv add su-exec coreutils perl perl-switch perl-datetime perl-lwp-protocol-https perl-digest-sha1 perl-sys-syslog
RUN wget -O /tmp/aws-scripts-mon.zip $CLOUDWATCH_MONITORING_SCRIPTS_ZIP_URL \
 && mkdir -p /opt \
 && unzip -d /opt /tmp/aws-scripts-mon.zip \
 && chmod +x /opt/aws-scripts-mon/*.pl \
 && rm -rf /var/cache/apk/* /tmp/*

COPY run.sh /
ENTRYPOINT [ "sh", "/run.sh" ]
