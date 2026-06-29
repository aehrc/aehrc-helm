#!/bin/bash
set -e

psql \
    -v ON_ERROR_STOP=1 \
    -v ontocloak_db_user="$ONTOCLOAK_DB_USERNAME" \
    -v ontocloak_db_password="$ONTOCLOAK_DB_PASSWORD" \
    -v ontocloak_db_database="$ONTOCLOAK_DB_DATABASE" \
    --username "$POSTGRES_USER" \
    --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER :"ontocloak_db_user" WITH ENCRYPTED PASSWORD :'ontocloak_db_password';
    CREATE DATABASE :"ontocloak_db_database" OWNER :"ontocloak_db_user";
    \connect :"ontocloak_db_database"
    CREATE SCHEMA :"ontocloak_db_database" AUTHORIZATION :"ontocloak_db_user";
    GRANT ALL PRIVILEGES ON DATABASE :"ontocloak_db_database" TO :"ontocloak_db_user";
    ALTER ROLE :"ontocloak_db_user" SET search_path = :"ontocloak_db_database";
EOSQL
