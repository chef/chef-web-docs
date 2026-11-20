+++
title = "kitchen-vcenter"
description = "Configure the kitchen-vcenter Test Kitchen driver (VMware vCenter) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_26_0]
    title = "kitchen-vcenter"
    identifier = "workstation_26_0/tools/test_kitchen/drivers/vcenter"
    parent = "workstation_26_0/tools/test_kitchen/drivers"
    weight = 100
+++

The `kitchen-vcenter` driver provisions virtual machines on VMware vCenter. Chef maintains this driver. Provide the vCenter host, credentials, datacenter, and a template to clone in the driver configuration.

## Example kitchen.yml

The following example sets `vcenter` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: vcenter
  vcenter_username: <username>
  vcenter_password: <password>
  vcenter_host: vcenter.example.com
  datacenter: Datacenter

platforms:
  - name: ubuntu-22.04
    driver:
      template: ubuntu-22.04-template
```

## Configuration

The `kitchen-vcenter` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-vcenter` repository](https://github.com/chef/kitchen-vcenter).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-vcenter` installed in your Test Kitchen environment.

{{< /note >}}
