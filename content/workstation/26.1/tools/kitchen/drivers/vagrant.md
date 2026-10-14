+++
title = "kitchen-vagrant"
description = "Configure the kitchen-vagrant Test Kitchen driver (HashiCorp Vagrant) to test Chef Infra cookbooks on local virtual machines."
aliases = ["/workstation/26.1/tools/kitchen/plugin_kitchen_vagrant/"]

[menu]
  [menu.workstation_26_1]
    title = "kitchen-vagrant"
    identifier = "workstation_26_1/tools/test_kitchen/drivers/vagrant"
    parent = "workstation_26_1/tools/test_kitchen/drivers"
    weight = 90
+++

{{< readfile file="content/workstation/26.1/reusable/md/test_kitchen_driver_vagrant.md" >}}

## Example kitchen.yml

The following example sets `vagrant` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: vagrant
  provider: virtualbox

platforms:
  - name: ubuntu-22.04
  - name: centos-8
```

## Configuration

{{< readfile file="content/workstation/26.1/reusable/md/test_kitchen_driver_vagrant_settings.md" >}}

{{< readfile file="content/workstation/26.1/reusable/md/test_kitchen_driver_vagrant_config.md" >}}
