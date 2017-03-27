# Dockerfile
FROM postgres:latest
RUN mkdir -p /tmp/data/
ADD ./scripts/createperson.sql /docker-entrypoint-initdb.d/createperson.sql
