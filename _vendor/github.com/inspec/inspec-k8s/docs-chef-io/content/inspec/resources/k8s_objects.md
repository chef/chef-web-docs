+++
title = "k8sobjects resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8sobjects"
identifier = "inspec/resources/k8s/K8s Objects"
parent = "inspec/resources/k8s"
+++


Use the `k8sobjects` Chef InSpec audit resource to test the configuration of all K8s resources.

## Installation

## Syntax

```ruby
describe k8sobjects(type: K8s_RESOURCE_TYPE, namespace: NAMESPACE, name: RESOURCE_NAME) do
  #...
end
```

## Parameters

`type`
: type of the K8s resource that is for a query.

`namespace`
: namespace of the resource.

## Properties

`uids`
: UID of the resource.

`names`
: Name of the resource.

`namespaces`
: Namespace of the resource.

`resource_versions`
: Resource version of the resource.

`kinds`
: Resource type.

`metadatas`
: Metadata for the resource.

## Examples

### Test to ensure kube-system, kube-public, and default namespaces exist

```ruby
 describe k8sobjects(api: 'v1', type: 'namespaces', name: 'kube-system') do
  it { should exist }
end
```

### Test to ensure kube-system pods exist

```ruby
k8sobjects(api: 'v1', type: 'pods', namespace: 'kube-system', labelSelector: 'k8s-app=kube-proxy') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
