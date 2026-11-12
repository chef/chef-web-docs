+++
title = "apache resource"
draft = false

platform = "linux"

[menu.inspec_7_0]
    title = "apache"
    identifier = "resources/core/apache.md apache resource"
    parent = "resources/core"
+++

{{< warning >}}

This resource is deprecated and shouldn't be used. It was removed in Chef InSpec 4.0. The documentation below is preserved as a reference. Replacement functionality is available in the [`apache_conf`](/inspec/7.0/resources/core/apache_conf/) resource.

{{< /warning >}}

Use the `apache` Chef InSpec audit resource to test the state of the Apache server on Linux/Unix systems.

## Availability

### Install

This resource was distributed along with Chef InSpec itself.

### Version

This resource first became available in v1.51.15 of InSpec and was removed in version 4.0.

## Syntax

An `apache` Chef InSpec audit resource block declares settings that should be tested:

```ruby
describe apache do
  its('setting_name') { should cmp 'value' }
end
```

where:

- `'setting_name'` is description of the Apache configuration file
- `{ should cmp 'value' }` is the value that's expected

## Properties

- `service`, `conf_dir`, `conf_path`, `user`

## Property Examples

The following examples show how to use this Chef InSpec audit resource.

### Test the service name

```ruby
describe apache do
  its ('service') { should cmp 'apache2' }
end
```

### Test the configuration location

```ruby
describe apache do
  its ('conf_dir') { should cmp '/etc/apache2' }
end
```

### Test the path of the configuration file

```ruby
describe apache do
  its ('conf_path') { should cmp '/etc/apache2/apache2.conf' }
end
```

### Test the apache user

```ruby
describe apache do
  its ('user') { should cmp 'www-data' }
end
```

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}
