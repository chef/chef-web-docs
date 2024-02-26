+++
title = "k8s_network_policies resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_network_policies"
identifier = "inspec/resources/k8s/K8s NetworkPolicies"
parent = "inspec/resources/k8s"
+++

Use the `k8s_network_policies` Chef InSpec audit resource to test the configurations of all network policies in a namespace.

## Installation

## Syntax

```ruby
describe k8s_network_policies do
  it { should exist }
  its('names') { should include 'Network-Policy' }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uids`
: UID of the network policies.

`names`
: Name of the network policies.

`namespaces`
: Namespace of the network policies.

`resource_versions`
: Resource version of the network policies.

`labels`
: Labels associated with the network policies.

`annotations`
: Annotations associated with the network policies.

`kinds`
: Resource type of the network policies.

## Examples

### Network policies for default namespace must exist

```ruby
describe k8s_network_policies do
  it { should exist }
  its('names') { should include 'Network-Policy' }
end
```

### Network policies for specified namespace must exist and test its properties

```ruby
describe k8s_network_policies(namespace: 'NAMESPACE') do
  it { should exist }
  its('names') { should include 'Network-Policy' }
  its('uids') { should include '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
  its('resource_versions') { should include '129558' }
  its('labels') { should_not be_empty }
  its('annotations') { should_not be_empty }
  its('namespaces') { should include 'Namespace' }
  its('kinds') { should include 'Network-Policy' }
  its('metadata') { should_not be_nil }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
