docker run --rm --volumes-from mypostgres -v /volumes/projects/testwebapp1/postgres/backup:/backup ubuntu bash -c "tar cvf /backup/backup.tar /var/lib/postgresql/data"
