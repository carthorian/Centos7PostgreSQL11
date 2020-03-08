#!/usr/bin/env bash

#sed -i 's/host    replication     all             127.0.0.1/#host    replication     all             127.0.0.1/g' $PGDATA/pg_hba.conf
#sed -i 's/host    replication     all             ::1/#host    replication     all             ::1/g' $PGDATA/pg_hba.conf

#{
#  echo
#  echo "host replication all 0.0.0.0/0 md5"
#} >> "$PGDATA/pg_hba.conf"

{
  echo

  echo "#------------------------------------------------"
  echo "# replication slave parameters"
  echo "#------------------------------------------------"
  echo "hot_standby = on"
  echo "#------------------------------------------------"


} >> "$PGDATA/postgresql.conf"


{
  echo "standby_mode = 'on'"
  echo "primary_conninfo = 'host=$PG_MASTER_HOST port=${PG_MASTER_PORT:-5432} user=$PG_REP_USER password=$PG_REP_PASS'"
  echo "trigger_file = '/tmp/pgsql.trigger'"
} >> "$PGDATA/recovery.conf"

