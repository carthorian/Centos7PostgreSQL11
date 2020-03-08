# Centos7PostgreSQL11
# Centos7 based PostgreSQL 11.7 docker image files


Sample Usage:
docker create network postgresql11

docker run -dt --name pgmaster1 -e POSTGRES_DB_TYPE=master --network postgresql11 mehmetkaplaneyesclear/kumocopg11

docker run -dt --name pgslave1 -e POSTGRES_DB_TYPE=slave -e PG_MASTER_HOST=pgmaster1 -e PG_MASTER_PORT=5432 -e PG_REP_USER=mkreplication -e PG_REP_PASS=mkreplication --network postgresql11 mehmetkaplaneyesclear/kumocopg11
