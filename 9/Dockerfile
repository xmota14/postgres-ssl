FROM postgres:9

RUN mkdir /build \
#
# create certs
&& mkdir /build/certs \
&& openssl req -new -x509 -days 365 -nodes -text -out /build/certs/server.crt -keyout /build/certs/server.key -subj "/CN=postgres" \
#
# change cert and key permissions
&& chmod 0700              /build/certs/server.crt /build/certs/server.key \
&& chown postgres:postgres /build/certs/server.crt /build/certs/server.key \
#
# create pg_hba.conf for ssl only connections
&& echo "hostssl all all all md5" > "/build/pg_hba.conf" \
#
# add ssl config to postgresql.conf.sample
&& echo "# X14 - BEGIN"                                               >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo ""                                                            >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "ssl = on"                                                    >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "ssl_cert_file = '/build/certs/server.crt'"                   >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "ssl_key_file = '/build/certs/server.key'"                    >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo ""                                                            >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "# for advanced access config please switch hba_file setting" >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "hba_file = '/build/pg_hba.conf'"                             >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "#hba_file = '/var/lib/postgresql/data/pg_hba.conf'"          >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo ""                                                            >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample \
&& echo "# X14 - END"                                                 >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample
