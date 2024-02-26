+++
title = "k8s_namespace resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_namespace"
identifier = "inspec/resources/k8s/K8s Namespace"
parent = "inspec/resources/k8s"
+++

Use the `k8s_namespace` Chef InSpec audit resource to test the configuration of a specific namespace.

## Installation

## Syntax

```ruby
describe k8s_namespace(name: 'default') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the namespace.

## Properties

`uid`
: UID of the namespace.

`name`
: Name of the namespace.

`resource_version`
: Resource version of the namespace. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the namespace.

`kind`
: Resource type of the namespace.

`creation_timestamp`
: Creation time of the namespace. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the namespace.

## Examples

### Specified namespace must exist and test its properties

```ruby
describe k8s_namespace(name: 'kube-node-lease') do
  it { should exist }
  its('uid') { should eq '5ed76d62-838b-45cb-b41f-789b567a2fa2' }
  its('name') { should eq 'kube-node-lease' }
  its('kind') { should eq 'Namespace' }
  its('resource_version') { should eq '6' }
  its('creationTimestamp') { should eq '2022-07-21T10:47:49Z' }
  its('labels') { should eq 'kubernetes.io/metadata.name': 'kube-node-lease' }
  its('metadata') { should_not be_nil }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
