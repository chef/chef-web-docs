+++
title = "Chef Infra Client system requirements"
draft = false

[menu]
  [menu.client_19]
    title = "System requirements"
    identifier = "install/chef_system_requirements.md System Requirements"
    parent = "install"
    weight = 15
+++

This page documents system requirements for bootstrapping Chef Infra Client on a node.

## Prerequisites

Before you bootstrap Chef Infra Client on nodes:

1. Install and configure Chef Infra Server
1. Install and configure Chef Workstation on your local computer

## Supported platforms

See the [Chef Infra Client supported platforms](/platforms/#chef-infra-client-support-19) documentation.

## Chef Infra Client requirements

### Memory

Chef Infra Client requires a minimum of 512 MB of RAM during a client run.

### Installation disk space

- Linux: Chef Infra Client stores its binaries in `/hab`, which requires a minimum of 600 MB of disk space.
- Windows: Chef Infra Client stores its binaries in `C:\hab`, which requires a minimum of 2.1 GB of disk space.

### Processor

Chef Infra Client requires a [supported processor](/platforms/#chef-infra-client-support-19). We recommend 1 GHz or faster, but base the processor speed on other system loads.

### Cache storage

Chef Infra Client caches downloaded cookbooks, packages, and other large files to `/var/chef/cache` during a client run. Size this directory generously. Start with 5 GB and tune the size of `/var/chef/cache` as necessary. You can configure this location in a node's [client.rb](/client/19/install/config_rb_client/) file using the `file_cache_path` setting.
