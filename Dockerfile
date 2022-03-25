FROM freeradius/freeradius-server:3.0.25-alpine

LABEL maintainer="eric.attou@wacren.net"

ARG RADIUSD_OPTIONS=sfxxl
ARG RADIUSD_LOGFILE=stdout
ENV RADIUSD_OPTIONS ${RADIUSD_OPTIONS}
ENV RADIUSD_LOGFILE ${RADIUSD_LOGFILE}
ENV DB_DIALECT=postgresql
ENV DB_HOST=localhost
ENV DB_PORT=5436
ENV DB_NAME=radius
ENV DB_USER=radius
ENV DB_PASS=pass
ENV IDP_REALM=uac.bj


#WORKDIR /radius
RUN apk update
RUN apk add --upgrade freeradius-${DB_DIALECT}
COPY radius/sql /opt/etc/raddb/mods-available/sql
COPY radius/sql /opt/etc/raddb/mods-enabled/sql
COPY radius/eap.conf /opt/etc/raddb/eap.conf
COPY radius/sites-available-default /opt/etc/raddb/sites-available/default
RUN sed -i -e 's/IDP_REALM/$IDP_REALM/'  /opt/etc/raddb/sites-available/default
RUN ln -s /opt/etc/raddb/sites-available/default /opt/etc/raddb/sites-enabled/default
COPY radius/eduroam-inner-tunnel /opt/etc/raddb/sites-enabled/eduroam-inner-tunnel
#RUN ln -s /opt/etc/raddb/mods-available/sql /opt/etc/raddb/mods-enabled/sql
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
EXPOSE 1812/udp 1813/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["radiusd", "-${RADIUSD_OPTIONS}", "${RADIUSD_LOGFILE}"]
##CMD radiusd -${RADIUSD_OPTIONS} -l ${RADIUSD_LOGFILE}
#CMD ["/docker-entrypoint.sh"]
#CMD ["radiusd", "-sfl","stdout"]