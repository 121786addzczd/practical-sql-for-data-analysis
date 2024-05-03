-- create user
CREATE USER brain PASSWORD 'brain12345';
GRANT ALL ON DATABASE analysis_postgres_db TO brain;
GRANT pg_read_server_files TO brain;
GRANT pg_write_server_files TO brain;
ALTER DATABASE analysis_postgres_db OWNER TO brain;
