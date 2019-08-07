+++
title = "Chef Infra Client Overview"
description = "DESCRIPTION"
draft = false

aliases = "/chef_client_overview.html"

[menu]
  [menu.docs]
    title = "Chef Infra Client Overview"
    identifier = "chef_infra/concepts/chef_client_overview.html Chef Infra Client Overview"
    parent = "chef_infra/concepts"
    weight = 30
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/chef_client_overview.rst)

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

For the `chef-client` command line tool, see
[chef-client(executable)](/ctl_chef_client.html) The Chef Infra Client
executable can be run as a daemon.

</div>

<table>
<colgroup>
<col style="width: 19%" />
<col style="width: 80%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><img src="/images/icon_chef_client.svg" class="align-center" width="100" alt="image" /></p></td>
<td><p>{{% chef_client_summary %}}</p>
<p>{{% security_key_pairs_chef_client %}}</p></td>
</tr>
</tbody>
</table>

The Chef Infra Client Run [the-chef-client-run]
=========================

{{% chef_client_run %}}

About why-run Mode
==================

why-run mode is a way to see what Chef Infra Client would have
configured, had an actual Chef Infra Client run occurred. This approach
is similar to the concept of "no-operation" (or "no-op"): decide what
should be done, but then don't actually do anything until it's done
right. This approach to configuration management can help identify where
complexity exists in the system, where inter-dependencies may be
located, and to verify that everything will be configured in the desired
manner.

When why-run mode is enabled, a Chef Infra Client run will occur that
does everything up to the point at which configuration would normally
occur. This includes getting the configuration data, authenticating to
the Chef Infra Server, rebuilding the node object, expanding the
run-list, getting the necessary cookbook files, resetting node
attributes, identifying the resources, and building the resource
collection and does not include mapping each resource to a provider or
configuring any part of the system.

<div class="note" markdown="1">

<div class="admonition-title" markdown="1">

Note

</div>

why-run mode is not a replacement for running cookbooks in a test
environment that mirrors the production environment. Chef uses why-run
mode to learn more about what is going on, but also Kitchen on developer
systems, along with an internal OpenStack cloud and external cloud
providers to test more thoroughly.

</div>

When Chef Infra Client is run in why-run mode, certain assumptions are
made:

-   If the **service** resource cannot find the appropriate command to
    verify the status of a service, why-run mode will assume that the
    command would have been installed by a previous resource and that
    the service would not be running
-   For `not_if` and `only_if` attribute, why-run mode will assume these
    are commands or blocks that are safe to run. These conditions are
    not designed to be used to change the state of the system, but
    rather to help facilitate idempotency for the resource itself. That
    said, it may be possible that these attributes are being used in a
    way that modifies the system state
-   The closer the current state of the system is to the desired state,
    the more useful why-run mode will be. For example, if a full
    run-list is run against a fresh system, that run-list may not be
    completely correct on the first try, but also that run-list will
    produce more output than a smaller run-list

For example, the **service** resource can be used to start a service. If
the action is `:start` and the service is not running, then start the
service (if it is not running) and do nothing (if it is running). What
about a service that is installed from a package? Chef Infra Client
cannot check to see if the service is running until after the package is
installed. A simple question that why-run mode answers is what Chef
Infra Client would say about the state of the service after installing
the package, because service actions often trigger notifications to
other resources. So it can be important to know in advance that any
notifications are being triggered correctly.

For a detailed explanation of the dry-run concept and how it relates to
the why-run mode, see [this blog
post](http://blog.afistfulofservers.net/post/2012/12/21/promises-lies-and-dryrun-mode/).

Authentication
--------------

{{% chef_auth %}}

{{% chef_auth_authentication %}}

chef-validator
--------------

{{% security_chef_validator %}}

{{% security_chef_validator_context %}}

SSL Certificates
================

An SSL certificate is used between the Chef Infra Client and the Chef
Infra Server to ensure that each node has access to the right data.

Signed Headers
--------------

Signed header authentication is used to validate communications between
the Chef Infra Server and any node that is being managed by the Chef
Infra Server. An API client manages each authentication request. A
public and private key pair is used for the authentication itself. The
public key is stored in the database on the Chef Infra Server. The
private key is stored locally on each node and is kept separate from
node data (typically in the `/etc/chef/client.pem` directory). Each
request to the Chef Infra Server by a node must include a request
signature in the HTTP headers. This signature is computed from a hash of
request content and is encrypted using the private key.

During a Chef Infra Client Run
------------------------------

{{% chef_auth_authentication_chef_run %}}

SSL Verification
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

Chef Infra Client includes two knife commands for managing SSL
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
workstation. For example:

{{% knife_ssl_fetch_verify_certificate %}}

**Verify Checksums**

{{% knife_ssl_fetch_verify_certificate %}}

Bootstrap Operations
====================

{{% install_chef_client %}}

{{% chef_client_bootstrap_node %}}

{{% chef_client_bootstrap_stages %}}
