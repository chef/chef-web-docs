+++
title = "Install the Chef Local License Service"
draft = false
gh_repo = "license-service"

[menu]
  [menu.overview]
    title = "Install"
    identifier = "overview/licensing/local/Install Airgap"
    parent = "overview/licensing/local"
    weight = 20
+++

This document describes how to install the Chef Local License Service in an airgapped environment and load license data on it.

## Prerequisites

Before installing the Chef Local License Service:

- Download the `local-license-service` Habitat package on an internet-connected workstation. Contact [Chef Support](https://community.progress.com/s/products/chef) to get access.

Chef Local License Service requires:

- A machine running Linux with kernel 2.6.32 or later on an x86-64 processor
- On your machine, open port 8000 for inbound traffic.

### Airgapped environment

If you're deploying Local License Service in an **airgapped environment**, download the license data from the Chef licensing server on an internet-connected workstation.

```sh
curl --location 'https://services.chef.io/licensing/download?licenseId=<LICENSE_ID>&version=2' -o <LICENSE_DATA_FILENAME>.json
```

Replace:

- `<LICENSE_ID>` with your license ID. You can get this from [Chef Support](https://community.progress.com/s/products/chef).
- `<LICENSE_DATA_FILENAME>` with a filename to save the data locally.

## Deploy the service

This procedure will start up the Chef Local License Service from a Chef Habitat package on a server in an airgapped environment.

1. Unzip and untar the `chef-private-local-license-service` package.

    ```sh
    tar -xvf chef-private-local-license-service-0.1.0-20230622141749.tar.gz
    ```

1. From the directory where the `hab` directory is present, move the `hab` directory to root.

    ```sh
    sudo mv hab /
    ```

1. Create a shell script that runs this service and paste the following content.

    ```sh
    cat<<EOT > /etc/systemd/system/hab-sup.service
    [Unit]
    Description=Habitat Supervisor
    [Service]
    Environment=HAB_LICENSE=accept-no-persist
    Type=simple
    ExecStart=/usr/bin/hab sup run --strategy none
    KillMode=process
    LimitNOFILE=65535
    [Install]
    WantedBy=default.target
    EOT
    systemctl daemon-reload
    systemctl start hab-sup
    systemctl enable hab-sup 
    # wait for the sup to come up before proceeding.
    until hab svc status > /dev/null 2>&1; do
      sleep 1
    done
    ```

1. Grant permissions to the script.

    ```sh
    chmod u+x FILENAME.sh
    ```

1. Symlink the hab location.

    ```sh
    sudo ln -sf /hab/bin/hab /usr/bin/hab
    ```

1. Execute the shell script.

    ```sh
    sudo ./FILENAME.sh
    ```

1. Verify that the Chef Habitat Supervisor is running.

    ```sh
    systemctl --type=service --state=running | grep hab-sup
    ```

    systemctl returns `hab-sup.service loaded active running Habitat Supervisor`.

1. Create the Habitat user and group.

    ```sh
    sudo groupadd hab
    sudo useradd -g hab hab
    ```

1. Load Local License Service package.

    ```sh
    sudo hab svc load chef-private/local-license-service
    ```

1. Verify the service is running.

    ```sh
    sudo hab svc status
    ```

    This returns a status similar to:

    ```bash
    package                                                  type        desired  state  elapsed (s)  pid   group
    chef-private/local-license-service/0.1.0/20230622141749  standalone  up       up     58           3047  local-license-service.default
    ```

## Load license data

You can load license data depending on whether your service is running in an airgapped environment or a non-airgapped environment.

### Airgapped environment

In an **airgapped environment**, use the `v1/uploadLicense` endpoint to load your licensing data.

```sh
curl --location --request POST 'http://<IP_ADDRESS>:8000/v1/uploadLicense' --header 'Content-Type: application/json' -d @<LICENSE_DATA_FILENAME>.json
```

Replace:

- `<IP_ADDRESS>` with your Local Licensing Service IP address
- `<LICENSE_DATA_FILENAME>` with the path and filename of your license data

### Non-airgapped environment

In a **non-airgapped environment**, use the `v1/loadLicense` endpoint to load your licensing data directly from the Chef's licensing server.

```sh
curl --location 'http://<IP_ADDRESS>:8000>/v1/loadLicense' --header 'Content-Type: application/json' --data '{"LicenseId": "<LICENSE_ID>"}'
```

Replace:

- `<IP_ADDRESS>` with your Local Licensing Service IP address
- `<LICENSE_ID>` with your license ID.

## Verify license data

To verify your licenses have loaded, use the `/v1/listLicenses` endpoint to list license data loaded on Local License Service.

```sh
curl --location --request GET 'http://<IP_ADDRESS>:8000/v1/listLicenses'
```

After you upload the license data, you can set your Local License Service IP address or URL in your Chef applications using the `CHEF_LICENSE_SERVER` environment setting or `--chef-license-server` CLI option.
