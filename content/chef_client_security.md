+++
title = "Chef Infra Client Security"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/chef_client_security.html", "/auth.html"]

[menu]
  [menu.infra]
    title = "Chef Infra Client Security"
    identifier = "chef_infra/security/chef_client_security.md Security"
    parent = "chef_infra/security"
    weight = 10
+++
<!-- markdownlint-disable-file MD033 -->

{{% chef-server/chef_auth %}}

## Authentication

{{% chef-server/chef_auth_authentication %}}

### chef-validator

{{< readfile file="content/reusable/md/security_chef_validator.md" >}}

{{< readfile file="content/reusable/md/security_chef_validator_context.md" >}}

## SSL Certificates

{{< warning >}}

The following information applies to on-premises Chef Infra Server and does not apply to Hosted Chef.

{{< /warning >}}

{{% chef-server/server_security_ssl_cert_client %}}

### trusted_certs Directory

Your organization may use a private Certificate Authority (CA) to generate SSL Certificates or they may create self-signed SSL certificates to use on internal networks or during software development and testing.

The `trusted_certs` directory on Chef Workstation and in Chef Infra Client works as a trusted certificate store for all communication in the Chef Infra system. Chef Infra trusts all SSL certificates stored in this directory--including certificates that are not issued by a trusted Certificate Authority (CA).

Place private and self-signed certificates in the `trusted_certs` directory to use them within Chef Infra Client and Workstation tools.

Use the the [chef_client_trusted_certificate]({{< relref "/resources/chef_client_trusted_certificate" >}}) Chef Infra Client resource to manage these certificates continuously.

#### trusted_certs Locations

##### Chef Workstation

When you install Chef Workstation, it creates a `trusted_certs` directory located at:.

- Windows: `C:\.chef\trusted_certs`
- All other systems: `~/.chef/trusted_certs`

##### Chef Infra Client Nodes

When you bootstrap a node, the Chef Infra Client copies the SSL certificates for the Chef Infra Server onto the node. The `trusted_certs` directory on the node is located at:

- Windows: `C:\chef\trusted_certs`
- All other systems: `/etc/chef/trusted_certs`

### SSL_CERT_FILE

Use the `SSL_CERT_FILE` environment variable to specify the location for the SSL certificate authority (CA) bundle for Chef Infra Client.

A value for `SSL_CERT_FILE` is not set by default. Unless updated, the locations in which Chef Infra will look for SSL certificates are:

- Chef Infra Client: `/opt/chef/embedded/ssl/certs/cacert.pem`
- Chef Workstation: `/opt/chef-workstation/embedded/ssl/certs/cacert.pem`

To use a custom CA bundle, update the environment variable to specify the path to the custom CA bundle. The first step to troubleshoot a failing SSL certificate is to verify the location of the `SSL_CERT_FILE`.

### client.rb Settings

Use following client.rb settings to manage SSL certificate preferences:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Setting</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>local_key_generation</code></td>
<td>Whether the Chef Infra Server or Chef Infra Client generates the private/public key pair. When <code>true</code>, Chef Infra Client generates the key pair, and then sends the public key to the Chef Infra Server. Default value: <code>true</code>.</td>
</tr>
<tr>
<td><code>ssl_ca_file</code></td>
<td>The file for the OpenSSL key. Chef Infra Client generates this setting automatically.</td>
</tr>
<tr>
<td><code>ssl_ca_path</code></td>
<td>The location of the OpenSSL key file. Chef Infra Client generates this setting automatically.</td>
</tr>
<tr>
<td><code>ssl_client_cert</code></td>
<td>The OpenSSL X.509 certificate for mutual certificate validation. Required for mutual certificate validation on the Chef Infra Server. Default value: <code>nil</code>.</td>
</tr>
<tr>
<td><code>ssl_client_key</code></td>
<td>The OpenSSL X.509 key used for mutual certificate validation. Required for mutual certificate validation on the Chef Infra Server. Default value: <code>nil</code>.</td>
</tr>
<tr>
<td><p><code>ssl_verify_mode</code></p></td>
<td><p>Set the verification mode for HTTPS requests. The recommended setting is<code>:verify_peer</code>. Depending on your OpenSSL configuration, you may need to set the <code>ssl_ca_path</code>. Default value: <code>:verify_peer</code>.</p>
<ul>
<li>Use <code>:verify_none</code> to run without validating any SSL certificates.</li>
<li>Use <code>:verify_peer</code> to validate all SSL certificates, including the Chef Infra Server connections, S3 connections, and any HTTPS <strong>remote_file</strong> resource URLs used in a Chef Infra Client run.</li>
</ul>
</td>
</tr>
<tr>
<td><code>verify_api_cert</code></td>
<td>Verify the SSL certificate on the Chef Infra Server. Set to <code>true</code>, Chef Infra Client always verifies the SSL certificate. Set to <code>false</code>, Chef Infra Client uses <code>ssl_verify_mode</code> to determine if the SSL certificate requires verification. Default value: <code>false</code>.</td>
</tr>
</tbody>
</table>

### Knife Subcommands

The Chef Infra Client includes two knife commands for managing SSL certificates:

- Use [knife ssl check](/workstation/knife_ssl_check/) to troubleshoot SSL certificate issues
- Use [knife ssl fetch](/workstation/knife_ssl_fetch/) to pull down a certificate from the Chef Infra Server to the `/.chef/trusted_certs` directory on the workstation.

After the workstation has the correct SSL certificate, bootstrap operations from that workstation will use the certificate in the `/.chef/trusted_certs` directory during the bootstrap operation.

#### knife ssl check

Run the `knife ssl check` subcommand to verify the state of the SSL certificate, and then use the response to help troubleshoot issues that may be present.

##### Verified

{{% chef-workstation/knife_ssl_check_verify_server_config %}}

##### Unverified

{{% chef-workstation/knife_ssl_check_bad_ssl_certificate %}}

#### knife ssl fetch

Run the `knife ssl fetch` to download the self-signed certificate from the Chef Infra Server to the `/.chef/trusted_certs` directory on a workstation.

##### Verify Checksums

{{% chef-workstation/knife_ssl_fetch_verify_certificate %}}
