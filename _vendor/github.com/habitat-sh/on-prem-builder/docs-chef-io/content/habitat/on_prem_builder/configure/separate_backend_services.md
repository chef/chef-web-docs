+++
title = "Separate Habitat Builder's backend services onto separate nodes"

[menu]
  [menu.habitat]
    title = "Separate backend services"
    identifier = "habitat/on-prem-builder/configure/Separating backend services"
    parent = "habitat/on-prem-builder/configure"
    weight = 60
+++

Chef Habitat On-Prem Builder uses MinIO to store Habitat artifact (`.hart`) files and PostgreSQL to store package and user metadata.

You can configure Habitat Builder to run the backend components---MinIO and PostgreSQL---on separate nodes.

## Configure node ports

Because Habitat Builder services need to communicate across your network between the frontend and backend nodes, you need to open the following ports to these nodes to ensure your on-prem Habitat Builder works correctly:

- TCP 9638 - Habitat configuration gossip
- UDP 9638 - Habitat configuration gossip
- TCP 9636 - Builder API HTTP
- TCP 5432 - PostgreSQL
- TCP 9000 - MinIO
- TCP 11211 - Memcached

## Deploy MinIO on a separate node

Habitat Builder is configured using the `bldr.env` file, which contains all the information you need to set up MinIO and PostgreSQL. Follow these steps to configure the `bldr.env` file:

1. If you don't already have it on your node, clone the [habitat-sh/on-prem-builder repository](https://github.com/habitat-sh/on-prem-builder/) or download and extract one of the [on-prem-builder releases](https://github.com/habitat-sh/on-prem-builder/releases).

1. If your node previously ran on-prem Habitat Builder components, run the [`uninstall.sh` script](https://github.com/habitat-sh/on-prem-builder/blob/main/uninstall.sh) to clean up your environment:

   ```bash
   ./uninstall.sh
   ```

1. Copy the [`bldr.env.sample` file](https://github.com/habitat-sh/on-prem-builder/blob/main/bldr.env.sample) and save it as `bldr.env`:

   ```bash
   cp bldr.env.sample bldr.env
   ```

1. Edit the `bldr.env` file with these settings:

   1. Set `S3_ENABLED` and `ARTIFACTORY_ENABLED` to `false`.

      You can't use the MinIO server if you're using S3 or Artifactory directly.

   1. List all frontend and backend nodes running Habitat Builder services using `HAB_BLDR_PEER_ARG` and the `--peer` option using the following format:

      ```shell
      HAB_BLDR_PEER_ARG="--peer <HOST> --peer <HOST> --peer <HOST>"
      ```

      Replace `<HOST>` with a node IP address or hostname.

1. Install MinIO by running the install script:

   ```bash
   ./install.sh --install-minio
   ```

1. Now that your Minio server is up and running on its own node, connect your frontend Habitat Builder nodes to the MinIO node.

   On your frontend nodes, set the `MINIO_ENDPOINT` in the `bldr.env` file to the node where the MinIO server is running.

## Deploy PostgreSQL on a separate node

Habitat Builder is configured using the `bldr.env` file, which contains all the information you need to set up MinIO and PostgreSQL. Follow these steps to configure the `bldr.env` file:

1. If you don't already have it on your node, clone the [habitat-sh/on-prem-builder repository](https://github.com/habitat-sh/on-prem-builder/) or download and extract one of the [on-prem-builder releases](https://github.com/habitat-sh/on-prem-builder/releases).

1. If your node previously ran on-prem Habitat Builder components, run the [`uninstall.sh` script](https://github.com/habitat-sh/on-prem-builder/blob/main/uninstall.sh) to clean up your environment:

   ```bash
   ./uninstall.sh
   ```

1. Copy the [`bldr.env.sample` file](https://github.com/habitat-sh/on-prem-builder/blob/main/bldr.env.sample) and save it as `bldr.env`:

   ```bash
   cp bldr.env.sample bldr.env
   ```

1. Edit the `bldr.env` file with these settings:

   1. Set `PG_EXT_ENABLED` to `false`.

      The datastore node can't use an externally hosted PostgreSQL, such as AWS RDS or Azure Database for PostgreSQL.
      For details about opening the required ports, see the [scaling documentation](./scaling.md#deploying-new-front-ends).

   1. List all frontend and backend nodes hosting builder services using `HAB_BLDR_PEER_ARG` and the `--peer` option using the following format:

      ```shell
      HAB_BLDR_PEER_ARG="--peer <HOST> --peer <HOST> --peer <HOST>"
      ```

      Replace `<HOST>` with a node IP address or hostname.

1. Install PostgreSQL by running the install script:

   ```bash
   ./install.sh --install-postgresql
   ```

1. Connect the frontend Builder nodes to the PostgreSQL datastore node.

   On your frontend Builder nodes, set `POSTGRES_HOST` in the `bldr.env` file to the node that's running the Habitat Builder PostgreSQL datastore.

## More information

For details about setting up and scaling the frontend, see [scaling Habitat Builder's frontend documentation](/habitat/on_prem_builder/configure/scale_frontend_nodes/).

For information about managing resources with MinIO and PostgreSQL:

- [Manage your MinIO artifact store](../manage/minio)
- [Manage Habitat Builder data stored with PostgreSQL](../manage/postgres)
