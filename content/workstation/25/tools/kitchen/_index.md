+++
title = "Test Kitchen"
description = "Test Kitchen tests Chef Infra cookbooks across platforms, cloud providers, and virtualization drivers using a driver plugin architecture."
summary = "Test Chef Infra cookbooks across platforms and cloud providers with Test Kitchen and its supported drivers."
draft = false


[menu]
  [menu.workstation_25]
    title = "About Test Kitchen"
    identifier = "workstation_25/tools/test_kitchen/kitchen.md About Test Kitchen"
    parent = "workstation_25/tools/test_kitchen"
    weight = 10
+++

Use [Test Kitchen](https://kitchen.ci/) to automatically test cookbooks
across any combination of platforms and test suites:

- Test suites are defined in a `kitchen.yml` file. See the
    [configuration](/workstation/25/tools/kitchen/config_yml_kitchen/) documentation for options
    and syntax information.
- Supports cookbook testing across many cloud providers and
    virtualization technologies.
- Uses a comprehensive set of operating system base images from Chef's
    [Bento](https://github.com/chef/bento) project.

The key concepts in Test Kitchen are:

- A platform is the operating system or target environment on which a cookbook is to be tested
- A suite is the Chef Infra Client configuration, a Policyfile or run-list, and (optionally) node attributes
- An instance is the combination of a specific platform and a specific suite, with each instance being assigned an auto generated name
- A driver is the lifecycle that implements the actions associated with a specific instance---create the instance, do what's needed to converge on that instance (such as installing Chef Infra Client, uploading cookbooks, and starting a Chef Infra Client run), setup anything else needed for testing, verify one (or more) suites post-converge, and then destroy that instance
- A provisioner is the component on which the Chef Infra Client code will be run, either using chef-zero or chef-solo with the `chef_zero` and `chef_solo` provisioners, respectively

## Test Kitchen and Omnitruck API support

Chef has deprecated the Omnitruck API used to download Chef Infra Client.
When the Omnitruck API reaches end of life, any version of Test Kitchen earlier than 4.0.0 will stop working.

## Progress Chef license support

Test Kitchen 4 and later supports authenticated downloads from the Chef commercial downloads API using a Progress Chef license key.
You must provide your license key using one of the following methods:

- Set [`chef_license_key` in your `kitchen.yml` file](config_yml_kitchen#provisioner-settings)
- Set the `CHEF_LICENSE_KEY` environment variable on the machine running Test Kitchen

For more information, see the [Chef licensing documentation](/licensing/).

## Bento

{{< readfile file="content/workstation/25/reusable/md/bento.md" >}}

## Drivers

{{< readfile file="content/workstation/25/reusable/md/test_kitchen_drivers.md" >}}

## Validation with Chef InSpec

Test Kitchen will create a VM or cloud instance, install Chef Infra
Client to that system, and converge Chef Infra Client with your local
cookbook. Once this is complete, you will want to perform automated
validation against the infrastructure you have built to validate its
configuration. Test Kitchen allows you to run Chef InSpec tests against your
converged cookbook for easy local validation of your infrastructure.

## kitchen (executable)

{{< readfile file="content/workstation/25/reusable/md/ctl_kitchen_summary.md" >}}

{{< note >}}

For more information about the `kitchen` command line tool, see
[kitchen](/workstation/25/tools/kitchen/ctl_kitchen/).

{{< /note >}}

## kitchen.yml

{{< readfile file="content/workstation/25/reusable/md/test_kitchen_yml.md" >}}

{{< note >}}

For more information about the `kitchen.yml` file, see
[kitchen.yml](/workstation/25/tools/kitchen/config_yml_kitchen/).

{{< /note >}}

### Syntax

{{< readfile file="content/workstation/25/reusable/md/test_kitchen_yml_syntax.md" >}}

### Work with proxies

{{< readfile file="content/workstation/25/reusable/md/test_kitchen_yml_syntax_proxy.md" >}}

## Additional information

For more information about test-driven development and Test Kitchen, see the kitchen.ci website:

- [kitchen.ci](https://kitchen.ci/)
- [Getting Started with Test Kitchen](https://kitchen.ci/docs/getting-started/introduction/)
