+++
title = "Scale frontend Habitat Builder nodes"

[menu]
  [menu.habitat]
    title = "Scale Builder frontend"
    identifier = "habitat/builder/on-prem/configure/frontend scaling"
    parent = "habitat/builder/on-prem/configure"
    weight = 50
+++

With any tiered or high-availability deployment of Habitat Builder services, you'll likely want to scale your frontend nodes horizontally.
The most common deployment pattern for this use case is a pool of frontend nodes behind a load balancer.

## System recommendations for multiple frontend nodes

The hardware requirement for an API node is low.
However, your node count and usage statistics might change this recommendation.
For example, Chef's Habitat Builder SaaS uses compute-optimized machines with 36 vCPUs and 60 GB of RAM.
This setup supports a live SaaS service with thousands of supervisors checking in at any time.
Disk space doesn't matter on a new API node because the API shouldn't put disk resources into contention, except possibly for logging.

These are only recommendations, and we can't guarantee performance at these scales.
You should run these nodes in a pool behind a load balancer.

For a small deployment (tens of nodes):

- CPU: 2 vCPUs
- RAM: 4 GB
- Disk: 20 GB

For a mid-sized deployment (hundreds of nodes):

- CPU: 8 vCPUs
- RAM: 16 GB
- Disk: 20 GB

For a large deployment (thousands of nodes):

- CPU: 16 or more vCPUs
- RAM: 32 GB or more
- Disk: 20 GB

## Configure node ports

The Habitat On-Prem Builder `install.sh` script supports scaling frontend nodes as a deployment pattern.
You must deploy new frontend nodes on separate compute resources from your initial on-prem deployment.
Because Habitat Builder services need to communicate across your network between the frontend and backend nodes, you need to open the following ports to these nodes to ensure your Habitat On-Prem Builder works correctly:

- TCP 9638 - Habitat configuration gossip
- UDP 9638 - Habitat configuration gossip
- TCP 9636 - Builder API HTTP
- TCP 5432 - PostgreSQL
- TCP 9000 - MinIO
- TCP 11211 - Memcached

## Create a Builder config file

The `bldr.env` file for your single On-Prem Builder node contains most of the information you need to bootstrap a new frontend and is used to configure Builder durin installation.

1. On each node that you plan run as a frontend node, clone the [habitat-sh/on-prem-builder repository](https://github.com/habitat-sh/) or download and extract an [on-prem-builder release](https://github.com/habitat-sh/on-prem-builder/releases).

1. Create the `bldr.env` file by duplicating the sample file in the on-prem-builder repository:

    ```sh
    cp bldr.env.sample bldr.env
    ```

1. On the `bldr.env` file update the following settings:

   - Update the values of `OAUTH_REDIRECT_URL`, `OAUTH_CLIENT_ID`, and `OAUTH_CLIENT_SECRET` to match your on-premises OAuth2 provider.

   - If your Habitat On-Prem Builder cluster uses cloud services and you run multiple frontend instances, set `OAUTH_REDIRECT_URL` to your load balancer.

   - If you don't use cloud services, update the values of `POSTGRES_HOST` and `MINIO_ENDPOINT`.

   - Add all frontend and backend nodes hosting builder services to `HAB_BLDR_PEER_ARG` in the following format:

      ```shell
      HAB_BLDR_PEER_ARG="--peer <HOST> --peer <HOST> --peer <HOST>"
      ```

      Replace `<HOST>` with a node IP address or hostname.

### Install a frontend node

Install the Habitat Builder frontend services, by running the frontend install script on each new node:

```shell
./install.sh --install-frontend
```
