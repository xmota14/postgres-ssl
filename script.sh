# create cert and key
mkdir /certs
openssl req -new -x509 -days 365 -nodes -text -out /certs/server.crt -keyout /certs/server.key -subj "/CN=postgres"

# copy pg_hba.conf to sample
cp -f /build/pg_hba.conf /usr/share/postgresql/$PG_MAJOR/pg_hba.conf.sample

# change permissions
chmod 0700              /certs/server.crt /certs/server.key /usr/share/postgresql/$PG_MAJOR/pg_hba.conf.sample
chown postgres:postgres /certs/server.crt /certs/server.key /usr/share/postgresql/$PG_MAJOR/pg_hba.conf.sample

# create ph_hba.conf for ssl only connections
echo "hostssl all all all md5" > "/build/pg_hba.conf"

# add ssl conf to file "postgresql.conf.sample"
echo "
# X14 - BEGIN

ssl = on
ssl_cert_file = '/certs/server.crt'
ssl_key_file = '/certs/server.key'

# for advanced access config please switch hba_file setting
hba_file = '/build/pg_hba.conf'
#hba_file = '/var/lib/postgresql/data/pg_hba.conf'

# X14 - END
" >> /usr/share/postgresql/$PG_MAJOR/postgresql.conf.sample
