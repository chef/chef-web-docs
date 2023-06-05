+++
title = "k8sobject resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "k8sobject"
    identifier = "inspec/resources/k8s/K8s Object"
    parent = "inspec/resources/k8s"
+++


Use the `k8sobject` Chef InSpec audit resource is a generic InSpec resource to test any Kubernetes object.

## Installation

## Syntax

```ruby
describe k8sobject(type: K8s_RESOURCE_TYPE, namespace: NAMESPACE, name: RESOURCE_NAME) do
  #...
end
```

## Parameters

`type`
: type of the K8s resource that is for a query.

`namespace`
: namespace of the resource.

`name`
: Name of the resource.

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

`labels`
: Labels of the resource.

`annotations`
: Annotations of the resource.

## Examples

### Test to ensure kube-system, kube-public, and default namespaces exist

```ruby
describe k8sobject(api: 'v1', type: 'namespaces', name: 'kube-system') do
  it { should exist }
end
```

### Test to ensure kube-system pods exist

```ruby
k8sobject(api: 'v1', type: 'pods', namespace: 'kube-system', labelSelector: 'k8s-app=kube-proxy') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}

### have_label

The `have_label` matcher verifies if the specified key and value are present in the resource lables.

```ruby
it { should have_label('foo', 'bar') }
```

### have_annotation

The `have_annotation` matcher verifies if the specified key and value are present in the resource annotations.

```ruby
it { should have_annotation('foo', 'bar') }
```