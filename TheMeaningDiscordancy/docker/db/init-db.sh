#!/bin/bash

echo "Waiting for SQL Server to start..."

# Wait until SQL Server is ready
until /opt/mssql-tools/bin/sqlcmd -S db -U sa -P "$SA_PASSWORD" -Q "SELECT 1" &> /dev/null 2>&1
do
  echo "... SQL Server not yet ready..."
  sleep 2
done

echo "Running init-db.sql..."

# Inject env vars and run the SQL
envsubst < /app/init-db-template.sql > /app/init-db-rendered.sql


/opt/mssql-tools/bin/sqlcmd -S db -U sa -P "$SA_PASSWORD" -i /app/init-db-rendered.sql
