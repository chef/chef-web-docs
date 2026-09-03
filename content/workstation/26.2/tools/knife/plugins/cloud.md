+++
title = "knife cloud plugins"
draft = false

[menu]
  [menu.workstation_26_2]
    title = "Cloud plugins"
    identifier = "workstation_26_2/tools/knife/plugins/plugin_knife.md Cloud Plugins"
    parent = "workstation_26_2/tools/knife/plugins"
    weight = 10
+++
<!-- markdownlint-disable-file MD033 -->

{{< readfile file="content/workstation/26.2/reusable/md/plugin_knife_summary.md" >}}

- The same [common options](/workstation/26.2/tools/knife/common_options/) used by knife
    subcommands can also be used by knife plug-ins
- A knife plugin can make authenticated API requests to the Chef
    server

The following knife plug-ins are maintained by Chef.

## [knife-azure](https://github.com/chef/knife-azure)

{{< readfile file="content/workstation/26.2/reusable/md/knife_azure.md" >}}

## [knife-ec2](https://github.com/chef/knife-ec2)

Amazon EC2 is a web service that provides resizable compute capacity in the cloud, based on preconfigured operating systems and virtual application software using Amazon Machine Images (AMI). The `knife ec2` subcommand is used to manage API-driven cloud servers that are hosted by Amazon EC2.

## [knife-google](https://github.com/chef/knife-google)

Google Compute Engine is a cloud hosting platform that offers scalable and flexible virtual machine computing. The `knife google` subcommand is used to manage API-driven cloud servers that are hosted by Google Compute Engine.

## [knife-openstack](https://github.com/chef/knife-openstack)

The `knife openstack` subcommand is used to manage API-driven cloud servers that are hosted by OpenStack.

## [knife-rackspace](https://github.com/chef/knife-rackspace)

Rackspace is a cloud-driven platform of virtualized servers that provide services for storage and data, platform and networking, and cloud computing. The `knife rackspace` subcommand is used to manage API-driven cloud servers that are hosted by Rackspace cloud services.

## [knife-vcenter](https://github.com/chef/knife-vcenter)

The `knife vcenter` subcommand is used to provision systems with VMware vCenter.

## [knife-vsphere](https://github.com/chef/knife-vsphere)

The `knife vsphere` subcommand is used to provision systems with VMware vSphere.
