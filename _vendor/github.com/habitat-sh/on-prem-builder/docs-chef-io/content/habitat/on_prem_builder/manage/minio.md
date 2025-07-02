+++
title = "Manage your MinIO artifact store"

[menu]
  [menu.habitat]
    title = "MinIO"
    identifier = "habitat/on-prem-builder/manage/minio"
    parent = "habitat/on-prem-builder/manage"
    weight = 20
+++

[MinIO](https://min.io/) is an open source object storage server.
Chef Habitat On-Prem Builder uses MinIO to store Habitat artifact (`.hart`) files.

## Habitat Builder data overview

Habitat Builder's data is lightweight, so backup and disaster recovery strategies are straightforward.
Builder has two types of data you should back up in case of a disaster:

- [Habitat package and user metadata stored with PostgreSQL](../postgres#postgresql-data-backups).
- Habitat artifacts (`.hart`) files stored by MinIO.

Chef Habitat On-Prem Builder supports only MinIO artifact repositories.

Ideally you should run the entire On-Prem Builder cluster backup at the same time.
However, because Builder stores only metadata and artifacts, you have some flexibility in the timing of your backup operations.

## Backup Habitat artifacts stored by MinIO

Backing up MinIO data is similar to performing a filesystem backup.
Because MinIO stores files on the filesystem (unless you're using a non-standard configuration), you can use any filesystem backup strategy, such as disk snapshots, data mirroring, or `rsync`.
MinIO also provides the [MinIO client](https://docs.min.io/docs/minio-client-quickstart-guide.html), which offers many features, including the ability to mirror a bucket to another location on the filesystem or to a remote S3 bucket.

Don't directly or manually manipulate files within MinIO's buckets while MinIO could be performing I/O.
Always use the MinIO client to manage MinIO data.

Because backup operations can vary depending on your environment, you may need to adjust these steps.
Use the following backup example as a starting point:

1. Shut down the API to make sure there are no active transactions (optional but recommended):

   ```shell
   hab svc stop habitat/builder-api
   ```

1. Mirror MinIO data to an AWS S3 bucket:

   ```shell
   mc mirror <LOCAL/MINIO/OBJECT/DIR> <AWS_S3_bucket>
   ```

   Or, mirror to a different part of the filesystem, such as an NFS mount, and then take snapshots:

   ```shell
   mc mirror <LOCAL/MINIO/OBJECT/DIR> <NEW/LOCAL/PATH>
   ```
