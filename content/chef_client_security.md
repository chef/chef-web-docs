+++
title = "Chef Infra Client Security"
description = "DESCRIPTION"
draft = false

aliases = "/chef_client_security.html"

[menu]
  [menu.docs]
    title = "Security"
    identifier = "chef_infra/setup/nodes/chef_client_security.html Security"
    parent = "chef_infra/setup/nodes"
    weight = 70
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_client_security.rst)

{{% chef_auth %}}

Authentication
==============

{{% chef_auth_authentication %}}

chef-validator
--------------

{{% security_chef_validator %}}

During a Chef Infra Client Run
------------------------------

{{% chef_auth_authentication_chef_run %}}

authentication_protocol_version
---------------------------------

The `authentication_protocol_version` option in the `client.rb` file is
used to determine the authentication protocol that communicates with
Chef Infra Server. For example, specify protocol version 1.3 to enable
support for SHA-256 algorithms:

> ``` ruby
> knife[:authentication_protocol_version] = '1.3'
> ```

Note that authentication protocol 1.3 is only supported on Chef Server
versions 12.4.0 and above.

SSL Certificates
================

<div class="warning" markdown="1">

<div class="admonition-title" markdown="1">

Warning

</div>

The following information does not apply to hosted Chef Server 12, only
to on-premises Chef Server 12.

</div>

{{% server_security_ssl_cert_client %}}

`/.chef/trusted_certs`
----------------------

{{% chef_repo_directory_trusted_certs %}}

SSL_CERT_FILE
---------------

{{% environment_variables_ssl_cert_file %}}

client.rb Settings
------------------

{{% chef_client_ssl_config_settings %}}

Knife Subcommands
-----------------

The Chef Infra Client includes two knife commands for managing SSL
certificates:

-   Use [knife ssl check](/knife_ssl_check/) to troubleshoot SSL
    certificate issues
-   Use [knife ssl fetch](/knife_ssl_fetch/) to pull down a
    certificate from the Chef Infra Server to the `/.chef/trusted_certs`
    directory on the workstation.

After the workstation has the correct SSL certificate, bootstrap
operations from that workstation will use the certificate in the
`/.chef/trusted_certs` directory during the bootstrap operation.

### knife ssl check

Run the `knife ssl check` subcommand to verify the state of the SSL
certificate, and then use the reponse to help troubleshoot issues that
may be present.

**Verified**

{{% knife_ssl_check_verify_server_config %}}

**Unverified**

{{% knife_ssl_check_bad_ssl_certificate %}}

### knife ssl fetch

Run the `knife ssl fetch` to download the self-signed certificate from
the Chef Infra Server to the `/.chef/trusted_certs` directory on a
workstation.

**Verify Checksums**

{{% knife_ssl_fetch_verify_certificate %}}
