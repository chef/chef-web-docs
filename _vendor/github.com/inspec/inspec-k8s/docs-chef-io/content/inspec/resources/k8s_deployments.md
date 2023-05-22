+++
title = "k8s_deployments resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_deployments"
identifier = "inspec/resources/k8s/K8s Deployments"
parent = "inspec/resources/k8s"
+++

Use the `k8s_deployments` Chef InSpec audit resource to test the configurations of all Deployments in a namespace.

## Installation

## Syntax

```ruby
describe k8s_deployments(namespace: 'kube-system') do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uids`
: UID of the Deployments.

`names`
: Name of the Deployments.

`namespaces`
: Namespace of the Deployments.

`resource_versions`
: Resource version of the Deployments.

`labels`
: Labels associated with the Deployments.

`annotations`
: Annotations associated with the Deployments.

`kinds`
: Resource type of the Deployments.

## Examples

### Deployments for the default namespace must exist

```ruby
describe k8s_deployments do
  it { should exist }
  its('names') { should include 'nginx-deployment' }
end
```

### Deployments for specified namespace must exist and test its properties

```ruby
describe k8s_deployments(namespace: 'kube-system') do
  it { should exist }
  its('uids') { should include 'eeb07afc-2f45-4d52-9fda-aa362f7c536c' }
  its('resource_versions') { should include '7944' }
  its('labels') { should include :'k8s-app' => 'kube-dns' }
  its('annotations') { should_not be_empty }
  its('names') { should include 'coredns' }
  its('namespaces') { should include 'kube-system' }
  its('kinds') { should include 'DEPLOYMENT' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
