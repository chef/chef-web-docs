+++
title = "kitchen-dokken"
description = "Configure the kitchen-dokken Test Kitchen driver (Docker (Dokken)) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_26_0]
    title = "kitchen-dokken"
    identifier = "workstation_26_0/tools/test_kitchen/drivers/dokken"
    parent = "workstation_26_0/tools/test_kitchen/drivers"
    weight = 40
+++

The `kitchen-dokken` driver uses Docker with prebuilt Linux and Chef Infra Client images to run fast cookbook tests. This driver ships with Chef Workstation. It combines the driver, transport, and provisioner into a single plugin, so set `dokken` in all three sections of your `kitchen.yml` file.

## Example kitchen.yml

The following example sets `dokken` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: dokken
  privileged: true

provisioner:
  name: dokken

transport:
  name: dokken

platforms:
  - name: ubuntu-22.04
    driver:
      image: dokken/ubuntu-22.04
```

## Configuration

The `kitchen-dokken` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-dokken` repository](https://github.com/test-kitchen/kitchen-dokken).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-dokken` installed in your Test Kitchen environment.

{{< /note >}}
