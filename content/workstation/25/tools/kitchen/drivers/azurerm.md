+++
title = "kitchen-azurerm"
description = "Configure the kitchen-azurerm Test Kitchen driver (Microsoft Azure) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_25]
    title = "kitchen-azurerm"
    identifier = "workstation_25/tools/test_kitchen/drivers/azurerm"
    parent = "workstation_25/tools/test_kitchen/drivers"
    weight = 20
+++

The `kitchen-azurerm` driver provisions virtual machines on Microsoft Azure using the Azure Resource Manager API. Authenticate with the Azure CLI or a service principal, then set your subscription and location in the driver configuration.

## Example kitchen.yml

The following example sets `azurerm` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: azurerm
  subscription_id: <azure-subscription-id>
  location: eastus
  machine_size: Standard_D2s_v3

platforms:
  - name: ubuntu-2204
    driver:
      image_urn: Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest
```

## Configuration

The `kitchen-azurerm` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-azurerm` repository](https://github.com/test-kitchen/kitchen-azurerm).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-azurerm` installed in your Test Kitchen environment.

{{< /note >}}
