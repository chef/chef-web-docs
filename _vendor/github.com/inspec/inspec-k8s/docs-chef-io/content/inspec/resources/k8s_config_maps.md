+++
title = "k8s_config_maps resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_config_maps"
identifier = "inspec/resources/k8s/K8s Config Maps"
parent = "inspec/resources/k8s"
+++


Use the `k8s_config_maps` Chef InSpec audit resource to test all the Configuration Maps in a namespace.

## Installation

## Syntax

```ruby
describe k8s_config_maps do
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

### Configuration maps for default namespace must exist

```ruby
 describe k8s_config_maps do
  it { should exist }
end
```

### Configuration maps must exists for specified namespace

```ruby
describe k8s_config_maps(namespace: 'kube-system') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
