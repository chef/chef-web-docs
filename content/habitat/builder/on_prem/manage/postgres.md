+++
title = "Manage Habitat Builder data stored by PostgreSQL"

[menu]
  [menu.habitat]
    title = "PostgreSQL"
    identifier = "habitat/builder/on-prem/manage/PostgreSQL"
    parent = "habitat/builder/on-prem/manage"
    weight = 30
+++

<!--cspell:ignore createdb -->

This page describes how to back up Habitat Builder user and package data that's managed by PostgreSQL.

## Habitat Builder data overview

Habitat Builder's data is lightweight, so backup and disaster recovery strategies are straightforward.
On-Prem Builder has two types of data you should back up in case of a disaster:

- PostgreSQL package and user metadata
- [MinIO Habitat artifacts](../minio#minio-artifact-backups)

Ideally, coordinate the backup of the entire On-Prem Builder cluster at the same time.
However, because Habitat Builder stores only metadata and artifacts, you have some flexibility in the timing of your backup operations.
If a package's metadata is missing from PostgreSQL, you can repopulate it by re-uploading the package with the `--force` flag, for example:

```shell
hab pkg upload <PATH_TO_HART_FILE> -u <ON_PREM_URL> --force
```

## Back up the PostgreSQL database

Backing up Builder's PostgreSQL database is the same as backing up any PostgreSQL database.
The process uses [pg_dump](https://www.postgresql.org/docs/11/app-pgdump.html).
If you already have a backup strategy for other production PostgreSQL instances, apply that pattern to the `builder` database.
To back up your `builder` database manually, follow these steps:

1. Optional but recommended: Shut down the API to make sure there are no active transactions:

   ```shell
   hab svc stop habitat/builder-api
   ```

1. Switch to the `hab` user:

   ```shell
   sudo su - hab
   ```

1. Find your PostgreSQL password:

   ```shell
   sudo cat /hab/svc/builder-api/config/config.toml
   ```

1. Export the password as an environment variable:

   ```shell
   export PGPASSWORD=<PASSWORD>
   ```

1. Create a backup of the database:

   ```shell
   /hab/pkgs/core/postgresql/<VERSION>/<RELEASE>/bin/pg_dump --file=builder.dump --format=custom --host=<IP_OF_PG_HOST> --dbname=builder
   ```

1. Start the API and verify it's running:

   ```shell
   sudo hab svc start habitat/builder-api
   ```

After the backup finishes, you'll find the `builder.dump` file on your filesystem.
Move and store this file according to your organization's policies.
Store the backup in a remote location---either physically or virtually---so you can access it in a disaster scenario.
For example, you can use an AWS bucket or Azure storage.
Use the same backup strategy you use for your other databases.

## Restore the PostgreSQL database

Restoring a `builder` database is the same as restoring any other PostgreSQL database.
If you already have a restoration strategy, use it to restore your `builder` database.
To restore your `builder` database manually, follow these steps:

1. Switch to the `hab` user:

   ```shell
   sudo su - hab
   ```

1. Find your PostgreSQL password:

   ```shell
   sudo cat /hab/svc/builder-api/config/config.toml
   ```

1. Export the password as an environment variable:

   ```shell
   export PGPASSWORD=<PASSWORD>
   ```

1. Create a new database called `builder` (if needed):

   ```shell
   /hab/pkgs/core/postgresql/<VERSION>/<RELEASE>/bin/createdb -w -h <URL_OF_PG_HOST> -p <CONFIGURED_PG_PORT> -U hab builder
   ```

   If your version of PostgreSQL doesn't have the `createdb` binary, connect to the database and run the create database command manually.

1. Verify connectivity to the new database instance:

   ```shell
   /hab/pkgs/core/postgresql/<VERSION>/<RELEASE>/bin/psql --host=<URL_OF_PG_HOST> --dbname=builder
   ```

1. Restore the contents of the `builder.dump` backup file into the `builder` database:

   ```shell
   /hab/pkgs/core/postgresql/<VERSION>/<RELEASE>/bin/pg_restore --host=<URL_OF_PG_HOST> --dbname=builder builder.dump
   ```

1. Start the Habitat On-Prem Builder services.

Your database data should now be restored and ready for use!
