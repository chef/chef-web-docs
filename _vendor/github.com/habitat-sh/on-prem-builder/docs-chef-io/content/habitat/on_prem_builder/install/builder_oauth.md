+++
title = "Install Chef Habitat Builder with OAuth services"

[menu]
  [menu.habitat]
    title = "Install Builder using OAuth provider to authenticate"
    identifier = "habitat/on-prem-builder/install/o-auth"
    parent = "habitat/on-prem-builder/install"
    weight = 40
+++

This page documents how to deploy Chef Habitat Builder with a 3rd-party OAuth provider that provides authentication services.

## Before you begin

Before you begin, review [Habitat Builder's system requirements](../system_requirements).

### Configure an OAuth provider

Chef Habitat Builder on-prem supports Chef Automate v2, Azure AD (OpenID Connect), GitHub, GitLab (OpenID Connect), Okta (OpenID Connect), and Atlassian Bitbucket (cloud) OAuth providers for authentication.
You need to set up an OAuth application for your Chef Habitat Builder on-prem instance.

Before you begin, refer to the for the OAuth provider that you plan to use:

- [Azure Active Directory](https://docs.microsoft.com/azure/active-directory/develop/active-directory-protocols-oauth-code)
- [GitHub](https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/)
- [GitLab](https://docs.gitlab.com/ee/integration/oauth_provider.html)
- [Okta](https://developer.okta.com/authentication-guide/implementing-authentication/auth-code)
- [Bitbucket](https://confluence.atlassian.com/bitbucket/oauth-on-bitbucket-cloud-238027431.html)

Follow the steps for your OAuth provider to create and configure your OAuth application.
The following steps show how to set up the OAuth application using GitHub as the identity provider:

1. Create a new OAuth application in your OAuth provider, for example, [GitHub](https://github.com/settings/applications/new).

1. Record the following OAuth configuration settings which you will use when define the `bldr.env` config file:

    - Authorization endpoint (for example, `https://github.com/login/oauth/authorize`)
    - Token endpoint (for example, `https://github.com/login/oauth/access_token`)
    - API endpoint (for example, `https://api.github.com/user`)
    - Record the client ID and client secret. You'll use these for the `OAUTH_CLIENT_ID` and `OAUTH_CLIENT_SECRET` environment variables.

For more details on OAuth endpoints, see the Internet Engineering Task Force (IETF) RFC 6749, [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-3.2).

### Optional: Prepare your filesystem

You might need substantial storage for packages, so make sure you have enough free space on your filesystem.

The package artifacts are stored in your MinIO instance by default, typically at the following location: `/hab/svc/builder-minio/data`. If you need more storage, create a mount at `/hab` and point it to your external storage.
You don't need to do this if you already have enough free space.

If you want to use Artifactory instead of MinIO for object storage, see the [Artifactory documentation](/habitat/on_prem_builder/configure/artifactory).

### Get an SSL certificate

By default, Chef Habitat Builder on-prem exposes the web UI and API through HTTP.
This setup is easier for evaluation, but for a secure and permanent installation you should enable SSL on these endpoints.

To prepare, get an SSL certificate.
You can use a self-signed certificate, but if you do, you need to install the certificate in the trusted chain on client machines that use the Chef Habitat Builder UI or APIs.

The following example command generates a self-signed certificate with OpenSSL:

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-certificate.key -out /etc/ssl/certs/ssl-certificate.crt
```

The certificate files must be named `ssl-certificate.key` and `ssl-certificate.crt`. If you get the certificate from another source, rename the files to these names. Place both files in the same folder as the `install.sh` script. The install process uploads them to the Chef Habitat supervisor.

{{< note >}}

You can also use the `SSL_CERT_FILE` environment variable to point to the certificate on client machines when using the `hab` client, for example:

```bash
SSL_CERT_FILE=ssl-certificate.crt hab pkg search -u https://localhost <SEARCH_TERM>
```

{{< /note >}}

### Prerequisites for airgapped environments

If you're installing Chef Habitat Builder in an airgapped environment, follow the steps below to download and install Chef Habitat and Chef Habitat packages in the airgapped environment.

With an internet-connected computer, follow these steps:

1. Download the [zip archive of the on-prem-builder repository](https://github.com/habitat-sh/on-prem-builder/archive/master.zip):

    ```bash
    curl -LO https://github.com/habitat-sh/on-prem-builder/archive/master.zip
    ```

1. Download the Chef Habitat [CLI tool](https://packages.chef.io/files/stable/habitat/latest/hab-x86_64-linux.tar.gz):

    ```bash
    curl -Lo hab.tar.gz https://packages.chef.io/files/stable/habitat/latest/hab-x86_64-linux.tar.gz
    ```

1. Create the Habitat Builder package bundle from the Builder seed lists and download the packages:

    ```bash
    sudo hab pkg install habitat/pkg-sync --channel LTS-2024

    export DOWNLOAD_DIR=/path/to/download/directory

    hab pkg exec habitat/pkg-sync pkg-sync \
      --channel stable \
      --package-list builder \
      --generate-airgap-list

    hab pkg download \
      --target x86_64-linux \
      --channel stable \
      --file package_list_x86_64-linux.txt \
      --download-directory ${DOWNLOAD_DIR}/builder_packages
    ```

1. Archive the download directory, then transfer and extract it on the Linux system where you will deploy Builder in the airgapped environment.

In the airgapped environment, complete these steps:

1. From the archive, install the `hab` binary somewhere in the system $PATH and ensure it has execute permissions:

    ```bash
    sudo chmod 755 /usr/bin/hab
    sudo hab
    ```

    Read and accept the license.

1. Import the public package signing keys from the downloaded Builder package bundle:

    ```bash
    export UNZIP_DIR=/some/base/unzip/directory

    for file in $(ls ${UNZIP_DIR}/builder_packages/keys/*pub); do
      cat $file | sudo hab origin key import
    done
    ```

1. Create a Habitat artifact cache directory, place the Builder `*.hart` packages into that directory and then pre-install the Builder Services:

    ```bash
    sudo mkdir -p /hab/cache/artifacts
    sudo mv ${UNZIP_DIR}/builder_packages/artifacts/*hart /hab/cache/artifacts
    sudo hab pkg install /hab/cache/artifacts/habitat-builder*hart
    ```

1. Pre-install the Habitat Supervisor and its dependencies:

    ```bash
    sudo hab pkg install --binlink --force /hab/cache/artifacts/core-hab-*hart
    ```

## Configure Chef Habitat Builder

Chef Habitat Builder is configured with a `bldr.env` file. Follow these steps to create and edit this file:

1. On the machine where you want to install Chef Habitat Builder, clone the [habitat-sh/on-prem-builder repository](https://github.com/habitat-sh/on-prem-builder/) or download a release from the [GitHub release page](https://github.com/habitat-sh/on-prem-builder/releases).

1. In the repository root create a copy of the sample environment file:

    ```bash
    cp bldr.env.sample bldr.env
    ```

1. Open `bldr.env` in a text editor and update the values as needed.

    To configure your OAuth provider setting, enter the following:

    1. Set `APP_URL` to the IP address or URL of your Habitat Builder deployment :`http://<BUILDER_HOSTNAME_OR_IP>/`. Use `https` if you plan to enable SSL: `https://<BUILDER_HOSTNAME_OR_IP>/`.
    1. Set `OAUTH_REDIRECT_URL` to the callback URL: `http://<BUILDER_HOSTNAME_OR_IP>/`. You must include a trailing `/` with the URL. Specify `https` instead of `http` if you plan to enable SSL.
    1. Set `OAUTH_CLIENT_ID` and `OAUTH_CLIENT_SECRET` to the OAuth client ID and client secret.

    Optional:

    - To help improve Chef Habitat, you can set `ANALYTICS_ENABLED` to `true` and optionally provide your company name.

## Install Chef Habitat Builder

Follow these steps:

1. Run the install script:

    ```bash
    ./install.sh
    ```

    If the installation succeeds, you should see output similar to the following, showing that the Chef Habitat Builder on-prem services are loaded:

    ```shell
    hab-sup(AG): The habitat/builder-datastore service was successfully loaded
    hab-sup(AG): The habitat/builder-minio service was successfully loaded
    hab-sup(AG): The habitat/builder-memcached service was successfully loaded
    hab-sup(AG): The habitat/builder-api service was successfully loaded
    hab-sup(AG): The habitat/builder-api-proxy service was successfully loaded
    ```

1. Optional: Check the status of all services:

    ```bash
    hab svc status
    ```

    It may take a few seconds for all services to start.
    If any services aren't in the `up` state, see the [troubleshooting documentation](troubleshooting).

## MinIO web UI

Chef Habitat Builder on-prem stores package artifacts in [MinIO](https://github.com/minio/minio).
By default, the MinIO instance is available on port 9000 or on the port you specified in your `bldr.env` file.
You can verify that the MinIO UI is available and log in with the credentials from your `bldr.env` file.
A bucket for storing artifacts should already exist.

## Chef Habitat Builder on-prem web UI

After all services are running, the Chef Habitat Builder on-prem UI is available at the configured hostname or IP address.

Go to `http://<BUILDER_HOSTNAME_OR_IP>/#/sign-in` to access the Chef Habitat Builder on-prem UI.

You can now sign in using your configured OAuth provider.

## Next steps

After you've deployed Habitat Builder:

- [Configure your workstation to connect to your Habitat Builder deployment](../workstation).
- [Bootstrap the core origin packages](/habitat/on_prem_builder/packages/bootstrap_core_packages).
