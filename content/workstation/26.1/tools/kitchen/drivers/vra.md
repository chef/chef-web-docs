+++
title = "kitchen-vra"
description = "Configure the kitchen-vra Test Kitchen driver (VMware vRealize Automation) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_26_1]
    title = "kitchen-vra"
    identifier = "workstation_26_1/tools/test_kitchen/drivers/vra"
    parent = "workstation_26_1/tools/test_kitchen/drivers"
    weight = 110
+++

The `kitchen-vra` driver provisions machines through VMware vRealize Automation (vRA). Provide the vRA server, credentials, and the catalog item to request in the driver configuration.

## Example kitchen.yml

The following example sets `vra` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: vra
  username: <username>
  password: <password>
  base_url: https://vra.example.com
  catalog_id: <catalog-item-id>

platforms:
  - name: ubuntu-22.04
```

## Configuration

The `kitchen-vra` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-vra` repository](https://github.com/test-kitchen/kitchen-vra).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-vra` installed in your Test Kitchen environment.

{{< /note >}}
