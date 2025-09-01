#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER {{ .Values.ontocloak.deployment.db.user }} WITH ENCRYPTED PASSWORD '{{ .Values.ontocloak.deployment.db.password }}';
    CREATE DATABASE {{ .Values.ontocloak.deployment.db.database }} OWNER {{ .Values.ontocloak.deployment.db.user }};
    \connect {{ .Values.ontocloak.deployment.db.database }};
    CREATE SCHEMA {{ .Values.ontocloak.deployment.db.database }} AUTHORIZATION {{ .Values.ontocloak.deployment.db.user }};
    GRANT ALL PRIVILEGES ON DATABASE {{ .Values.ontocloak.deployment.db.database }} TO {{ .Values.ontocloak.deployment.db.user }};
    ALTER ROLE {{ .Values.ontocloak.deployment.db.user }} SET search_path = {{ .Values.ontocloak.deployment.db.database }};
EOSQL