+++
title = "yaml resource"
draft = false

platform = "os"

[menu.inspec_5_23]
    title = "yaml"
    identifier = "resources/core/yaml.md yaml resource"
    parent = "resources/core"
+++

Use the `yaml` Chef InSpec audit resource to test configuration data in a Yaml file.

## Availability

### Install

{{< readfile file="content/inspec/5.23/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `yaml` resource block declares the configuration data to be tested. Assume the following Yaml file:

```yaml
name: foo
array:
  - zero
  - one
```

This file can be queried using:

```ruby
describe yaml('filename.yml') do
  its('name') { should eq 'foo' }
  its(['array', 1]) { should eq 'one' }
end
```

where:

- `name` is a configuration setting in a Yaml file
- `should eq 'foo'` tests a value of `name` as read from a Yaml file versus the value declared in the test

Like the `json` resource, the `yaml` resource can read a file, run a command, or accept content inline:

```ruby
describe yaml('config.yaml') do
  its(['driver', 'name']) { should eq 'vagrant' }
end

describe yaml({ command: 'retrieve_data.py --yaml' }) do
  its('state') { should eq 'open' }
end

describe yaml({ content: "\"key1: value1\nkey2: value2\"" }) do
  its('key2') { should cmp 'value2' }
end
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test a kitchen.yml file driver

```ruby
describe yaml('.kitchen.yaml') do
  its(['driver','name']) { should eq('vagrant') }
end
```

## Matchers

{{< readfile file="content/inspec/5.23/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### name

The `name` matcher tests the value of `name` as read from a Yaml file versus the value declared in the test:

```ruby
its('name') { should eq 'foo' }
```
