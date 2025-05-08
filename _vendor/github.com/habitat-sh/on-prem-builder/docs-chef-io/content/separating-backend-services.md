+++
title = "Separating backend services (minio/postgresql)"

[menu]
  [menu.habitat]
    title = "Separating backend services"
    identifier = "habitat/builder/on-prem/Separating backend services"
    parent = "habitat/builder/on-prem"
    weight = 20
+++

The on-prem-builder `install.sh` script now supports separation of the backend components i.e datastore and MinIO server onto different nodes.
You can now have a setup where the postgresql service runs on one node and MinIO runs on another. Both can be configured to communicate with other nodes running the frontend services.

## Prerequisites

The `bldr.env` file contains all of the information required to setup MinIO and postgresql and will be used during the installation process.

If your node has already had an older instance of on-prem Builder components on it, run the following to clean up your environment.

```bash
./uninstall.sh
```

Modify the `bldr.env.sample` file and save it to `bldr.env`.

```bash
cp bldr.env.sample bldr.env
```

For the setting up the MinIO server on a separate node, make sure that `S3_ENABLED` and `ARTIFACTORY_ENABLED` in the bldr.env are set to `false`.
This must be ensured as MinIO server can not be used if you are using S3 or Artifactory directly.

For the setting up the datastore on a separate node, make sure that `PG_EXT_ENABLED` in the bldr.env is set to `false`.
This must be ensured as the Datastore node cannot have externally hosted PostgreSQL(RDS, Azure Database for PostgreSql etc).

Please refer our [scaling documentation](./scaling.md#deploying-new-front-ends) for detailed information regarding opening the ports.

Additionally, you will need to edit (or create if it is not already present) `HAB_BLDR_PEER_ARG` to include all frontend and backend nodes hosting builder services. The format is as follows:

```shell
--peer host1 --peer host2 --peer host3
```

## Separating MinIO Server

MinIO is an open source object storage server. Chef Habitat Builder on-prem uses MinIO to store Habitat artifacts (.harts).

### Install MinIO

Run the MinIO install script from the new node that will run the MinIO service to store all the artifacts

```bash
./install.sh --install-minio
```

### Connecting to MinIO server node

Now that your MinIO server is up and running on its own node, it is crucial to know how to connect your frontend nodes to it.
The `MINIO_ENDPOINT` in the `bldr.env` file has to be mapped to the Node where the MinIO server is running.
You can then access the MinIO UI using the `MINIO_ENDPOINT` URL.

## Separate postgresql

The backend datastore can also be setup to run on a separate node.

### Install postgresql

Run the postgresql install script from the the node

```bash
./install.sh --install-postgresql
```

### Connect to Datastore node

The value of `POSTGRES_HOST` in the `bldr.env` file on the frontend nodes must be mapped to the Node where the Datastore service is running in order to connect to it.

#### NOTE: Please refer this [document](./scaling.md) for setting up and scaling the frontend
