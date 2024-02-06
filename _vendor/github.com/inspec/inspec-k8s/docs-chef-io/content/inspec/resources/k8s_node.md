+++
title = "k8s_node resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "k8s_node"
    identifier = "inspec/resources/k8s/K8s Node"
    parent = "inspec/resources/k8s"
+++


Use the `k8s_node` Chef InSpec audit resource to test the configuration of the K8s node.

## Installation

## Syntax

```ruby
describe k8s_node(name: "NAME") do
  #...
end
```

## Parameters

`name`
: Node name.

## Properties

`uid`
: UID of the node.

`kind`
: Resource type of the node.

`resource_version`
: Resource version of the node.

`labels`
: Labels attached to the node.

`annotations`
: Annotations of the node.

## Examples

### Test to verify that the node with the specified name exists

```ruby
describe k8s_node(name: "NODE_NAME") do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### have_label

The `have_label` matcher verifies if the specified key and value are present in the node labels.

```ruby
it { should have_label('foo', 'bar') }
```

### have_annotation

The `have_annotation` matcher verifies if the specified key and value are present in the node annotations.

```ruby
it { should have_annotation('foo', 'bar') }
```
