#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER {{ .Values.ontocloak.database.user }} WITH ENCRYPTED PASSWORD '{{ .Values.ontocloak.database.password }}';
    CREATE DATABASE {{ .Values.ontocloak.database.database }} OWNER {{ .Values.ontocloak.database.user }};
    \connect {{ .Values.ontocloak.database.database }};
    CREATE SCHEMA {{ .Values.ontocloak.database.database }} AUTHORIZATION {{ .Values.ontocloak.database.user }};
    GRANT ALL PRIVILEGES ON DATABASE {{ .Values.ontocloak.database.database }} TO {{ .Values.ontocloak.database.user }};
    ALTER ROLE {{ .Values.ontocloak.database.user }} SET search_path = {{ .Values.ontocloak.database.database }};
EOSQL