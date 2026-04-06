+++
title = "Upgrade Chef Infra Client to version 19 RC3 using the migration tool in an online environment"

[menu.install]
title = "Online upgrade"
identifier = "install/migration_tool/upgrade_online"
parent = "install/migration_tool"
weight = 20
+++

This page documents how to upgrade Chef Infra Client to version 19 RC3 in an online environment.

## Supported platforms

Chef Infra Client is supported on:

- Linux x86-64
- Windows x86-64

## Prerequisites

- a valid Chef License key

## Upgrade Chef Infra Client on Linux

To upgrade Chef Infra Client, follow these steps:

1. Get the latest version of the Chef Infra Client migration tool (migrate-ice).

    ```sh
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version number. Use this version to download the migration tool package.

1. Download the migration tool using curl or Wget.

    {{< accordion-list id="download-migration-tool-curl-wget-linux" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Download migration tool with curl" accordion-title-link="download-migration-tool-curl-linux" >}}

    Using curl:

    ```sh
    curl -o migration-tools-<VERSION>-linux.tar.gz "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Download migration tool with Wget" accordion-title-link="download-migration-tool-wget-linux" >}}

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

1. Upgrade Chef Infra Client using [`migrate-ice apply`](reference).

   You can upgrade Chef Infra Client by specifying a download URL or a version number.

    {{< accordion-list id="upgrade-chef-infra-client-linux" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Specify download URL" accordion-title-link="upgrade-chef-infra-client-url-linux"  >}}

    ```sh
    sudo migrate-ice apply online --download-url "<CHEF_TAR_DOWNLOAD_URL>"
    ```

    Replace `<CHEF_TAR_DOWNLOAD_URL>` with the Chef Infra Client package download URL.

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Specify version number" accordion-title-link="upgrade-chef-infra-client-version-linux" >}}

    ```sh
    sudo migrate-ice apply online --chef-version <VERSION> --license-key "<LICENSE_KEY>"
    ```

    Replace:

    - `<VERSION>` with the Chef Infra Client version number (for example, `19.1.150`)
    - `<LICENSE_KEY>` with your Progress Chef License key.

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. Verify that Chef Infra Client is installed.

    ```sh
    chef-client --version
    ```

## Upgrade Chef Infra Client on Windows

To upgrade Chef Infra Client, follow these steps:

1. Get the latest version of the Chef Infra Client migration tool (migrate-ice).

    ```powershell
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version number. Use this version to download the migration tool package.

1. Download the migration tool.

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
    cd C:\migrate-tool
    Expand-Archive -Path "migration-tools-<VERSION>-windows.zip" -DestinationPath "."
    ```

1. Optional: Verify that the migration tool works.

    ```powershell
    .\migrate-ice --help
    ```

    The migration tool returns available commands and usage guidelines.

1. Upgrade Chef Infra Client using [`migrate-ice apply`](reference).

    You can upgrade Chef Infra Client by specifying the download URL or a version number.

    {{< accordion-list id="upgrade-chef-infra-client-windows" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title="Specify download URL" accordion-title-link="upgrade-chef-infra-client-url-windows"  >}}

    ```powershell
    .\migrate-ice apply online --download-url "<CHEF_TAR_DOWNLOAD_URL>"
    ```

    Replace `<CHEF_TAR_DOWNLOAD_URL>` with the Chef Infra Client package download URL.

    {{< /accordion-item >}}

    {{< accordion-item accordion-title="Specify version number" accordion-title-link="upgrade-chef-infra-client-version-windows" >}}

    ```powershell
    .\migrate-ice apply online --chef-version <VERSION> --license-key "<LICENSE_KEY>"
    ```

    Replace:

    - `<VERSION>` with the Chef Infra Client version number (for example, `19.1.150`)
    - `<LICENSE_KEY>` with your Progress Chef License key

    {{< /accordion-item >}}

    {{< /accordion-list >}}

1. Verify the Chef Infra Client upgrade.

    ```powershell
    chef-client --version
    ```

## Next step

- [Add a Chef license](/license)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
