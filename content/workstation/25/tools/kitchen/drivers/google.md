+++
title = "kitchen-google"
description = "Configure the kitchen-google Test Kitchen driver (Google Compute Engine) to test Chef Infra cookbooks."

[menu]
  [menu.workstation_25]
    title = "kitchen-google"
    identifier = "workstation_25/tools/test_kitchen/drivers/google"
    parent = "workstation_25/tools/test_kitchen/drivers"
    weight = 60
+++

The `kitchen-google` driver provisions instances on Google Compute Engine (GCE). This driver ships with Chef Workstation. Authenticate with the Google Cloud SDK application default credentials, then set the project and zone in the driver configuration. The driver name in `kitchen.yml` is `gce`.

## Example kitchen.yml

The following example sets `gce` as the driver in a `kitchen.yml` file:

```yaml
driver:
  name: gce
  project: <gcp-project-id>
  zone: us-central1-a

platforms:
  - name: ubuntu-2204
    driver:
      image_project: ubuntu-os-cloud
      image_family: ubuntu-2204-lts
```

## Configuration

The `kitchen-google` driver provides configuration options that you set in the `driver` section of your `kitchen.yml` file, either globally or for an individual platform.
For the complete and current list of settings, see the [`kitchen-google` repository](https://github.com/test-kitchen/kitchen-google).

{{< note >}}

The upstream driver documentation can lag behind the driver code.
Verify the configuration options against the version of `kitchen-google` installed in your Test Kitchen environment.

{{< /note >}}
