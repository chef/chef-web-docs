+++
title = "System requirements"
draft = false

[menu]
  [menu.client_18]
    title = "System requirements"
    identifier = "install/chef_system_requirements.md System Requirements"
    parent = "install"
    weight = 5
+++

## Prerequisites

Before you bootstrap Chef Infra Client on nodes:

1. Install and configure Chef Infra Server
1. Install and configure Chef Workstation on your local computer

## Chef Infra Client requirements

Chef Infra Client requires the following system resources and disk space.

### Memory

- We recommend at least 512 MB of available RAM during a Chef Infra Client run.

### Installation disk space

- On Linux, Chef Infra Client installs binaries in `/opt/chef` and requires at least 200 MB of available disk space.
- On Windows, Chef Infra Client installs binaries in `C:\opscode\` and requires at least 600 MB of available disk space.

### Processor

- See the [supported platforms and processors documentation](/platforms/#chef-infra-client-support-18).
- We recommend a processor speed of 1 GHz or faster, although actual requirements depend on system workload and the resources available to Chef Infra Client.

### Cache storage

During a run, Chef Infra Client stores downloaded cookbooks, packages, and other temporary files in the cache directory:

- Linux: `/var/chef/cache`
- Windows: Configured by the `file_cache_path` setting

Ensure that the cache directory has sufficient free space for downloaded content and temporary files. We recommend starting with 5 GB of available disk space and increasing it as needed for your environment.

You can change the cache directory location by configuring the `file_cache_path` setting in `client.rb`.