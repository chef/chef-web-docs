+++
title = "System requirements"
draft = false

[menu]
  [menu.install]
    title = "System requirements"
    identifier = "install/chef_system_requirements.md System Requirements"
    parent = "install"
    weight = 15
+++

Before you bootstrap Chef Infra Client on nodes:

1. Install and configure Chef Infra Server
1. Install and configure Chef Workstation on your local computer

## Supported platforms

Chef Infra Client is supported on:

- Currently supported Linux distributions and versions running Linux kernel 2.6.32 and later
- Currently supported Windows versions greater than or equal to Windows 10

## Chef Infra Client requirements

- **RAM**: Chef Infra Client requires a minimum of 512 MB of RAM during a client run.
- **Disk space for binaries**:
  - Linux: The Chef Infra Client binaries are stored in `/hab` and require a minimum of 600 MB of disk space.
  - Windows: The Chef Infra Client binaries are stored in `C:\hab` and require a minimum of 2.1 GB of disk space.
- **Processor**: The processor must be supported. We recommend 1 GHz or faster, but the processor speed should be based on other system loads.
- **Cache directory**: Chef Infra Client caches downloaded cookbooks, packages, and other large files to `/var/chef/cache` during a client run. This directory should be generously sized. Start with 5 GB and tune the size of `/var/chef/cache` as necessary. You can configure this location in a node's [client.rb](/install/config_rb_client/) file using the `file_cache_path` setting.
