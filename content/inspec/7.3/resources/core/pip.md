+++
title = "pip resource"
draft = false

platform = "os"

[menu.inspec_7_3]
    title = "pip"
    identifier = "resources/core/pip.md pip resource"
    parent = "resources/core"
+++

Use the `pip` Chef InSpec audit resource to test packages that are installed using the Python PIP installer.

## Availability

### Install

{{< readfile file="content/inspec/7.3/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `pip` resource block declares a package and (optionally) a package version:

```ruby
describe pip('package_name') do
  it { should be_installed }
end
```

where:

- `'package_name'` is the name of the package, such as `'Jinja2'`
- `be_installed` tests to see if the package described above is installed

## Properties

### version

The `version` property tests if the named package version is on the system:

```ruby
its('version') { should eq '1.2.3' }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Test if Jinja2 is installed on the system

```ruby
describe pip('Jinja2') do
  it { should be_installed }
end
```

### Test if Jinja2 2.8 is installed on the system

```ruby
describe pip('Jinja2') do
  it { should be_installed }
  its('version') { should eq '2.8' }
end
```

### Test packages installed into a non-default location (for example, virtualenv) by passing a custom path to pip executable

```ruby
describe pip('Jinja2', '/path/to/bin/pip') do
  it { should be_installed }
  its('version') { should eq '2.8' }
end
```

## Matchers

{{< readfile file="content/inspec/7.3/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_installed

The `be_installed` matcher tests if the named package is installed on the system:

```ruby
it { should be_installed }
```
