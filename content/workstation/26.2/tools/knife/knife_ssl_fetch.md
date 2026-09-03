+++
title = "knife ssl_fetch"
draft = false



[menu]
  [menu.workstation_26_2]
    title = "knife ssl_fetch"
    identifier = "workstation_26_2/tools/knife/reference/knife_ssl_fetch.md knife ssl_fetch"
    parent = "workstation_26_2/tools/knife/reference"
+++
<!-- markdownlint-disable-file MD036 -->

{{< readfile file="content/workstation/26.2/reusable/md/knife_ssl_fetch_summary.md" >}}

## Syntax

This subcommand has the following syntax:

```bash
knife ssl fetch (options)
```

## Options

This subcommand has the following options:

`URL_or_URI`

: The URL or URI for the location at which the SSL certificate is located. Default value: the URL of Chef Infra Server, as defined in the `config.rb` file.

## Examples

The following examples show how to use this knife subcommand:

**Fetch the SSL certificates used by knife from the Chef Infra Server**

```bash
knife ssl fetch
```

The response is similar to:

```bash
WARNING: Certificates from <chef_server_url> will be fetched and placed in your trusted_cert
directory (/Users/grantmc/chef-repo/.chef/trusted_certs).

knife has no means to verify these are the correct certificates. You should
verify the authenticity of these certificates after downloading.

Adding certificate for <chef_server_url> in /Users/grantmc/chef-repo/.chef/trusted_certs/grantmc.crt
Adding certificate for DigiCert Secure Server CA in /Users/grantmc/chef-repo/.chef/trusted_certs/DigiCert_Secure_Server_CA.crt
```

**Fetch SSL certificates from a URL or URI**

```bash
knife ssl fetch https://www.example.com
```

**Verify Checksums**

The SSL certificate that's downloaded to the `/.chef/trusted_certs`
directory should be verified to ensure that it's, in fact, the same
certificate as the one located on Chef Infra Server. This can be
done by comparing the SHA-256 checksums.

1. View the checksum on Chef Infra Server:

    ```bash
    ssh ubuntu@chef-server.example.com sudo sha256sum /var/opt/opscode/nginx/ca/chef-server.example.com.crt
    ```

    The response is similar to:

    ```bash
    <ABC123checksum>  /var/opt/opscode/nginx/ca/chef-server.example.com.crt
    ```

2. View the checksum on the workstation:

    ```bash
    gsha256sum .chef/trusted_certs/chef-server.example.com.crt
    ```

    The response is similar to:

    ```bash
    <ABC123checksum>  .chef/trusted_certs/chef-server.example.com.crt
    ```

3. Verify that the checksum values are identical.
