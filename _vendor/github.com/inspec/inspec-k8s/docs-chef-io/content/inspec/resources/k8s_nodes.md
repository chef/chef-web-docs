+++
title = "k8s_nodes resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_nodes"
identifier = "inspec/resources/k8s/K8s Nodes"
parent = "inspec/resources/k8s"
+++

Use the `k8s_nodes` Chef InSpec audit resource to test the configuration of all nodes.

## Installation

## Syntax

```ruby
describe k8s_nodes do
  #...
end
```

## Properties

`uids`
: UID of the nodes.

`names`
: Name of the nodes.

`resource_versions`
: Resource version of the nodes.

`kinds`
: Resource type of the nodes.

## Examples

### Test to verify nodes include a node with a specified name and UID

```ruby
 describe k8s_nodes do
  it { should exist }
  its('names') { should include 'NODE_NAME' }
  its('uids') { should include 'NODE_UID' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
