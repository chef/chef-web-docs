+++
title = "Install Chef Infra Client using the migration tool in an air-gapped environment"
draft = true

[menu.install]
title = "Air-gapped install"
identifier = "install/migration_tool/install_airgap"
parent = "install/migration_tool"
weight = 20
+++

This page documents how to do a fresh install of Chef Infra Client RC3 in an air-gapped environment.

## Supported platforms

Chef Infra Client is supported on Linux x86-64 systems.

## Prerequisites

- a valid Chef License key

## Install Chef Infra Client

To install Chef Infra Client, follow these steps:

1. On an internet-connected machine, get the Chef Infra Client tar package download URL:

    ```sh
    curl "https://chefdownload-commercial.chef.io/stable/chef-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the Chef Infra Client version number (for example, 19.1.152)
    - `<LICENSE_ID>` with your Progress Chef License ID

    The response returns download URLs for different platforms and package types. Use the URL from the `linux.<ARCHITECTURE>.tar.url` field in the JSON response (for example, `linux.x86_64.tar.url` if the architecture is x86-64).

1. Download the Chef Infra Client package using curl or Wget:

    {{< accordion-list id="download-chef-infra-client-curl-wget" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download Infra Client with curl" accordion-title-link="download-chef-infra-client-curl" >}}

    Download the tar file using curl:

    ```sh
    curl -o chef-ice-<VERSION>-linux.tar.gz "<CHEF_TAR_URL>"
    ```

    Replace:

    - `<CHEF_TAR_URL>` with the URL from the `linux.<ARCHITECTURE>.tar.url` field
    - `<VERSION>` with the Chef Infra Client version number

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download Infra Client with Wget" accordion-title-link="download-chef-infra-client-wget" >}}

    Download using Wget:

    ```sh
    wget -O "chef-ice-<VERSION>-linux.tar.gz" "<CHEF_TAR_URL>"
    ```

    Replace:

    - `<CHEF_TAR_URL>` with the URL from the `linux.<ARCHITECTURE>.tar.url` field
    - `<VERSION>` with the Chef Infra Client version number

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. On an internet-connected machine, get the latest version of the Chef Infra Client migration tool (migrate-ice).

    ```sh
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version number.

1. Download the migration tool:

    {{< accordion-list id="my-accordion" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download migration tool with curl" accordion-title-link="download-migration-tool-curl" >}}

    Using curl:

    ```sh
    curl -o migration-tools-<VERSION>-linux.tar.gz "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download migration tool with Wget" accordion-title-link="download-migration-tool-wget" >}}

    Using Wget:

    ```sh
    wget -O "migration-tools-<VERSION>-linux.tar.gz" "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. Extract the migration tool and make it executable.

    ```sh
    tar -xvf migration-tools-<VERSION>-linux.tar.gz -C /path/to/temp/folder
    cd /path/to/temp/folder
    chmod +x migrate-ice
    mv migrate-ice /usr/local/bin/
    ```

1. Optional: Verify that the migration tool is installed.

    ```sh
    migrate-ice --help
    ```

    The migration tool returns available commands and usage guidelines.

1. Install Chef Infra CLient using [`migrate-ice apply`](reference):

    ```sh
    sudo migrate-ice apply airgap <PATH/TO/BUNDLE> --fresh-install
    ```

    Replace `<PATH/TO/BUNDLE>` with the path to the Chef Infra Client tar file.

1. Verify that Chef Infra Client is installed.

    ```sh
    chef-client --version
    ```

## Next step

- [Add a Chef license](/license)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
