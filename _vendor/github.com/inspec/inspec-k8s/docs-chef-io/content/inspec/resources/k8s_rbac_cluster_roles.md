+++
title = "k8s_rbac_cluster_roles resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "k8s_rbac_cluster_roles"
    identifier = "inspec/resources/k8s/K8s Rbac Cluster Roles"
    parent = "inspec/resources/k8s"
+++

Use the `k8s_rbac_cluster_roles` Chef InSpec audit resource to test all the Role-based access control (RBAC) cluster roles.

## Installation

## Syntax

```ruby
describe k8s_rbac_cluster_roles do
  #...
end
```

## Properties

`uids`
: UID of the cluster roles.

`kinds`
: Resource type of the cluster roles.

`resource_versions`
: Resource version of the cluster roles.

`labels`
: Labels attached to the cluster roles.

`annotations`
: Annotations of the cluster roles.

`rules`
: List of rules set for the cluster roles.

`aggregation_rules`
: Aggregation rule set for the cluster roles.

`cluster_role_selectors`
: List of aggregation rule cluster role selectors set for the cluster roles.

`metadata`
: Metadata of the cluster roles.

`creation_timestamps`
: Creation timestamp of the cluster roles.

## Examples

### Test to verify that the RBAC cluster roles

```ruby
describe k8s_rbac_cluster_roles do
  it { should exist }
end
```

### Test to verify rules set for the specified cluster role

```ruby
describe k8s_rbac_cluster_roles do
  its('rules') { should  include apiGroups: [''], resources: ['pods'], verbs: ['get', 'list', 'watch'] }
end
```

### Test to verify aggregation rules and aggregation rule cluster role selectors

```ruby
describe k8s_rbac_cluster_roles do
    its("aggregation_rules") { should_not be_empty }
    its("cluster_role_selectors") { should include matchLabels: { "rbac.example.com/aggregate-to-monitoring": 'true' }  }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
