+++
title = "k8s_network_policy resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_network_policy"
identifier = "inspec/resources/k8s/K8s Network Policy"
parent = "inspec/resources/k8s"
+++


Use the `k8s_network_policy` Chef InSpec audit resource to test the configuration of a specific network policy in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_network_policy(name: 'coredns', namespace: 'kube-system') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the network policy.

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uid`
: UID of the network policy.

`name`
: Name of the network policy.

`namespace`
: Namespace of the network policy.

`resource_version`
: Resource version of the network policy. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the network policy.

`annotations`
: Annotations associated with the network policy.

`kind`
: Resource type of the network policy.

`creation_timestamp`
: Creation time of the network policy. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the network policy.

## Examples

### Network policy for default namespace must exist and test its properties

```ruby
describe k8s_network_policy(name: "TEST-NETWORK-POLICY") do
  it { should exist }
  its('uid') { should eq '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
  its('resource_version') { should eq '129558' }
  its('labels') { should be_empty }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'Network-Policy' }
  its('namespace') { should eq 'default' }
  its('kind') { should eq 'Network-Policy' }
  its('creation_timestamp') { should eq '2022-08-02T09:47:56Z' }
  its('metadata') { should_not be_nil }
end
```

### Network Policy for a specified namespace must exist

```ruby
describe k8s_network_policy(namespace: 'Namespace', name: 'Network-Policy') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
