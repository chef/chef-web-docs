+++
title = "docker_plugin resource"
draft = false

platform = "linux"

[menu.inspec_6_8]
    title = "docker_plugin"
    identifier = "resources/core/docker_plugin.md docker_plugin resource"
    parent = "resources/core"
+++

Use the `docker_plugin` Chef InSpec audit resource to verify a Docker plugin.

## Syntax

A `docker_plugin` resource block declares the plugin:

```ruby
describe docker_plugin('rexray/ebs') do
  it { should exist }
  its('id') { should_not eq '0ac30b93ad40' }
  its('version') { should eq '0.11.1' }
  it { should be_enabled }
end
```

## Resource Parameter Examples

The resource allows you to pass in an plugin id:

```ruby
describe docker_plugin(id: plugin_id) do
  it { should be_enabled }
end
```

## Properties

### id

The `id` property returns the full plugin id:

```ruby
its('id') { should eq '0ac30b93ad40' }
```

### version

The `version` property tests the value of plugin version:

```ruby
its('version') { should eq '0.11.0' }
```

## Examples

### Test a Docker plugin

```ruby
describe docker_plugin('rexray/ebs') do
  it { should exist }
  its('id') { should_not eq '0ac30b93ad40' }
  its('version') { should eq '0.11.1' }
  it { should be_enabled }
end
```

## Matchers

For a full list of available matchers, please visit our [Universal Matchers](/inspec/6.8/reference/matchers/).

### exist

The `exist` matcher tests if the plugin is available on the node:

```ruby
describe docker_plugin('rexray/ebs') do
  it { should exist }
end
```

### enabled

The `be_enabled` matches tests if the plugin is enabled
