+++
title = "kitchen-digitalocean"
description = "Configure the kitchen-digitalocean Test Kitchen driver (DigitalOcean) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_26_0]
    title = "kitchen-digitalocean"
    identifier = "workstation_26_0/tools/test_kitchen/drivers/digitalocean"
    parent = "workstation_26_0/tools/test_kitchen/drivers"
    weight = 30
+++

The `kitchen-digitalocean` driver provisions droplets on DigitalOcean. This driver ships with Chef Workstation. Set the `DIGITALOCEAN_ACCESS_TOKEN` and `DIGITALOCEAN_SSH_KEY_IDS` environment variables to authenticate.

## Example kitchen.yml

The following example sets `digitalocean` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: digitalocean

platforms:
  - name: ubuntu-22-04
  - name: rockylinux-9
```

## Configuration

The `kitchen-digitalocean` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-digitalocean` repository](https://github.com/test-kitchen/kitchen-digitalocean).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-digitalocean` installed in your Test Kitchen environment.

{{< /note >}}
