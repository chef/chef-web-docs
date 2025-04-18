+++
title = "System Requirements"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/chef_system_requirements.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "System Requirements"
    identifier = "chef_infra/install/chef_system_requirements.md System Requirements"
    parent = "chef_infra/install"
    weight = 5
+++

Before installing Chef Infra:

- Ensure that each system you will be managing is running a [supported
    platform](/platforms/)
- Ensure that the machine that will run the Chef Infra Server is
    sufficiently powerful
- Ensure that any network and firewall settings are configured
    correctly

Install and configure the Chef Infra Server, then install and configure
Chef Workstation, and then run the bootstrap command from Chef
Workstation to install Chef Infra Client on each node.

## Chef Infra Server

### Hardware requirements

Chef Infra Server has the following hardware requirements:

{{< readfile file="content/server/reusable/md/system_requirements_server_hardware.md" >}}

### Software requirements

Chef Infra Server has the following software requirements:

{{< readfile file="content/server/reusable/md/system_requirements_server_software.md" >}}

## Chef Infra Client

- The recommended amount of RAM available to Chef Infra Client during
    a Chef Infra Client run is 512MB
- The Chef Infra Client binaries are stored in the `/opt/chef`
    directory, which requires a minimum of 200MB of disk space. On
    Windows, the Chef Infra Client binaries can be found in
    `C:\opscode\`, and they require a minimum of 600MB of disk space.
- The processor must be [supported](/platforms/). We recommend
    a 1 gigahertz (GHz) or faster processor, but the processor speed
    should be based on the other system loads.
- Chef Infra Client caches to `/var/chef/cache` during a Chef Infra
    Client run. This is the location in which downloaded cookbooks,
    packages required by those cookbooks, and other large files are
    stored. This directory requires enough space to save all of this
    data and should be generously sized. 5GB is a safe number as a
    starting point, but tune the size of `/var/chef/cache` as necessary.
    This location is tunable in a node's
    [client.rb](/config_rb_client/) file using the
    `file_cache_path` setting.

## Chef Workstation

- 64-bit architecture
- 4 GB of RAM or more
- 2 GB of free disk space
