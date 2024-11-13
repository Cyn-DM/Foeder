#!/bin/bash
/opt/mssql/bin/sqlservr &

until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Test1234* -Q "SELECT 1" > /dev/null 2>&1; do
    echo "Waiting for SQL Server to start..."
    sleep 5
done

echo "Running init-database.sql..."
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Test1234* -d master -i /init-database.sql
echo "Database initialization completed"

# Keep SQL Server running
wait
