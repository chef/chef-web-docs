+++
title = "k8s_pod resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_pod"
identifier = "inspec/resources/k8s/K8s Pod"
parent = "inspec/resources/k8s"
+++


Use the `k8s_pod` Chef InSpec audit resource to test the configuration of a specific Pod in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_pod(namespace: "NAMESPACE", name: "NAME") do
  #...
end
```

## Parameter

`namespace`
: Namespace of the resource.

## Properties

`uid`
: UID of the Pod.

`name`
: Name of the Pod.

`namespace`
: Namespace of the Pod.

`resource_version`
: Resource version of the Pod.

`kind`
: Resource type of the Pod.

`metadata`
: Metadata for the Pod.

## Examples

### Pod for default namespace must exist

```ruby
 describe k8s_pod(name: 'NAME') do
  it { should exist }
end
```

### Pod for a specified namespace must exist

```ruby
describe k8s_pod(namespace: 'NAMESPACE', name: 'NAME') do
  it { should exist }
end
```
