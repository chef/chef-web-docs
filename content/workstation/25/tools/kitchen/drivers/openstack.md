+++
title = "kitchen-openstack"
description = "Configure the kitchen-openstack Test Kitchen driver (OpenStack) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_25]
    title = "kitchen-openstack"
    identifier = "workstation_25/tools/test_kitchen/drivers/openstack"
    parent = "workstation_25/tools/test_kitchen/drivers"
    weight = 80
+++

The `kitchen-openstack` driver provisions instances on an OpenStack cloud. This driver ships with Chef Workstation. Provide your OpenStack authentication details---such as the authentication URL, username, password, and project---in the driver configuration or through the standard OpenStack environment variables.

## Example kitchen.yml

The following example sets `openstack` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: openstack
  openstack_auth_url: https://openstack.example.com:5000/v3
  openstack_username: <username>
  openstack_api_key: <password>
  flavor_ref: m1.medium

platforms:
  - name: ubuntu-22.04
```

## Configuration

The `kitchen-openstack` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-openstack` repository](https://github.com/test-kitchen/kitchen-openstack).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-openstack` installed in your Test Kitchen environment.

{{< /note >}}
