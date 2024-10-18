#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER {{ .Values.atomio.database.username }} WITH ENCRYPTED PASSWORD '{{ .Values.atomio.database.password }}';
    CREATE DATABASE {{ .Values.atomio.database.dbname }} OWNER {{ .Values.atomio.database.username }};
    \connect {{ .Values.atomio.database.dbname }};
    CREATE SCHEMA {{ .Values.atomio.database.dbname }} AUTHORIZATION {{ .Values.atomio.database.username }};
    GRANT ALL PRIVILEGES ON DATABASE {{ .Values.atomio.database.dbname }} TO {{ .Values.atomio.database.username }};
    ALTER ROLE {{ .Values.atomio.database.username }} SET search_path = {{ .Values.atomio.database.dbname }};
EOSQL