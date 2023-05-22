+++
title = "k8s_config_map resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_config_map"
identifier = "inspec/resources/k8s/K8s Config Map"
parent = "inspec/resources/k8s"
+++

Use the `k8s_config_map` Chef InSpec audit resource to test the configuration of a specific Configuration Maps in a namespace.

## Installation

## Syntax

```ruby
describe k8s_config_maps(namespace: "NAMESPACE", name: "NAME") do
  #...
end
```

## Parameters

`namespace`
: Namespace of the resource.

## Properties

`uid`
: UID of the resource.

`name`
: Name of the resource.

`namespace`
: Namespace of the resource.

`resource_version`
: Resource version of the resource.

`kind`
: Resource type.

`metadata`
: Metadata for the resource.

## Examples

### Configuration map for default namespace must exist

```ruby
 describe k8s_config_map(name: 'NAME') do
  it { should exist }
end
```

### Configuration map for specified namespace must exist

```ruby
describe k8s_config_map(namespace: 'NAMESPACE', name: 'NAME') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
