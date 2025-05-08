+++
title = "Migrate to a Deployment of Chef Automate with Chef Habitat Builder on-prem"

[menu]
  [menu.habitat]
    title = "Chef Automate"
    identifier = "habitat/builder/on-prem/migrate"
    parent = "habitat/builder/on-prem"
    weight = 20
+++

Long-term support for on-prem Builder is provided for installations of [Builder with Chef Automate](https://docs.chef.io/automate/on_prem_builder/).
This document guides you through the steps necessary to migrate your on-prem Builder data into an Automate Builder.

The data that Builder stores is fairly lightweight and thus the migration strategy is pretty straightforward. On-prem Builder has two types of data that will need to be migrated:

- MinIO/S3 Habitat artifacts
- PostgreSQL package and user metadata

The minio/S3 data will be copied to the Automate Builder target via MinIO mirroring utility.

The migration of the PostgreSQL data will be done via a `pg_dump` on the source and then restoring with `psql` on the target.

## Prerequisites

Read the following prerequisite items carefully and ensure that each is addressed.

1. The migration will overwrite any existing data in Automate Builder (target) with the data from your current On-Prem (source) installation. The assumption is that the Automate Builder target node is not yet in use.

1. Configure Chef Automate as an [OAuth Provider for Habitat Builder](https://automate.chef.io/docs/applications-setup/#authenticating-existing-chef-automate-and-builder-installations). Following the PostgreSQL data migration, you will need to create local accounts in Chef Automate that match the userids from your source Builder instance.

1. Since the data migration is destructive and will overwrite any previous Builder data on the target, perform a backup in case the original state needs to be restored:

   ```shell
   sudo chef-automate backup create
   ```

1. It is the Builder API that runs database migrations and is responsible for making schema changes, ensuring that the PostgreSQL tables are all up to date.
Check that your target Automate Builder instance is running the same or newer Builder API version than your current on-prem Builder (source). This is required to ensure that there are no PostgreSQL schema incompatibilities. The Builder API service on the target Automate Builder node will run any migrations necessary to update the PostgreSQL data and schemas to the correct format. Therefore the Automate Builder target must be the same or newer version.

   To check the API version installed on the source and target Builder nodes run:

   ```shell
   sudo hab svc status | grep habitat/builder-api/
   ```

   The versions on the target must be equal or newer to the source version.

   If it is not, perform an upgrade for target as follows:

   * Automate Builder [upgrades](https://automate.chef.io/docs/install/#upgrades).

1. Additionally, ensure that the source Builder API version is not older than the following *minimum* required version: `builder-api/7987/20181203194923`

   To check the API version installed on the source Builder node run:

   ```shell
   sudo hab svc status | grep habitat/builder-api/
   ```

   The version of the source Builder API must be >= `builder-api/7987/20181203194923`.

   If it is not, work with Chef Support to determine your exact configuration and to create an upgrade plan based on the following scenarios:

   * [Merging Database Shards](https://github.com/habitat-sh/on-prem-builder/blob/master/on-prem-docs/postgres.md#merging-postgresql-database-shards)
   * [Merging Databases](https://github.com/habitat-sh/on-prem-builder/blob/master/on-prem-docs/postgres.md#merging-postgresql-databases)

## MinIO Habitat artifact (.hart) Migration

Whether your source package files are in MinIO or in S3, you can leverage the [minio client](https://docs.min.io/docs/minio-client-quickstart-guide.html) to perform what more or less amounts to a filesystem backup that you will then restore into the target MinIO. You are going to create a copy of the MinIO data on another filesystem or directory that can either be copied to or mounted on the target Automate Builder node.

## Creating a MinIO Backup Copy

A simple backup process of the source Builder MinIO data might look like the steps below.

1. Shut down the API to ensure no active transactions are occurring. (Optional but preferred)

   ```shell
   hab svc stop habitat/builder-api`
   ```

1. Mirror the MinIO data to a different directory that has adequate space

   ```shell
   sudo mkdir /opt/data/minio_backup
   sudo ./mc mirror /hab/svc/builder-minio/data/habitat-builder-artifact-store.local /opt/data/minio_backup
   sudo tar cvf /opt/data/minio_backup.tar /opt/data/minio_backup
   ```

1. Start the API service back up if it was stopped

   ```shell
   sudo hab svc start habitat/builder-api`
   ```

## Importing the MinIO Backup Copy

Use the following steps in order to sync the MinIO package data into the target Automate Builder. This will overwrite any existing data that is in the Automate Builder MinIO depot. Create a backup first `sudo chef-automate backup create` if one does not already exist.

1. Copy the MinIO directory backup to the target Automate Builder node and expand the .tar

   ```shell
   tar xvf minio_backup.tar
   ```

1. Once the data is expanded into a directory on the target Automate Builder node use MinIO client to mirror it into the MinIO service directory

   ```shell
   sudo ./mc mirror minio_backup/ /hab/svc/automate-minio/data/depot
   ```

1. Fix the MinIO data directory ownership

   ```shell
   sudo chown -R hab:hab /hab/svc/automate-minio/data/depot
   ```

The artifact data should now be available for use!

As mentioned before, since the MinIO backup/import operation could be dramatically different for different environments, the MinIO backup steps cannot be 100% prescriptive. This should give you some ideas to explore though.

## PostgreSQL Data Copy

Create a copy of the source Builder's PostgreSQL database by following these steps:

1. Shut down the API to ensure no active transactions are occurring. (Optional but preferred)

    ```shell
    sudo hab svc stop habitat/builder-api
    ```

1. Export the hab user's PostgreSQL password

    ```shell
    export PGPASSWORD=$(sudo cat /hab/svc/builder-datastore/config/pwfile)
    ```

1. Run the `pg_dump` command to create a data backup/copy

    ```shell
    hab pkg exec core/postgresql pg_dump --user=hab --host=127.0.0.1 --dbname=builder --clean --encoding=utf8 --if-exists | gzip > pgdump.gz
    ```

1. Start the API service and verify

    ```shell
    sudo hab svc start habitat/builder-api
    sudo hab svc status
    ```

1. Copy the `pgdump.gz` file to the target in preparation for an import of the data on that node

## Import the PostgreSQL Data into the Target Automate Builder

Next, import the PostgreSQL data from the `pgdump.gz` into the target Automate Builder.
Keep in mind that this will overwrite any existing data so ensure you have first created a backup via `sudo chef-automate backup create`.

Follow these steps on the target Automate Builder node:

1. Temporarily prevent the auto converge loop from restarting services

   ```shell
   sudo chef-automate dev stop-converge
   ```

1. Stop the Builder API

   ```shell
   sudo hab stop chef/automate-builder-api
   ```

1. Kill off any lingering processes still connected to PostgreSQL

   ```shell
   sudo pkill -9 -f "postgres: automate-builder-api"
   ```

1. Rename the old database - you can drop it later if desired.

   ```shell
   sudo hab pkg exec chef/automate-platform-tools pg-helper rename-if-exists automate-builder-api automate-builder-api.orig -c /hab/svc/automate-gateway/config/service.crt -k /hab/svc/automate-gateway/config/service.key -r /hab/svc/automate-gateway/config/root_ca.crt
   ```

1. Create an empty database

   ```shell
   sudo hab pkg exec chef/automate-platform-tools pg-helper ensure-service-database automate-builder-api automate-builder-api -c /hab/svc/automate-gateway/config/service.crt -k /hab/svc/automate-gateway/config/service.key -r /hab/svc/automate-gateway/config/root_ca.crt
   ```

1. Import the data captured from the source Builder into the target Builder. There should not be any errors from this command.

   ```shell
   gunzip -c pgdump.gz | sed -e "s/OWNER TO hab/OWNER TO \"automate-builder-api\"/" | sudo chef-automate dev psql automate-builder-api
   ```

1. If all went well and there were no errors, restart the converge loop to re-enable all the services:

   ```shell
   sudo chef-automate dev start-converge
   ```

Your database data should be restored and ready for use!

## Chef Automate Builder Authentication

Log into the web UI and verify all your origin, package and user metadata exists.

If, for some reason, you are unable to log into the UI, you can reset the admin password:

   ```shell
   sudo chef-automate iam admin-access restore <new_password>
   ```

You should then be able to log into the UI with the `admin` user and the password set above.

The next step is to create local users in Chef Automate with matching usernames as the ones from the source Builder.

1. View the usernames from the PostgreSQL accounts table

      ```shell
      sudo chef-automate dev psql automate-builder-api
      automate-builder-api=# \d accounts;
                  Table "public.accounts"
      Column   |           Type           | Collation | Nullable |                 Default
      ------------+--------------------------+-----------+----------+-----------------------------------------
      id         | bigint                   |           | not null | next_id_v1('accounts_id_seq'::regclass)
      name       | text                     |           |          |
      email      | text                     |           |          |
      created_at | timestamp with time zone |           |          | now()
      updated_at | timestamp with time zone |           |          | now()
      Indexes:
         "accounts_pkey" PRIMARY KEY, btree (id)
         "accounts_name_key" UNIQUE CONSTRAINT, btree (name)

      automate-builder-api=# select name from accounts;
      name
      -------
      admin
      jm
      (2 rows)

      automate-builder-api=# \q
      ```

1. For _each_ of the names returned from the SELECT query above, you will need to create a matching username locally. Navigate in Chef Automate UI->Settings->Users->Create User.

Once you have created matching usernames in Chef Automate, the Builder users should be able to authenticate as before with respect to the passwords that were set in Chef Automate.
User's `$HAB_AUTH_TOKEN`s will remain the same as those from the source Builder.

## Migration Validation

A package download operation is an easy way to validate PostgreSQL and MinIO data are valid

Download a package from the target Automate Builder

   ```shell
   hab pkg download core/acl --url https://localhost/bldr/v1 --download-directory downloads
   ```

## Troubleshooting

If you need to go into the database on the target Automate Builder node for any reason, such as perhaps to interrogate some account tables you can use the following command which will drop you into a sql shell

   ```shell
   sudo chef-automate dev psql automate-builder-api
   ```

If you need to restore a fallback backup that you made prior to a migration you can run a restore

   ```shell
   sudo chef-automate backup list
   sudo chef-automate backup restore <id>
   ```
