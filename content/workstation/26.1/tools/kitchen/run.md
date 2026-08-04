+++
title = "Run Test Kitchen"
linkTitle = "Using Test Kitchen"

[menu.workstation_26_1]
title = "Run Test Kitchen"
identifier = "workstation_26_1/tools/test_kitchen/using_test_kitchen"
parent = "workstation_26_1/tools/test_kitchen"
weight = 40
+++

<!--

For the Chef Infra Client release, Chef Test Kitchen Enterprise only supports the kitchen-dokken driver.
This allows us to create containers, using Podman or Docker Desktop, of various realistic operating systems and configure Chef Infra Client 19 for converge and verify operations.
By default, this driver uses the chef/chef-hab container volume from Docker Hub to attach the Chef Infra Client 19 and Chef InSpec 7 (the default verifier) to the test container.

-->

## Example `kitchen.yaml` for Chef Infra Client 19

The following `kitchen.yaml` file example defines tests that run in Chef Infra Client 19:

```yaml
---
driver:
  name: dokken
  privileged: true
  chef_version: 19.2.12

provisioner:
  name: dokken

transport:
  name: dokken

verifier:
  name: inspec

platforms:
  - name: ubuntu-20.04
  - name: centos-8

suites:
  - name: default
    run_list:
      - "cookbook"
    verifier:
      inspec_tests:
        - test/integration/default
```

## Provision earlier versions of Chef Infra Client

To provision containers to use Chef Infra Client version 18 or earlier, modify the driver configuration in the `kitchen.yml` file as shown below.
Set `chef_image` to `chef/chef` and set the version of Infra Client in `chef_version`.

```yaml
driver:
  name: dokken
  privileged: true
  chef_version: 18.3.0
  chef_image: "chef/chef"
```

## Run converge and verify tests

The [Test Kitchen documentation](https://kitchen.ci/docs/getting-started/creating-cookbook/) describes the process for creating converge and verify tests. The Dokken driver documentation is in the [kitchen-dokken GitHub repository](https://github.com/chef/kitchen-dokken).

## Habitat-based changes

The Chef Infra Client 19 and above is accessible using Habitat instead of the public Omnitruck APIs. Consequently, we've updated the provisioner to facilitate the installation of the Habitat-based Chef Infra Client, including passing through the license required from `kitchen.yml` file.
