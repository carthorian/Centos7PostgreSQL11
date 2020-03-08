#!/usr/bin/env bash

sed -i 's/host    replication     all             127.0.0.1/#host    replication     all             127.0.0.1/g' $PGDATA/pg_hba.conf
sed -i 's/host    replication     all             ::1/#host    replication     all             ::1/g' $PGDATA/pg_hba.conf

{
  echo
  echo "host replication all 0.0.0.0/0 md5"
} >> "$PGDATA/pg_hba.conf"

{
  echo
  echo "log_directory = 'pg_log'"
  echo "log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'"
  echo "log_statement = 'all'"
  echo "logging_collector = on"
  echo "log_rotation_age = 3d"
  echo "listen_addresses = '*'"

  echo "#------------------------------------------------"
  echo "# replication parameters"
  echo "#------------------------------------------------"
  echo "#hot_standby = on"
  echo "wal_level = 'hot_standby'"
  echo "max_wal_senders = 8"
  echo "wal_keep_segments = 8"
  echo "archive_mode = on"
  echo "#------------------------------------------------"


} >> "$PGDATA/postgresql.conf"


