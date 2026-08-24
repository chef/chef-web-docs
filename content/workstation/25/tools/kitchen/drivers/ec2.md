+++
title = "kitchen-ec2"
description = "Configure the kitchen-ec2 Test Kitchen driver (Amazon EC2) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_25]
    title = "kitchen-ec2"
    identifier = "workstation_25/tools/test_kitchen/drivers/ec2"
    parent = "workstation_25/tools/test_kitchen/drivers"
    weight = 50
+++

The `kitchen-ec2` driver provisions instances on Amazon Elastic Compute Cloud (EC2). This driver ships with Chef Workstation. Provide AWS credentials through the standard AWS SDK credential chain---environment variables, shared credential files, or an IAM instance profile---rather than storing them in the `kitchen.yml` file.

## Example kitchen.yml

The following example sets `ec2` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: ec2
  region: us-east-1
  instance_type: t3.medium

platforms:
  - name: ubuntu-22.04
```

## Configuration

The `kitchen-ec2` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-ec2` repository](https://github.com/test-kitchen/kitchen-ec2).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-ec2` installed in your Test Kitchen environment.

{{< /note >}}
