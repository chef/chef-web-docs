+++
title = "Install Chef Infra Client using the migration tool in an online environment"

[menu.install]
title = "Online install"
identifier = "install/migration_tool/install_online"
parent = "install/migration_tool"
weight = 20
+++

This page documents how to install Chef Infra Client RC3 in an online environment.

## Supported platforms

Chef Infra Client is supported on:

- Linux x86-64
- Windows x86-64

## Prerequisites

- a valid Chef License key

## Install Chef Infra Client on Linux

To install Chef Infra Client on Linux, follow these steps:

1. Optional: Verify that Chef Infra Client isn't already installed on your system:

    ```sh
    chef-client --version
    ```

1. Get the latest version number of the Infra Client migration tool (migrate-ice).

    ```sh
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version.

1. Download the Chef Infra Client migration tool using curl or Wget.

    {{< accordion-list id="download-migration-tool-curl-wget-linux" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title-link="download-migration-tool-with-curl-linux" accordion-title="Download migration tool with curl" >}}

    Download the migration tool using curl:

    ```sh
    curl -o migration-tools-<VERSION>-linux.tar.gz "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title-link="download-migration-tool-with-wget-linux" accordion-title="Download migration tool with Wget" >}}

    Download the migration tool using Wget:

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

1. Install Chef Infra Client using [`migrate-ice apply`](reference):

    You can install Chef Infra Client using specifying a download URL or an Infra Client version number.

    {{< accordion-list id="migrate-ice-download-linux" data-allow-all-closed="true" >}}
    {{< accordion-item accordion-title-link="migrate-ice-download-url-linux" accordion-title="Specify download URL" >}}

    ```sh
    sudo migrate-ice apply online --fresh-install --download-url "<CHEF_TAR_DOWNLOAD_URL>"
    ```

    Replace `<CHEF_TAR_DOWNLOAD_URL>` with the Chef Infra Client package download URL.

    {{< /accordion-item >}}
    {{< accordion-item accordion-title-link="migrate-ice-download-version-number-linux" accordion-title="Specify version number" >}}

    ```sh
    sudo migrate-ice apply online --fresh-install --chef-version <VERSION> --license-key "<LICENSE_KEY>"
    ```

    Replace:

    - `<VERSION>` with the Chef Infra Client version number (for example, `19.1.150`)
    - `<LICENSE_KEY>` with your Progress Chef License key

    {{< /accordion-item >}}
    {{< /accordion-list >}}

1. Verify the Chef Infra Client installation.

    ```sh
    chef-client --version
    ```

## Install Chef Infra Client on Windows

To install Chef Infra Client on Windows, follow these steps:

1. Optional: Verify that Chef Infra Client isn't already installed on your system:

    ```powershell
    chef-client --version
    ```

1. Get the latest version number of the Infra Client migration tool (migrate-ice):

    ```powershell
    curl "https://chefdownload-commercial.chef.io/stable/migrate-ice/versions/latest?license_id=<LICENSE_ID>"
    ```

    Replace `<LICENSE_ID>` with your Progress Chef License ID.

    The response returns the latest version.

1. Download the migration tool using curl or PowerShell:

    {{< accordion-list id="download-migration-tool-curl-powershell-windows" data-allow-all-closed="true" >}}

    {{< accordion-item accordion-title-link="download-migration-tool-with-curl-windows" accordion-title="Download migration tool with curl" >}}

    Download the migration tool using curl:

    ```powershell
    curl -o migration-tools-<VERSION>-windows.zip "https://chefdownload-commercial.chef.io/stable/migrate-ice/packages?v=<VERSION>&license_id=<LICENSE_ID>"
    ```

    Replace:

    - `<VERSION>` with the version number from the previous step
    - `<LICENSE_ID>` with your Progress Chef License ID

    {{< /accordion-item >}}

    {{< accordion-item accordion-title-link="download-migration-tool-with-powershell-windows" accordion-title="Download migration tool with PowerShell" >}}

    Download the migration tool using PowerShell:

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

1. Install Chef Infra Client using [`migrate-ice apply`](reference):

    You can install Chef Infra Client using specifying a download URL or an Infra Client version number.

    {{< accordion-list id="migrate-ice-download-windows" data-allow-all-closed="true" >}}
    {{< accordion-item accordion-title-link="migrate-ice-download-url-windows" accordion-title="Specify download URL" >}}

    ```powershell
    .\migrate-ice apply online --fresh-install --download-url "<CHEF_TAR_DOWNLOAD_URL>"
    ```

    Replace `<CHEF_TAR_DOWNLOAD_URL>` with the Chef Infra Client package download URL.

    {{< /accordion-item >}}
    {{< accordion-item accordion-title-link="migrate-ice-download-version-number-windows" accordion-title="Specify version number" >}}

    ```powershell
    .\migrate-ice apply online --fresh-install --chef-version <VERSION> --license-key "<LICENSE_KEY>"
    ```

    Replace:

    - `<VERSION>` with the Chef Infra Client version number (for example, `19.1.150`)
    - `<LICENSE_KEY>` with your Progress Chef License key

    {{< /accordion-item >}}
    {{< /accordion-list >}}

1. Verify the Chef Infra Client installation.

    ```powershell
    chef-client --version
    ```

## Next step

- [Add a Chef license](/license)

## More information

- [Chef Download API documentation](https://docs.chef.io/download/)
