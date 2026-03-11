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

- If you're deploying Chef Local License Service in an **airgapped environment** or in a **container**, download the license data from Chef's licensing server using an internet-connected workstation:

  ```sh
  curl --location 'https://services.chef.io/licensing/download?licenseId=<LICENSE_ID>&version=2' -o <JSON_LICENSE_DATA_FILENAME>
  ```

  Replace:

  - `<LICENSE_ID>` with your license ID. You can get this from [Chef Support](https://community.progress.com/s/products/chef).
  - `<JSON_LICENSE_DATA_FILENAME>` with a JSON filename to save the data locally.

## System requirements

Chef Local License Service requires:

- A machine running Linux with kernel 2.6.32 or later on an x86-64 processor
- On your machine, open port 8000 for inbound traffic.

## Deploy Chef Local License Service

You can deploy Chef Local License Service on the server filesystem or in a Docker container.

### Run on the server filesystem

To install and run Chef Local License Service from a Chef Habitat package on a server, follow these steps:

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
    chmod u+x <SHELL_SCRIPT_FILENAME>
    ```

1. Symlink the hab location.

    ```sh
    sudo ln -sf /hab/bin/hab /usr/bin/hab
    ```

1. Execute the shell script.

    ```sh
    sudo ./<SHELL_SCRIPT_FILENAME>
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

1. Load the Local License Service package.

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

### Run from a Docker container

This procedure will guide you on how to create a Dockerfile and start the Chef Local license service in a container.

{{< note >}}

You can run Chef Local License Service from a container in an airgapped environment, but the Docker image must be built in an internet-connected environment.

{{< /note >}}

#### Create a Dockerfile, shell script, and config file

1. Create a YAML file with the name `config.yaml` and paste the following content:

    ```yaml
    listen: "0.0.0.0:<SERVICE_PORT_NUMBER>"
    air_gap: <AIRGAP_MODE>
    db_path: "/data/chef/local-license-service/db"
    file_path:  "/data/chef/local-license-service/file"
    logger: "debug"
    external_url: "https://services.chef.io/License/"
    ```

    Replace:

    - `<SERVICE_PORT_NUMBER>` with the port that you want to use for the service. For example, `8000`.
    - `<AIRGAP_MODE>` with `true` if you're deploying in an airgapped environment and `false` if in an internet-connected environment.

1. Create a Dockerfile that runs Chef Local License Service:

   ```docker
   FROM alpine:latest

   ENV LOCAL_LICENSE_URL="<DOWNLOAD_URL>"
   ENV HAB_LICENSE="accept-no-persist"

   WORKDIR /tmp/local-license
   RUN apk --no-cache add curl

   RUN curl $LOCAL_LICENSE_URL -o "local-license-service.tar.gz"
   RUN tar -xvf local-license-service.tar.gz
   RUN mv hab /

   COPY <YAML_CONFIG_FILE_PATH> ./
   COPY <LICENSE_DATA_FOLDER_PATH>/. /data/chef/local-license-service/GLS/.
   COPY startLicenseService.sh ./startLicenseService.sh

   RUN chmod ugo+x startLicenseService.sh
   RUN TMP=$(/hab/bin/hab pkg path chef-private/local-license-service) && ln -s "${TMP}/bin/license-service" /bin/license-service

   EXPOSE <SERVICE_PORT_NUMBER>

   RUN apk --no-cache add bash

   ENTRYPOINT /bin/bash ./startLicenseService.sh /data/chef/local-license-service/GLS/ http://localhost:<SERVICE_PORT_NUMBER>
   ```

    Replace:

    - `<DOWNLOAD_URL>` with your Chef Local License service download URL.
    - `<YAML_CONFIG_FILE_PATH>` with the absolute path of the `config.yaml` file created in the previous step.
    - `<LICENSE_DATA_FOLDER_PATH>` with the absolute path of the folder where your license files are kept.
    - `<SERVICE_PORT_NUMBER>` with the port configured in the `config.yaml` file created in the previous step. For example: `8000`.

1. Create a shell file and paste the following content:

    ```sh
    #!/bin/bash

    if [ $# -eq 0 ]; then
        echo "No arguments supplied"
        echo "Usage:<SHELL_FILENAME> licenseFolderPath http://localhost:8000"
        exit 1
    fi
    declare -r folderPath="$1"
    declare -r serviceUrl="$2"
    IFS=$'\n'
    nohup /bin/license-service localService --config /tmp/local-license/config.yaml > /tmp/local-license/license-service.log &
    serviceHealth () {
        healthCheckRes=$(curl --write-out %{http_code} --silent --output /dev/null $serviceUrl/health-check)
        return $healthCheckRes
    };

    checkAndUpload () {

        listOfFiles=(`ls $folderPath`)
        for file in "${listOfFiles[@]}";
        do
            filePath="$folderPath$file"
            if [[ -f $filePath ]]; then
                echo $file
                serviceHealth
                if [[ $? -eq 200 ]]; then
                    loadReqURL="$serviceUrl/v1/uploadLicense"
                    echo $loadReqURL
                    echo $filePath
                    curl -XPOST $loadReqURL --header 'Content-Type: application/json' -d @$filePath
                fi
            fi
        done
    };

    count=1

    while [ true ];
    do
        serviceHealth
        if [[ $? == 200 ]]; then
            echo "Service is up"
            if [[ $count == 1 ]]; then
                checkAndUpload
                count=$((count+1))
            fi
        else
            echo "Local license service is not up!"
            if [[ $count > 5 ]]; then
                exit 1
            fi
            count=$((count+1))
        fi
        sleep 10
    done
    ```

    Replace `<SHELL_FILENAME>` with the name of the shell file.

#### Build the image and run the container

1. Build the image from the DockerFile:

    ```sh
    docker build -t "local-license-service" .
    ```

1. Run the Chef Local license service container:

    ```sh
    docker run --name="<CONTAINER_NAME>" -p <DESTINATION_PORT>:<SERVICE_PORT_NUMBER> --volume=<VOLUME_PATH>:/data/chef/local-license-service/db -d local-license-service:latest
    ```

    Replace:

    - `<CONTAINER_NAME>` with the container name for local license service.
    - `<DESTINATION_PORT>` with the port that you want to use for accessing the service.
    - `<SERVICE_PORT_NUMBER>` with the service port that you configured in the `config.yaml` file.
    - `<VOLUME_PATH>` with the path of the directory on the host where you want to persist the data.

## Load license data

You can load license data depending on whether your service is running in an airgapped environment or a non-airgapped environment.

### Airgapped environment

In an **airgapped environment**, use the `v1/uploadLicense` endpoint to load your licensing data.

```sh
curl --location --request POST 'http://<IP_ADDRESS>:<SERVICE_PORT>/v1/uploadLicense' --header 'Content-Type: application/json' -d @<LICENSE_DATA_FILENAME>.json
```

Replace:

- `<IP_ADDRESS>` with your Local Licensing Service IP address.
- `<SERVICE_PORT>` with your Local Licensing Service port. Default value is `8000`.
- `<LICENSE_DATA_FILENAME>` with the path and filename of your license data.

### Non-airgapped environment

In a **non-airgapped environment**, use the `v1/loadLicense` endpoint to load your licensing data directly from the Chef's licensing server.

```sh
curl --location 'http://<IP_ADDRESS>:<SERVICE_PORT>/v1/loadLicense' --header 'Content-Type: application/json' --data '{"LicenseId": "<LICENSE_ID>"}'
```

Replace:

- `<IP_ADDRESS>` with your Local Licensing Service IP address.
- `<SERVICE_PORT>` with your Local Licensing Service port. Default value is `8000`.
- `<LICENSE_ID>` with your license ID.

## Verify license data

To verify your licenses have loaded, use the `/v1/listLicenses` endpoint to list license data loaded on Chef Local License Service.

```sh
curl --location --request GET 'http://<IP_ADDRESS>:<SERVICE_PORT>/v1/listLicenses'
```

Replace:

- `<IP_ADDRESS>` with your Local Licensing Service IP address.
- `<SERVICE_PORT>` with your Local Licensing Service port. Default value is `8000`.

After you upload the license data, you can set your Chef Local License Service IP address or URL in your Chef applications using the `CHEF_LICENSE_SERVER` environment setting or `--chef-license-server` CLI option.
