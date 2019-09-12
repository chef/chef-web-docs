This subcommand has the following options:

`-A`, `--forward-agent`

:   Enable SSH agent forwarding.

`--bootstrap-curl-options OPTIONS`

:   Arbitrary options to be added to the bootstrap command when using
    cURL. This option may not be used in the same command with
    `--bootstrap-install-command`.

`--bootstrap-install-command COMMAND`

:   Execute a custom installation command sequence for Chef Infra
    Client. This option may not be used in the same command with
    `--bootstrap-curl-options` or `--bootstrap-wget-options`.

`--bootstrap-no-proxy NO_PROXY_URL_or_IP`

:   A URL or IP address that specifies a location that should not be
    proxied.

    <div class="alert-info">

    This option is used internally by Chef to help verify bootstrap
    operations during testing and should never be used during an actual
    bootstrap operation.

    </div>

`--bootstrap-preinstall-command COMMANDS`

:   Custom commands to run before installing Chef Infra Client

`--bootstrap-proxy-pass PROXY_PASS`

:   The proxy authentication password for the node being bootstrapped

`--bootstrap-proxy-user PROXY_USER`

:   The proxy authentication username for the node being bootstrapped

`--bootstrap-proxy PROXY_URL`

:   The proxy server for the node that is the target of a bootstrap
    operation.

`--bootstrap-vault-file VAULT_FILE`

:   The path to a JSON file that contains a list of vaults and items to
    be updated.

`--bootstrap-vault-item VAULT_ITEM`

:   A single vault and item to update as `vault:item`.

`--bootstrap-vault-json VAULT_JSON`

:   A JSON string that contains a list of vaults and items to be
    updated. --bootstrap-vault-json '{ "vault1": \["item1", "item2"\],
    "vault2": "item2" }'

`--bootstrap-version VERSION`

:   The version of Chef Infra Client to install.

`--bootstrap-wget-options OPTIONS`

:   Arbitrary options to be added to the bootstrap command when using
    GNU Wget. This option may not be used in the same command with
    `--bootstrap-install-command`.

`-E ENVIRONMENT`, `--environment ENVIRONMENT`

:   The name of the environment. When this option is added to a command,
    the command will run only against the named environment.

`-G GATEWAY`, `--ssh-gateway GATEWAY`

:   The SSH tunnel or gateway that is used to run a bootstrap action on
    a machine that is not accessible from the workstation.

`--hint HINT_NAME[=HINT_FILE]`

:   An Ohai hint to be set on the target node. See the
    [Ohai](/ohai.html#hints) documentation for more information.
    `HINT_FILE` is the name of the JSON file. `HINT_NAME` is the name of
    a hint in a JSON file. Use multiple `--hint` options to specify
    multiple hints.

`-i IDENTITY_FILE`, `--ssh-identity-file IDENTITY_FILE`

:   The SSH identity file used for authentication. Key-based
    authentication is recommended.

`-j JSON_ATTRIBS`, `--json-attributes JSON_ATTRIBS`

:   A JSON string that is added to the first run of a Chef Infra Client.

`--json-attribute-file FILE`

:   A JSON file to be added to the first run of Chef Infra Client.

`-N NAME`, `--node-name NAME`

:   The name of the node.

    <div class="alert-info">

    This option is required for a validatorless bootstrap.

    </div>

`--[no-]fips`

:   Allows OpenSSL to enforce FIPS-validated security during Chef Infra
    Client runs.

`--[no-]host-key-verify`

:   Use `--no-host-key-verify` to disable host key verification. Default
    setting: `--host-key-verify`.

`--[no-]node-verify-api-cert`

:   Verify the SSL certificate on the Chef Infra Server. When `true`,
    Chef Infra Client always verifies the SSL certificate. When `false`,
    Chef Infra Client uses the value of `ssl_verify_mode` to determine
    if the SSL certificate requires verification. If this option is not
    specified, the setting for `verify_api_cert` in the configuration
    file is applied.

`--node-ssl-verify-mode MODE`

:   Set the verify mode for HTTPS requests. Options: `none` or `peer`.

    Use `none` to do no validation of SSL certificates.

    Use `peer` to do validation of all SSL certificates, including the
    Chef Infra Server connections, S3 connections, and any HTTPS
    **remote_file** resource URLs used in a Chef Infra Client run. This
    is the recommended setting.

`-p PORT`, `--ssh-port PORT`

:   The SSH port.

`-P PASSWORD`, `--ssh-password PASSWORD`

:   The SSH password. This can be used to pass the password directly on
    the command line. If this option is not specified (and a password is
    required) knife prompts for the password.

`--prerelease`

:   Install pre-release gems.

`-r RUN_LIST`, `--run-list RUN_LIST`

:   A comma-separated list of roles and/or recipes to be applied.

`--secret SECRET`

:   The encryption key that is used for values contained within a data
    bag item.

`--secret-file FILE`

:   The path to the file that contains the encryption key.

`--sudo`

:   Execute a bootstrap operation with sudo.

`--sudo-preserve-home`

:   Use to preserve the non-root user's `HOME` environment.

`-t TEMPLATE`, `--bootstrap-template TEMPLATE`

:   The bootstrap template to use. This may be the name of a bootstrap
    template---`chef-full`, for example---or it may be the full path to
    an Embedded Ruby (ERB) template that defines a custom bootstrap.
    Default value: `chef-full`, which installs Chef Infra Client using
    the Chef Infra installer on all supported platforms.

`--use-sudo-password`

:   Perform a bootstrap operation with sudo; specify the password with
    the `-P` (or `--ssh-password`) option.

`-V -V`

:   Run the initial Chef Infra Client run at the `debug` log-level (e.g.
    `chef-client -l debug`).

`-V -V -V`

:   Run the initial Chef Infra Client run at the `trace` log-level (e.g.
    `chef-client -l trace`). This was added in Chef Client 14.

`-x USERNAME`, `--ssh-user USERNAME`

:   The SSH user name.