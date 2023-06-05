+++
title = "k8s_namespaces resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_namespaces"
identifier = "inspec/resources/k8s/K8s Namespaces"
parent = "inspec/resources/k8s"
+++

Use the `k8s_namespaces` Chef InSpec audit resource to test the configurations of all namespaces.

## Installation

## Syntax

```ruby
describe k8s_namespaces do
  it { should exist }
  its('names') { should include 'DEFAULT' }
end
```

## Properties

`uids`
: UID of the namespaces.

`names`
: Name of the namespaces.

`resource_versions`
: Resource version of the namespaces.

`labels`
: Labels associated with the namespaces.

`kinds`
: Resource type of the namespaces.

## Examples

### Namespaces must exist and test their properties

```ruby
describe k8s_namespaces do
  it { should exist }
  its('uids') { should include '5ed76d62-838b-45cb-b41f-789b567a2fa2' }
  its('names') { should include 'default' }
  its('resource_versions') { should include '6' }
  its('kinds') { should include 'Namespace' }
  its('labels') { should include 'kubernetes.io/metadata.name': 'default' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
