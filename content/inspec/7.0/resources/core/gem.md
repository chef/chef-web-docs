+++
title = "gem resource"
draft = false

platform = "os"

[menu.inspec_7_0]
    title = "gem"
    identifier = "resources/core/gem.md gem resource"
    parent = "resources/core"
+++

Use the `gem` Chef InSpec audit resource to test if a global Gem package is installed.

## Availability

### Install

{{< readfile file="content/inspec/7.0/reusable/md/inspec_installation.md" >}}

### Version

This resource first became available in v1.0.0 of InSpec.

## Syntax

A `gem` resource block declares a package and (optionally) a package version:

```ruby
describe gem('gem_package_name', 'gem_binary') do
  it { should be_installed }
end
```

where:

- `('gem_package_name')` must specify a Gem package, such as `'rubocop'`
- `('gem_binary')` can specify the path to a non-default gem binary, defaults to `'gem'`
- `be_installed` is a valid matcher for this resource

## Properties

### `version (String)`

The `version` property returns a string of the default version on the system:

```ruby
its('version') { should eq '0.33.0' }
```

### `versions`

The `versions` property returns an array of strings of all the versions of the gem installed on the system:

```ruby
its('versions') { should include /0.33/ }
```

## Examples

The following examples show how to use this Chef InSpec audit resource.

### Verify that a gem package is installed, with a specific version

```ruby
describe gem('rubocop') do
  it { should be_installed }
  its('version') { should eq '1.22.0' }
end
```

### Verify that a particular version is installed when there are multiple versions installed

```ruby
describe gem('rubocop') do
  it { should be_installed }
  its('versions') { should include /1.21.0/ }
  its('versions.count') { should_not be > 3 }
end
```

### Verify that a gem package isn't installed

```ruby
describe gem('rubocop') do
  it { should_not be_installed }
end
```

### Verify that a gem package is installed in an omnibus environment

```ruby
describe gem('pry', '/opt/ruby-3.0.2/embedded/bin/gem') do
  it { should be_installed }
end
```

### Verify that a gem package is installed in a chef omnibus environment

```ruby
describe gem('chef-sugar', :chef) do
  it { should be_installed }
end
```

### Verify that a gem package is installed in a chef-server omnibus environment

```ruby
describe gem('knife-backup', :chef_server) do
  it { should be_installed }
end
```

## Matchers

{{< readfile file="content/inspec/7.0/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### be_installed

The `be_installed` matcher tests if the named Gem package is installed:

```ruby
it { should be_installed }
```
