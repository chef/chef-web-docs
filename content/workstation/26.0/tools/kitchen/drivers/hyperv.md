+++
title = "kitchen-hyperv"
description = "Configure the kitchen-hyperv Test Kitchen driver (Microsoft Hyper-V) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_26_0]
    title = "kitchen-hyperv"
    identifier = "workstation_26_0/tools/test_kitchen/drivers/hyperv"
    parent = "workstation_26_0/tools/test_kitchen/drivers"
    weight = 70
+++

The `kitchen-hyperv` driver provisions virtual machines on Microsoft Hyper-V. This driver ships with Chef Workstation. Run it on a Windows host that has the Hyper-V role enabled, and specify a parent VHD and a virtual switch in the driver configuration.

## Example kitchen.yml

The following example sets `hyperv` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: hyperv
  parent_vhd_folder: C:\vhd
  parent_vhd_name: ubuntu-22.04.vhdx
  memory_startup_bytes: 2GB

platforms:
  - name: ubuntu-22.04
```

## Configuration

The `kitchen-hyperv` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-hyperv` repository](https://github.com/test-kitchen/kitchen-hyperv).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-hyperv` installed in your Test Kitchen environment.

{{< /note >}}
