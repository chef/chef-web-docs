+++
title = "knife ssl check"
draft = false



[menu]
  [menu.workstation_26_1]
    title = "knife ssl_check"
    identifier = "workstation_26_1/tools/knife/reference/knife_ssl_check.md knife ssl_check"
    parent = "workstation_26_1/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD036 -->

{{< readfile file="content/workstation/26.1/reusable/md/knife_ssl_check_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife ssl check (options)
```

## Options

This subcommand has the following options:

`URL_or_URI`

: The URL or URI for the location at which the SSL certificate is located. Default value: the URL of Chef Infra Server, as defined in the `config.rb` file.

## Examples

The following examples show how to use this knife subcommand:

**SSL certificate has valid X.509 properties**

If the SSL certificate can be verified, the response to

```bash
knife ssl check
```

is similar to:

```bash
Connecting to host chef-server.example.com:443
Successfully verified certificates from 'chef-server.example.com'
```

**SSL certificate has invalid X.509 properties**

If the SSL certificate can't be verified, the response to

```bash
knife ssl check
```

is similar to:

```bash
Connecting to host chef-server.example.com:443
ERROR: The SSL certificate of chef-server.example.com could not be verified
Certificate issuer data:
  /C=US/ST=WA/L=S/O=Corp/OU=Ops/CN=chef-server.example.com/emailAddress=you@example.com

Configuration Info:

OpenSSL Configuration:
* Version: OpenSSL 1.0.2u  20 Dec 2019
* Certificate file: /opt/chef-workstation/embedded/ssl/cert.pem
* Certificate directory: /opt/chef-workstation/embedded/ssl/certs
Chef SSL Configuration:
* ssl_ca_path: nil
* ssl_ca_file: nil
* trusted_certs_dir: "/Users/grantmc/Downloads/chef-repo/.chef/trusted_certs"

TO FIX THIS ERROR:

If the server you are connecting to uses a self-signed certificate,
you must configure chef to trust that certificate.

By default, the certificate is stored in the following location on the
host where your Chef Infra Server runs:

  /var/opt/opscode/nginx/ca/SERVER_HOSTNAME.crt

Copy that file to your trusted_certs_dir (currently:

  /Users/grantmc/Downloads/chef-repo/.chef/trusted_certs)

using SSH/SCP or some other secure method, then re-run this command to
confirm that the certificate is now trusted.
```

**Verify the SSL configuration for Chef Infra Client**

The SSL certificates that are used by Chef Infra Client may be verified
by specifying the path to the `client.rb` file. Use the `--config` option
(that's available to any knife command) to specify this path:

```bash
knife ssl check --config /etc/chef/client.rb
```

**Verify an external server's SSL certificate**

```bash
knife ssl check URL_or_URI
```

for example:

```bash
knife ssl check https://www.chef.io
```
