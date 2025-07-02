+++
title = "Connect your workstation to your Chef Habitat On-Prem Builder deployment"

[menu]
  [menu.habitat]
    title = "Connect your workstation to Builder"
    identifier = "habitat/on-prem-builder/install/workstation"
    parent = "habitat/on-prem-builder/install"
    weight = 50

+++

Follow the steps below to configure your workstation to connect with your Chef Habitat On-Prem Builder deployment.

## Before you begin

Before you begin, you'll need to set or create an authentication token in your Habitat Builder deployment.

If you don't already have a token, follow these steps to generate one:

1. In the top right corner of your on-prem Habitat Builder site, select your Gravatar icon, then select **Profile**.
1. On the profile page, generate your access token and save it securely.

## Configure your workstation

To configure your workstation to connect to your deployment of Chef Habitat On-Prem Builder, set the following environment variables:

1. Set `HAB_BLDR_URL` to the URL of your Chef Habitat On-Prem Builder deployment.
   For example:

   ```shell
   export HAB_BLDR_URL=https://bldr.example.com/bldr/v1/
   ```

1. Set `HAB_AUTH_TOKEN` to your authentication token:

    ```shell
    export HAB_AUTH_TOKEN=<ON_PREM_BUILDER_INSTANCE_TOKEN>
    ```

1. If your Chef Habitat On-Prem Builder deployment uses SSL with a self-signed or untrusted certificate, set `SSL_CERT_FILE` to the correct certificate when connecting to your Habitat Builder.

    ```shell
    export SSL_CERT_FILE=path/to/ssl-certificate.crt
    ```
