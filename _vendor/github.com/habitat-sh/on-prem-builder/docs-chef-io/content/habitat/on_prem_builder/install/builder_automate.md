+++
title = "Install Chef Habitat Builder on-prem using Chef Automate to authenticate"

[menu]
  [menu.habitat]
    title = "Install Builder using Chef Automate to authenticate"
    identifier = "habitat/on-prem-builder/install/Automate"
    parent = "habitat/on-prem-builder/install"
    weight = 30
+++

You can use Chef Automate as an OAuth provider and use the Automate Applications dashboard to monitor your Chef Habitat Builder installation.
For information and installation guidance, see [Setting up the Applications Dashboard](/automate/applications_setup/).

## Before you begin

Review [Habitat Builder's system requirements](../system_requirements).

## Deploy Chef Habitat on-prem with Chef Automate

There are five steps to deploy Chef Habitat on-prem with Chef Automate's authentication:

1. Patch the Chef Automate configuration to recognize Chef Habitat.
1. Set up the Chef Habitat Builder on-prem `bldr.env` to use Chef Automate's authentication.
1. Copy your custom builder certificate files (`.crt` and `.key`) to the same location as the `./install.sh` script.
1. Install Chef Habitat Builder on-prem.
1. Copy Automate's certificate to the `/hab/cache/ssl` directory.

### Patch Chef Automate's configuration

To authenticate with Chef Automate, create a patch with the Chef Automate command line:

1. From the command line, access Chef Automate, for example:

    ```bash
    ssh <AUTOMATE_HOSTNAME>
    ```

    or

    ```bash
    ssh <IP_ADDRESS>
    ```

1. Create a patch file called `patch-automate.toml`:

    ```bash
    touch patch-automate.toml
    ```

1. Edit the `patch-automate.toml`:

    ```toml
    [session.v1.sys.service]
    bldr_signin_url = "https://chef-builder.example.com/"
    # OAUTH_CLIENT_ID
    bldr_client_id = "0123456789abcdef0123"
    # OAUTH_CLIENT_SECRET
    bldr_client_secret = "0123456789abcdef0123456789abcdef01234567"
    ```

    Note that the `OAUTH_CLIENT_ID` and `OAUTH_CLIENT_SECRET` values above match the default values in the bldr.env.sample file which you will edit in the next step. You can change these values, but they must match the `OAUTH_CLIENT_ID` and `OAUTH_CLIENT_SECRET` in your on-prem Habitat Builder's `bldr.env` file.

1. Apply the `patch-automate.toml` to the Chef Automate configuration from the command line:

    ```bash
    sudo chef-automate config patch patch-automate.toml
    ```

    A successful patch displays the output:

    ```shell
    Updating deployment configuration
    Applying deployment configuration
      Started session-service
    Success: Configuration patched
    ```

1. Exit Chef Automate

### Configure the `bldr.env` file

1. SSH to your Chef Habitat Builder on-prem instance:

    ```bash
    ssh <BUILDER_HOSTNAME_OR_IP_ADDRESS>
    ```

1. Clone the Chef Habitat Builder on-prem repository:

    ```bash
    git clone https://github.com/habitat-sh/on-prem-builder.git
    ```

1. Change to the `on-prem-builder` directory:

    ```bash
    cd on-prem-builder
    ```

1. Create a copy of the `bldr.env` file:

    ```bash
    cp bldr.env.sample bldr.env
    ```

1. Edit the `bldr.env` file:

    - Set `APP_SSL_ENABLED` to `true` to enable SSL in Habitat Builder to authenticate against Automate:

      ```sh
      export APP_SSL_ENABLED=true
      ```

    - Set `APP_URL` to the URL of your Builder deployment. It must begin with `https` to enable SSL and close with a forward slash (`/`):

      ```sh
      export APP_URL=https://bldr.example.com/
      ```

    - Set `OAUTH_PROVIDER` to `chef-automate`.

    - Set the values of `OAUTH_USERINFO_URL`, `OAUTH_AUTHORIZE_URL`, and `OAUTH_TOKEN_URL` to the example values provided in the `sample.bldr.env` file. Replace `<your.automate.domain>` with your Chef Automate server or domain name.

      For example:

      ```sh
      export OAUTH_USERINFO_URL=https://automate.example.com/session/userinfo
      export OAUTH_AUTHORIZE_URL=https://automate.example.com/session/new
      export OAUTH_TOKEN_URL=https://automate.example.com/session/token
      ```

    - Set `OAUTH_REDIRECT_URL` to your on-prem Habitat Builder URL. It must begin with `https` to enable SSL and close with a forward slash (`/`):

      ```sh
      export OAUTH_REDIRECT_URL=https://bldr.example.com/
      ```

### Copy the Builder certificates with the install script

1. Rename the custom Builder certificate file `ssl-certificate.crt` and the key file `ssl-certificate.key`.
   Habitat recognizes only these filenames.
1. Copy the `ssl-certificate.crt` and `ssl-certificate.key` files to the same directory as the `./install.sh` script. This is `/on-prem-builder` if you didn't rename the repository.
1. Make the keys accessible to Habitat during the installation.

    {{< note >}}

    If you're testing this workflow, you can make your own key pair and copy them to `/on-prem-builder`:

    ```bash
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-certificate.key -out /etc/ssl/certs/ssl-certificate.crt
    sudo cp /etc/ssl/private/ssl-certificate.key .
    sudo cp /etc/ssl/certs/ssl-certificate.crt .
    sudo chown vagrant:vagrant ssl-certificate.*
    ```

    {{< /note >}}

1. Optional: Confirm that the keys were copied:

    ```bash
    cat ./ssl-certificate.key
    cat ./ssl-certificate.crt
    ```

### Install Chef Habitat Builder

1. Run the install script. This installs both Chef Habitat Builder on-prem and the Chef Habitat datastore:

    ```bash
    sudo ./install.sh
    ```

1. Accept the licenses.
1. Get the status of the Habitat services:

    ```bash
    sudo hab svc status
    ```

    It may take a few minutes to get a response, but all services should report back as `up`. For example:

    ```shell
    package                                        type        desired  state  elapsed (s)  pid    group
    habitat/builder-api/8473/20190830141422        standalone  up       up     595          28302  builder-api.default
    habitat/builder-api-proxy/8467/20190829194024  standalone  up       up     597          28233  builder-api-proxy.default
    habitat/builder-memcached/7728/20180929144821  standalone  up       up     597          28244  builder-memcached.default
    habitat/builder-datastore/7809/20181019215440  standalone  up       up     597          28262  builder-datastore.default
    habitat/builder-minio/7764/20181006010221      standalone  up       up     597          28277  builder-minio.default
    ```

### Copy Chef Automate's certificate to Habitat Builder

1. View and copy the Chef Automate certificate.

    ```bash
    openssl s_client -showcerts -servername <SERVER_NAME> -connect <HOST>:<PORT> < /dev/null | openssl x509
    ```

    Replace:

    - `<SERVER_NAME>` with the FQDN of your Chef Automate installation. For example: `automate.example.com`.
    - `<HOST>:<PORT>` with the host and port of your Chef Automate installation. For example: `automate.example.com:443`.

1. Copy the output to an accessible file.

    ```shell
    # Copy the contents including the begin and end certificate
    # -----BEGIN CERTIFICATE-----
    # <CERTIFICATE_CONTENT>
    #-----END CERTIFICATE-----
    ```

1. Make a certificate file at `/hab/cache/ssl/`, such as `/hab/cache/ssl/automate-cert.crt`.
1. Paste the Chef Automate certificate into your file, `/hab/cache/ssl/automate-cert.crt`
1. Restart Habitat Builder:

    ```bash
    sudo systemctl restart hab-sup
    ```

You're done. You can now monitor Habitat Builder using Chef Automate's Applications dashboard.

## Related resources

- [Chef Automate](/automate/on_prem_builder/)

## Next steps

After you've deployed Habitat Builder:

- [Configure your workstation to connect to your Habitat Builder deployment](../workstation).
- [Bootstrap the core origin packages](../bootstrap-core).
