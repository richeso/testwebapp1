 docker run --rm --volumes-from mypostgres -v /volumes/projects/testwebapp1/postgres/backup:/backup ubuntu bash -c "cd /var/lib/postgresql/data && tar xvf /backup/backup.tar --strip 1"
