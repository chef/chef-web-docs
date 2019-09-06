+++
title = "Install Chef Automate"
draft = false

aliases = "/install_chef_automate.html"

[menu]
  [menu.docs]
    title = "Installation Guide"
    identifier = "legacy/chef_automate_1/getting_started/install_chef_automate.md Installation Guide"
    parent = "legacy/chef_automate_1/getting_started"
    weight = 10
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/install_chef_automate.rst)

<meta name="robots" content="noindex">

{{% chef_automate_mark %}}

{{% EOL_a1 %}}

A Chef Automate installation consists of a minimum of two servers:

-   **Chef server**

    Contains the cookbooks and data used to build, test, and deploy your
    components within Chef Automate and your infrastructure

-   **Chef Automate server**

    Coordinates the process of moving a change through the workflow
    pipeline as well as providing insights and visualizations about your
    Chef Automate cluster

Optional components include:

-   **Push jobs server**

    Runs Push Jobs, which is used to create infrastructure nodes for
    deployment testing and is also needed if you use Push Jobs-based
    build nodes as part of your testing and deployment process

-   **Runners/build nodes**

    Perform the work of running builds, tests, and deployments out of
    Chef Automate. These are only required when using the workflow
    capabilities of Chef Automate

Prerequisites
=============

Chef Automate requires a license from Chef to install. You will receive
an email with a license key valid for 30 days after you complete the
Chef Automate registration. If you would like to continue using Chef
Automate after that period, please contact <span
class="title-ref">awesome@chef.io</span> for a permanent key.

Browser Support
---------------

Chef Automate works best in Google Chrome. Microsoft Internet Explorer
is currently not supported.

Platform Support
----------------

Please see the [platforms topic](/platforms.html#chef-automate) for
details on supported platforms, architectures, and versions for both
Chef Automate servers and runners.

Hardware Requirements
---------------------

Chef Automate deployments have the following hardware requirements:

> <table>
> <colgroup>
> <col style="width: 33%" />
> <col style="width: 22%" />
> <col style="width: 22%" />
> <col style="width: 22%" />
> </colgroup>
> <thead>
> <tr class="header">
> <th>Function</th>
> <th>vCPU</th>
> <th>RAM</th>
> <th>Free disk space (in /var)</th>
> </tr>
> </thead>
> <tbody>
> <tr class="odd">
> <td>Chef Automate server</td>
> <td>4</td>
> <td>16GB*</td>
> <td>80GB</td>
> </tr>
> <tr class="even">
> <td>Chef Server version 12.11.1 or above.</td>
> <td>4</td>
> <td>8GB</td>
> <td>80GB</td>
> </tr>
> <tr class="odd">
> <td>Build nodes/Runners (Optional, but required if you use workflow)</td>
> <td>2</td>
> <td>4GB</td>
> <td>60GB</td>
> </tr>
> </tbody>
> </table>
>
\*If you use your own Elasticsearch cluster instead of the single
Elasticsearch instance provided with Chef Automate, then the Chef
Automate server only requires 8 GB of RAM.

Sudoers
-------

The `/etc/sudoers` file should not contain the line
`Defaults requiretty`, as it will break the
`automate-ctl preflight-check` command. The preflight check uses `sudo`
to inspect the new Automate system. This also applies to files within
the `/etc/sudoers.d` directory.

Node Hostnames and Network Access
---------------------------------

The automated configuration of Chef Automate and Chef servers use the
`hostname` command to determine the visible fully-qualified domain name
(FQDN) of the node. Prior to installation, ensure that `hostname` and
`hostname -f` on each node resolves to a matching, correct FQDN that is
visible to the other nodes in the cluster. If necessary, update the
`/etc/hosts` file on the nodes to ensure that the names resolve.

Disable IPv6 on the host and remove any ip6 settings found in
`/etc/hosts`. The host should also point its name at its own external ip
address in `/etc/hosts`.

The Chef Automate server hostname is also expected to match the hostname
that you will use to work with Chef Automate via its web interface. It
is not currently possible to use the Chef Automate web interface if the
host name used in the URL does not match the one it is configured with.

Chef Automate has the following network and port requirements. At a
minimum the following machines must be able to reach each other:

-   Chef Automate server -\> Chef server
-   Build node/Runner -\> Chef Automate server
-   Build node/Runner -\> Chef server

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 45%" />
<col style="width: 18%" />
<col style="width: 18%" />
</colgroup>
<thead>
<tr class="header">
<th>Ports</th>
<th>Description</th>
<th>Server</th>
<th>State</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>10000-10003</td>
<td>TCP Push Jobs</td>
<td>Chef server</td>
<td>LISTEN</td>
</tr>
<tr class="even">
<td>8989</td>
<td>TCP Delivery Git (SCM)</td>
<td>Chef Automate server</td>
<td>LISTEN</td>
</tr>
<tr class="odd">
<td>443</td>
<td>TCP HTTP Secure</td>
<td>Chef Infra Server, Chef Automate server</td>
<td>LISTEN</td>
</tr>
<tr class="even">
<td>22</td>
<td>TCP SSH</td>
<td>All</td>
<td>LISTEN</td>
</tr>
<tr class="odd">
<td>80</td>
<td>TCP HTTP</td>
<td>Chef Infra Server, Chef Automate server</td>
<td>LISTEN</td>
</tr>
</tbody>
</table>

{{< info >}}

Any build nodes/runners must be accessible from the Chef Automate server
over SSH and they must have a user account configured that has sudo
privileges.

{{< /info >}}

Chef Infra Server Configuration
===============================

Chef Automate associates with a Chef Infra Server for
application/cookbook building and testing, as well as for the proxying
of cluster data from nodes for visualization purposes. Because of the
hardware requirements for both Chef Infra Server and Chef Automate, it
is recommended that Chef Infra Server is installed on a separate node
from Chef Automate server.

If you have an existing Chef Infra Server installation, it is
recommended that you have a separate organization for use with Chef
Automate. This keeps any existing production organizations separate from
the organization used by runners and infrastructure nodes in your Chef
Automate cluster. Instructions for creating a new organization can be
found in the [next
section](/install_chef_automate.html#create-a-user-and-organization-to-manage-your-cluster).

If you already have an existing Chef Infra Server and wish to manage
infrastructure nodes for deployment testing (or want to use Push
Jobs-based build nodes), update it with the [push jobs server
add-on](/install_chef_automate.html#push-jobs-server-installation).

If you don't have an existing Chef Infra Server installed and
configured, follow the initial steps for your desired installation
method ([standalone](/install_server.html#standalone) or [high
availability](/install_server_ha/)) and then proceed to the [next
section](/install_chef_automate.html#create-a-user-and-organization-to-manage-your-cluster)
to create a user and organization for use with Chef Automate.

Create a User and Organization to Manage Your Cluster
-----------------------------------------------------

As noted above, it's a best practice to use a separate organization when
managing nodes in a Chef Automate cluster. Perform the following steps
to create a new administrator user and a new organization for your Chef
Automate cluster:

1.  Create a user named `delivery`, and specify a first name, last name,
    email address, and password. A private key will be generated for
    you, so specify where to save that key using the `--filename` option
    with an absolute path to its intended location.

    > ``` bash
    > sudo chef-server-ctl user-create delivery FIRST_NAME LAST_NAME EMAIL_ADDRESS 'PASSWORD' --filename AUTOMATE_CHEF_USER_KEY
    > ```
    >
    > The path to the key is referenced as `AUTOMATE_CHEF_USER_KEY` in
    > step 4 of [Chef Automate Server Installation and
    > Configuration](/install_chef_automate.html#chef-automate-server-installation-and-configuration).

2.  Create an organization for managing your Chef Automate cluster and
    associate the Chef Automate `delivery` user with it.

    > ``` bash
    > sudo chef-server-ctl org-create AUTOMATE_CHEF_ORG 'org description' --filename ~/AUTOMATE_CHEF_ORG-validator.pem -a delivery
    > ```

    The organization name (denoted by the placeholder
    `AUTOMATE_CHEF_ORG` above) must begin with a lower-case letter or
    digit, may only contain lower-case letters, digits, hyphens, and
    underscores, and must be between 1 and 255 characters. For example:
    `4thcoffee`.

    The full name must begin with a non-white space character and must
    be between 1 and 1023 characters. For example:
    `'Fourth Coffee, Inc.'`.

    The `--association_user` (`-a`) option will associate the `delivery`
    user with the `admins` security group on the Chef Infra Server.

    An RSA private key is generated automatically. This is the
    chef-validator key and should be saved to a safe location. The
    `--filename` option will save the RSA private key to the specified
    absolute path.

> <div class="note" markdown="1">
>
> <div class="admonition-title" markdown="1">
>
> Note
>
> </div>
>
> The `--filename` option is used so that the validator key for your
> organization will not be shown on-screen. The key is not required for
> this process.
>
> </div>

Push Jobs Server Installation (Optional)
----------------------------------------

Chef Automate, through the delivery-truck cookbook, can use Push Jobs to
spin up infrastructure environments for deployment testing and can also
be used to coordinate build jobs across build nodes when using the Push
Jobs-based job dispatch system.

Push jobs server is available as an add-on to Chef Infra Server. If you
only wish to use Push Jobs for deployment testing, you can use runners
and the new job dispatch system in conjunction with Push jobs server.

{{< info >}}

Chef Automate is fully compatible with Push jobs server 1.x and 2.x.
Please use 2.x for new installations. Information about upgrading from
Push jobs server version 1.x to 2.x can be be found
[here](/release_notes_push_jobs.html#upgrading-chef-automate-installation-to-use-push-jobs-server-2-1).

{{< /info >}}

Download the appropriate package for your platform from
<https://downloads.chef.io/push-jobs-server/> and copy it to the Chef
Infra Server. The location that it's been saved to is referred to as
<span class="title-ref">PATH_TO_DOWNLOADED_PACKAGE</span>.

Run the command below on the Chef Infra Server:

``` bash
sudo chef-server-ctl install opscode-push-jobs-server --path PATH_TO_DOWNLOADED_PACKAGE
```

After it has been installed, you must reconfigure it to complete your
setup of Push jobs server.

``` bash
sudo opscode-push-jobs-server-ctl reconfigure
```

Completing Setup
----------------

Run the following command on the Chef Infra Server node to complete
setup and configuration of Chef Infra Server.

``` bash
sudo chef-server-ctl reconfigure
```

Running this `reconfigure` command may trigger a brief restart of your
Chef Infra Server. This will typically fall within the standard retry
window for Chef Infra Clients, so no significant interruption of service
is expected.

Chef Automate Server Installation and Configuration
===================================================

Now that you have your Chef Infra Server set up, install and configure
Chef Automate by doing the following:

{{< info >}}

If you plan to use a private Supermarket with your Chef Automate server,
please make sure it is set up correctly by following the steps in
[Install Private Supermarket](/install_supermarket/).

{{< /info >}}

1.  Download and install the latest stable Chef Automate package for
    your operating system from <https://downloads.chef.io/automate/> on
    the Chef Automate server machine.

    For Debian:

    ``` bash
    sudo dpkg -i PATH_TO_AUTOMATE_SERVER_PACKAGE
    ```

    For Red Hat or CentOS:

    ``` bash
    sudo rpm -Uvh PATH_TO_AUTOMATE_SERVER_PACKAGE
    ```

2.  Before starting the Chef Automate setup process, you're encouraged
    to use the optional `preflight-check` command to uncover common
    environmental problems that may prevent Chef Automate from
    functioning properly. For example, there may be required ports that
    are unavailable, which would have to be rectified prior to setup.

    ``` bash
    sudo automate-ctl preflight-check
    ```

    This triggers a series of validation steps on your system that will
    be sent to stdout as they are run, along with whether they are
    passing or failing. The end of the check will include a report of
    all failures and remediation steps that you can take to fix them.

    {{< info >}}

    As shown in the example above, this command requires root user
    privileges.

    {{< /info >}}

    Please refer to the troubleshooting section for more information
    about the error codes and remediation steps.

3.  Ensure that the Chef Automate license file and the `delivery` user
    key you created earlier in the Chef Infra Server setup are located
    on the Chef Automate server.

4.  Run the `setup` command. This command requires root user privileges.
    Any unsupplied arguments will be prompted for.

    ``` bash
    sudo automate-ctl setup --license AUTOMATE_LICENSE \
                            --key AUTOMATE_CHEF_USER_KEY \
                            --server-url https://CHEF_SERVER_FQDN/organizations/AUTOMATE_CHEF_ORG \
                            --fqdn AUTOMATE_SERVER_FQDN \
                            --enterprise ENTERPRISE_NAME \
                            --supermarket-fqdn SUPERMARKET_FQDN (Optional)
    ```

    All paths called for here should be supplied as the absolute path to
    a file, including the filename.

    `AUTOMATE_LICENSE` is the full path and file name of your Chef
    Automate license file. For example: `/root/automate.license`.

    {{< info >}}

    After your Chef Automate server is successfully setup, this file
    will be copied into the `/var/opt/delivery/license` directory as
    `delivery.license`.

    {{< /info >}}

    `AUTOMATE_CHEF_USER_KEY` is the `delivery` user key that you created
    on your Chef Infra Server. For example: `/root/delivery.pem`.

    The `--server-url` is the URL of your Chef Infra Server, which
    contains the fully-qualified domain name of the Chef Infra Server
    and the name of the organization you created when you created the
    `delivery` user.

    `AUTOMATE_SERVER_FQDN` is the external fully-qualified domain name
    of the Chef Automate server. This is just the name of the system,
    not a URL. For example: `host.4thcoffee.co`.

    `ENTERPRISE_NAME` is the name of your enterprise. For example:
    `4thcoffee_inc`.

    {{< info >}}

    Currently, only one enterprise is allowed in Chef Automate.

    {{< /info >}}

    If you are using a private Supermarket, tell the setup command about
    it by supplying the `--supermarket-fqdn` command line argument:

    ``` none
    --supermarket-fqdn SUPERMARKET_FQDN
    ```

    Because the Supermarket FQDN argument is optional, it will not be
    prompted for when not specified. You must include this option to set
    up the Chef Automate server to interact with a private Supermarket.
    The setup command can be re-run as often as necessary.

    {{% automate_supermarket %}}

Once setup of your Chef Automate server completes, you will be prompted
to apply the configuration. This will apply the configuration changes
and bring services online, or restart them if you've previously run
setup and applied configuration at that time. You can bypass this prompt
by passing in the argument `--configure` to the `setup` command, which
will run it automatically, or pass in `--no-configure` to skip it.

{{< info >}}

Your Chef Automate server will not be available for use until you either
agree to apply the configuration, or manually run
`sudo automate-ctl reconfigure`.

{{< /info >}}

If you've applied the configuration, you will also be prompted to set up
a Chef Automate runner and submit additional information. Alternatively,
you can do so after the setup completes. See the [runner / build
node](#set-up-a-build-node-runner-optional) section of this guide for
detailed steps.

After setup successfully completes and a configuration has been applied,
login credentials are reported in the completion output; however, they
are also saved to `/etc/delivery/ENTERPRISE_NAME-admin-credentials`.

And if you don't have DNS, specify the fully-qualified domain names for
your Chef Infra Server and Chef Automate server in `/etc/hosts`:

> ``` none
> CHEF_SERVER_IP         CHEF_SERVER_FQDN
> AUTOMATE_SERVER_IP     AUTOMATE_SERVER_FQDN
> ```

{{< info >}}

If your environment requires going through a proxy server, please see
[About Proxies](/install_chef_automate.html#about-proxies) for
information on how to configure proxy settings.

{{< /info >}}

For more information about `automate-ctl` and how to use it, see
[automate-ctl (executable)](/ctl_automate_server.html).

Configure node data collection
------------------------------

After you have set up your Chef Infra Server and Chef Automate server,
you must perform some simple configuration steps to visualize node data
in Chef Automate. This process, along with more advanced data
configuration scenarios, is detailed in [Configure Data
Collection](/data_collection/).

Set up a build node/runner (Optional)
-------------------------------------

Chef Automate's workflow engine automatically creates phase jobs as
project code is promoted through the phases of a workflow pipeline.
These phase jobs are dispatched to special nodes, called runners and
build nodes, that automatically execute each job as it is created.

{{% DK2_automate_note %}}

The following steps show how to set up a runner from a Chef Automate
server. While Push Jobs-based build nodes are still supported, the new
SSH-based system using runners is the default job dispatch system and
should be used for any new deployment. For instructions on how to set up
a Push Jobs-based build node, see [Set up a build
node](/setup_build_node/).

1.  If you have an on-premises Supermarket installation, copy the
    Supermarket certificate file to `/etc/delivery/supermarket.crt`.

2.  Run the `install-runner` subcommand.

    {{< important >}}

    The `install-runner` command creates a new file called `job_runner`
    in the `/etc/sudoers.d` directory that gives the runner the
    appropriate `sudo` access. If your runner does not have the
    `#includedir /etc/sudoers.d` directive included in its
    `/etc/sudoers` file, you must put that directive in before you run
    the `install-runner` command. Additionally, the line
    `Defaults requiretty` must not occur in the `/etc/sudoers` file on
    any runner. This will prevent proper installation of runners.

    {{< /important >}}

    {{< info >}}

    You can optionally download the latest ChefDK from
    <https://downloads.chef.io/chefdk/> to specify a local package via
    `--installer`. Doing so is useful if you are in an air-gapped
    environment. Version 0.15.16 or greater of ChefDK is required. The
    download location is referred to below as
    `OPTIONAL_CHEF_DK_PACKAGE_PATH`. This option cannot be used with the
    `--chefdk-version` as the version of the local package will be used.

    {{< /info >}}

    ``` bash
    automate-ctl install-runner RUNNER_FQDN \
                                SSH_USERNAME \
                                [--password OPTIONAL_SSH_OR_SUDO_PASSWORD] \
                                [--installer OPTIONAL_CHEF_DK_PACKAGE_PATH] \
                                [--ssh-identity-file OPTIONAL_SSH_IDENTITY_FILE] \
                                [--chefdk-version VERSION] \
                                [--port SSH_PORT]
    ```

    The `SSH_USERNAME` provided must have `sudo` access on the intended
    runner, and at least one of `--password PASSWORD` or
    `--ssh-identity-file FILE` is required by Chef Automate in order to
    communicate with it.

    If you require a specific version of ChefDK to be downloaded and
    installed on your runners, you can specify it in the
    `--chefdk-version` option. This is useful if your cookbooks are not
    compatible with the Chef Infra Client version that comes with the
    latest version of ChefDK.

    For more `install-runner` usage examples, see
    [install-runner](/ctl_automate_server.html#install-runner), and for
    more information on runners and the SSH-based job dispatch system,
    see [Runners](/runners/).

    {{% chef_automate_build_nodes %}}

    Depending on whether you created runners or build nodes, you can
    view the logs at either
    `/var/log/delivery-ctl/runner-install_$RUNNER_FDQN.log` or
    `/var/log/delivery-ctl/build-node-install_$BUILD_NODE_FDQN.log`.

    Any existing nodes with the same name as your runner's FQDN will be
    overwritten on the Chef Infra Server. This will remove any previous
    run lists or Chef Infra Server configuration on this node. This is
    done in case the hostname was previously being used for something
    else. When calling `install-runner`, it will give you a warning if
    you will overwrite a node before installation begins, which you can
    bypass by passing `--yes`.

{{< info >}}

Certain sensitive files are copied over to a temporary directory on the
build node/runner. In the event of failure after these files have been
copied, the installer will attempt to remove them. If it is unable to do
so, it will provide you with instructions for doing so manually.

{{< /info >}}

{{< info >}}

Setting up a build node or a runner involves a Chef Infra Client run on
the target node. This requires the target node to be able to reach your
installation's Chef Infra Server. Especially in setups that involve
proxies, connectivity issues abound and lead to hard-to-spot errors. One
indicator of not having interacted with the Chef Infra Server is this
output in your Chef Infra Client run (note the "Server Response"
section):

``` none
================================================================================
Chef encountered an error attempting to load the node data for "bldr-1.example"
================================================================================

Authorization Error
-------------------
Your client is not authorized to load the node data (HTTP 403).

Server Response:
----------------
Cannot fetch the contents of the response.
```

{{< /info >}}

About Proxies
-------------

If the Chef Automate setup process is happening in an environment that
is configured to only allow http/https traffic to go through a proxy
server, then some additional steps need to be taken.

The `http_proxy`, `https_proxy` and `no_proxy` environment variables
will need to be set appropriately for the setup process to complete
successfully. These can be set in the environment directly, or added to
a config.rb file (for example, in `/root/.chef/config.rb`).

Any host that needs to make outgoing http or https connections will
require these settings as well. For example, the Chef Automate server
(which makes knife calls to Chef Infra Server) and Chef Infra Server
(for Push Jobs) should have these configured. To update the Chef
Automate server, update `/etc/delivery/delivery.rb` on your Chef
Automate server with the values specified in [Proxy
Settings](/config_rb_delivery.html#proxy-settings). After you have
configured your settings, run `sudo automate-ctl reconfigure`.

For general information on proxy settings, please see [Working with
Proxies](/proxies/).

Compliance
==========

Profiles
--------

Chef Automate contains a compliance profiles asset store that provides
several built-in profiles covering baseline security checks through CIS
benchmarks across multiple operating systems.

> The compliance profiles asset store is enabled by default. You can
> manage your profiles through the [Chef Automate
> API](/api_automate.html) as well as through the Chef Automate UI. See
> [An Overview of Compliance in Chef
> Automate](/chef_automate_compliance.html) for more information on the
> new integrated compliance functionality.

Scanning
--------

Allows nodes to execute infrastructure tests or compliance profiles as
part of a Chef Infra Client runs. For more details, see [Perform a
Compliance Scan in Chef Automate](/perform_compliance_scan/).

Troubleshooting
===============

If you run into issues during during setup or in the use of Chef
Automate, see [Troubleshooting Chef
Automate](/troubleshooting_chef_automate/) for debugging tips and
remediations.

Delivery-truck setup
====================

Delivery-truck is Chef Automate's recommended way of setting up build
cookbooks. See [About the delivery-truck Cookbook](/delivery_truck/)
for directions on how to get started.
