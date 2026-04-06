+++
title = "Chef Infra Client security"
draft = false

[menu]
  [menu.security]
    title = "Chef Infra Client security"
    identifier = "security/chef_client_security.md Security"
    parent = "security"
    weight = 10
+++
<!-- markdownlint-disable-file MD033 -->

{{< readfile file="content/reusable/md/server/chef_auth.md" >}}

## Authentication

{{< readfile file="content/reusable/md/server/chef_auth_authentication.md" >}}

### chef-validator

{{< readfile file="content/reusable/md/security_chef_validator.md" >}}

{{< readfile file="content/reusable/md/security_chef_validator_context.md" >}}

## SSL certificates

{{< readfile file="content/reusable/md/server/server_security_ssl_cert_client.md" >}}

### trusted_certs directory

You can use use a private certificate authority (CA) to generate SSL certificates or they may create self-signed SSL certificates to use on internal networks or during software development and testing.

The `trusted_certs` directory on Chef Workstation and in Chef Infra Client works as a trusted certificate store for all communication in the Chef Infra system. Chef Infra trusts all SSL certificates stored in this directory---including certificates that aren't issued by a trusted certificate authority (CA).

Place private and self-signed certificates in the `trusted_certs` directory to use them within Chef Infra Client and Workstation tools.

Use the [`chef_client_trusted_certificate`]({{< relref "/resources/bundled/chef_client_trusted_certificate" >}}) Chef Infra Client resource to manage these certificates continuously.

#### trusted_certs directory locations

##### Chef Workstation

When you install Chef Workstation, it creates a `trusted_certs` directory located at:.

- Windows: `C:\.chef\trusted_certs`
- All other systems: `~/.chef/trusted_certs`

##### Chef Infra Client nodes

When you bootstrap a node, the Chef Infra Client copies the SSL certificates for Chef Infra Server onto the node. The `trusted_certs` directory on the node is located at:

- Windows: `C:\chef\trusted_certs`
- All other systems: `/etc/chef/trusted_certs`

### SSL_CERT_FILE

Use the `SSL_CERT_FILE` environment variable to specify the location for the SSL certificate authority (CA) bundle for Chef Infra Client.

A value for `SSL_CERT_FILE` isn't set by default. Unless updated, the locations in which Chef Infra will look for SSL certificates are:

- Chef Infra Client: `/opt/chef/embedded/ssl/certs/cacert.pem`
- Chef Workstation: `/opt/chef-workstation/embedded/ssl/certs/cacert.pem`

To use a custom CA bundle, update the environment variable to specify the path to the custom CA bundle. The first step to troubleshoot a failing SSL certificate is to verify the location of the `SSL_CERT_FILE`.

### client.rb file settings

<!-- markdownlint-disable MD006 MD007 -->

Use following [`client.rb` file]({{< relref "config_rb_client" >}}) settings to manage SSL certificate preferences:

`local_key_generation`
: Whether Chef Infra Server or Chef Infra Client generates the private/public key pair.
  When `true`, Chef Infra Client generates the key pair and then sends the public key to Chef Infra Server.

  Default value: `true`.

`ssl_ca_file`
: The file for the OpenSSL key. Chef Infra Client generates this setting automatically.

`ssl_ca_path`
: The location of the OpenSSL key file. Chef Infra Client generates this setting automatically.

`ssl_client_cert`
: The OpenSSL X.509 certificate for mutual certificate validation. Required for mutual certificate validation on Chef Infra Server.

  Default value: `nil`.

`ssl_client_key`
: The OpenSSL X.509 key used for mutual certificate validation. Required for mutual certificate validation on Chef Infra Server.

  Default value: `nil`.

`ssl_verify_mode`
: Set the verification mode for HTTPS requests. The recommended setting is `:verify_peer`. Depending on your OpenSSL configuration, you may need to set the `ssl_ca_path`.

  Allowed values:

  - Use `:verify_none` to run without validating any SSL certificates.
  - Use `:verify_peer` to validate all SSL certificates, including Chef Infra Server connections, S3 connections, and any HTTPS `remote_file` resource URLs used in a Chef Infra Client run.

  Default value: `:verify_peer`.

`verify_api_cert`
: Verify the SSL certificate on Chef Infra Server.

  If `true`, Chef Infra Client always verifies the SSL certificate. If `false`, Chef Infra Client uses `ssl_verify_mode` to determine if the SSL certificate requires verification.

  Default value: `false`.

<!-- markdownlint-enable MD006 MD007 -->

### knife CLI subcommands

The Chef Infra Client includes two knife commands for managing SSL certificates:

- Use [knife ssl check](https://docs.chef.io/workstation/knife_ssl_check/) to troubleshoot SSL certificate issues.
- Use [knife ssl fetch](https://docs.chef.io/workstation/knife_ssl_fetch/) to pull down a certificate from Chef Infra Server to the `/.chef/trusted_certs` directory on the workstation.

After the workstation has the correct SSL certificate, bootstrap operations from that workstation uses the certificate in the `/.chef/trusted_certs` directory during the bootstrap operation.

#### knife ssl check

Run [`knife ssl check`](https://docs.chef.io/workstation/knife_ssl_check/) to verify the state of the SSL certificate, and then use the response to help troubleshoot any issues.

##### Verified

{{< readfile file="content/reusable/md/workstation/knife_ssl_check_verify_server_config.md" >}}

##### Unverified

{{< readfile file="content/reusable/md/workstation/knife_ssl_check_bad_ssl_certificate.md" >}}

#### knife ssl fetch

Run [`knife ssl fetch`](https://docs.chef.io/workstation/knife_ssl_fetch/) to download the self-signed certificate from Chef Infra Server to the `/.chef/trusted_certs` directory on a workstation.

##### Verify checksums

{{< readfile file="content/reusable/md/workstation/knife_ssl_fetch_verify_certificate.md" >}}
