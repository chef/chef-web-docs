+++
title = "Upgrade Chef Infra Client to version 19 RC3 using the migration tool in an air-gapped environment"

[menu.install]
title = "Air-gapped upgrade"
identifier = "install/migration_tool/upgrade_airgap"
parent = "install/migration_tool"
weight = 20
+++

This page documents how to upgrade Chef Infra Client to version 19 RC3 in an air-gapped environment.

## Supported platforms

Chef Infra Client is supported on:

- Linux x86-64
- Windows x86-64

## Prerequisites

- a valid Chef License key

## Upgrade to Chef Infra Client on Linux

To upgrade Chef Infra Client, follow these steps:

1. On an internet-connected machine, get the download URL for the Chef Infra Client tar package:

    ```sh
    curl "https://chefdownload-commercial.chef.io/stable/chef-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace `<VERSION>` with the Chef Infra Client version number (for example, 19.1.152) and `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns download URLs for different platforms and package types. Use the URL from the `linux.<ARCHITECTURE>.tar.url` field in the JSON response (for example, `linux.x86_64.tar.url` if the architecture is x86_64).

1. Download the Chef Infra Client tar file.

    {{< accordion-list id="download-chef-infra-client-curl-wget-linux" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download using curl" accordion-title-link="download-chef-infra-client-curl-linux"  >}}

    Download the tar file using curl:

    ```sh
    curl -o chef-ice-<VERSION>-linux.tar.gz "<CHEF_TAR_URL>"
    ```

    Replace:

    - `<CHEF_TAR_URL>` with the URL from the `linux.<ARCHITECTURE>.tar.url` field
    - `<VERSION>` with the Chef Infra Client version number

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download using Wget" accordion-title-link="download-chef-infra-client-wget-linux" >}}

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

1. Download the Chef Infra Client migration tool package.

    {{< accordion-list id="download-migration-tool-package-curl-wget-linux" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download migration tool with curl" accordion-title-link="download-migration-tool-curl-linux"  >}}

    Download migration tool using curl:

    ```sh
    curl -o migration-tools-<VERSION>-linux.tar.gz "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download migration tool with Wget" accordion-title-link="download-migration-tool-wget-linux" >}}

    Download migration tool using Wget:

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

1. Install Chef Infra Client by specifying the path to the tar file using [`migrate-ice apply`](reference).

    ```sh
    sudo migrate-ice apply airgap <PATH/TO/BUNDLE>
    ```

    Replace `<PATH/TO/BUNDLE>` with the path to the Chef Infra Client tar file.

1. Verify that Chef Infra Client is installed.

    ```sh
    chef-client --version
    ```

## Upgrade to Chef Infra Client on Windows

To upgrade Chef Infra Client, follow these steps:

1. On an internet-connected machine, get the download URL for the Chef Infra Client tar package:

    ```powershell
    curl "https://chefdownload-commercial.chef.io/stable/chef-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace `<VERSION>` with the Chef Infra Client version number (for example, 19.1.152) and `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns download URLs for different platforms and package types. Use the URL from the `windows.<ARCHITECTURE>.tar.url` field in the JSON response (for example, `windows.x86_64.tar.url` if the architecture is x86_64).

1. Download the Chef Infra Client tar file.

    {{< accordion-list id="my-accordion" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download Chef Infra Client with curl" accordion-title-link="download-chef-infra-client-curl-windows"  >}}

    Download the tar file using curl:

    ```powershell
    curl -o chef-ice-<VERSION>-windows.tar.gz "<CHEF_TAR_URL>"
    ```

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download Chef Infra Client with PowerShell" accordion-title-link="download-chef-infra-client-powershell-windows" >}}

    Download using PowerShell:

    ```powershell
    Invoke-WebRequest -Uri "<CHEF_TAR_URL>" -OutFile "chef-ice-<VERSION>-windows.tar.gz"
    ```

    Replace:

    - `<CHEF_TAR_URL>` with the URL from the `windows.<ARCHITECTURE>.tar.url` field
    - `<VERSION>` with the Chef Infra Client version number

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. On an internet-connected machine, get the latest version of the Chef Infra Client migration tool (migrate-ice).

    ```powershell
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version number. Use this version to download the migration tool package.

1. Download the Chef Infra Client migration tool package.

    {{< accordion-list id="download-migration-tool-curl-powershell-windows" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download migration tool with curl" accordion-title-link="download-migration-tool-curl-windows"  >}}

    Using curl:

    ```powershell
    curl -o migration-tools-<VERSION>-windows.zip "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download migration tool with PowerShell" accordion-title-link="download-migration-tool-powershell-windows" >}}

    Using PowerShell:

    ```powershell
    Invoke-WebRequest -Uri "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>" -OutFile "migration-tools-<VERSION>-windows.zip"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. Extract the migration tool.

    ```powershell
    mkdir C:\migrate-tool
    move "migration-tools-<VERSION>-windows.zip" "C:\migrate-tool\"
    move "chef-ice-<CHEF_VERSION>-windows.tar.gz" "C:\migrate-tool\"
    cd C:\migrate-tool
    Expand-Archive -Path "migration-tools-<VERSION>-windows.zip" -DestinationPath "."
    ```

1. Optional: Verify that the migration tool works.

    ```powershell
    .\migrate-ice --help
    ```

    The migration tool returns available commands and usage guidelines.

1. Upgrade Chef Infra Client by specifying the path to the tar file using [`migrate-ice apply`](reference).

    ```powershell
    .\migrate-ice apply airgap "C:\migrate-tool\chef-ice-<CHEF_VERSION>-windows.tar.gz"
    ```

    Replace `<CHEF_VERSION>` with the Chef Infra Client version.

1. Verify the Chef Infra Client upgrade.

    ```powershell
    chef-client --version
    ```

## Next step

- [Add a Chef license](/license)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
