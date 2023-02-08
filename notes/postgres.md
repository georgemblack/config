# Postgres

Installing `psql` and other associated utilities:

```
brew install libpq
```

(Note that `$PATH` will need to be updated.)

Starting a Postgres container to mess around with:

```
docker run -it -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres
```

Connecting:

```
psql -h localhost -p 5432 -U postgres -W postgres
```

Using `pg_restore` to restore to a specific database:

```
pg_restore -h localhost -p 5432 -U postgres -W -d databasename ~/pg_dump.custom
```
