FROM mcr.microsoft.com/mssql-tools

WORKDIR /app

COPY init-db-template.sql .
COPY init-db.sh .

RUN chmod +x ./init-db.sh

ENTRYPOINT ["./init-db.sh"]
