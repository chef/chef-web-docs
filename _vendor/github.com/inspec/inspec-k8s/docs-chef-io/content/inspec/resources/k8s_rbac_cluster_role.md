+++
title = "k8s_rbac_cluster_role resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "k8s_rbac_cluster_role"
    identifier = "inspec/resources/k8s/K8s Rbac Cluster Role"
    parent = "inspec/resources/k8s"
+++


Use the `k8s_rbac_cluster_role` Chef InSpec audit resource to test the Role-based access control (RBAC) cluster role settings.

## Installation

## Syntax

```ruby
describe k8s_rbac_cluster_role(name: "NAME") do
  #...
end
```

## Parameters

`name`
: Cluster role name.

## Properties

`uid`
: UID of the cluster role.

`kind`
: Resource type of the cluster role.

`resource_version`
: Resource version of the cluster role.

`labels`
: Labels attached to the cluster role.

`annotations`
: Annotations of the cluster role.

`rules`
: List of rules set for the cluster role.

`aggregation_rule`
: Aggregation rule set for the cluster role.

`cluster_role_selectors`
: List of aggregation rule cluster role selectors set for the cluster role.

`metadata`
: Metadata of the cluster role.

`creation_timestamp`
: Creation timestamp of the cluster role.

## Examples

### Test to verify that the RBAC cluster role with the specified name exists

```ruby
describe k8s_rbac_cluster_role(name: "CLUSTER_ROLE_NAME") do
  it { should exist }
end
```

### Test to verify rules set for the specified cluster role

```ruby
describe k8s_rbac_cluster_role(name: "pod-reader") do
  it { should exist }
  its('rules') { should  include apiGroups: [""], resources: ["pods"], verbs: ["get", "list", "watch"] }
end
```

### Test to verify aggregation rule is not empty and cluster role selectors have the specified value

```ruby
describe k8s_rbac_cluster_role(name: "monitoring") do
    its("aggregation_rule") { should_not be_empty }
    its("cluster_role_selectors") { should include matchLabels: { "rbac.example.com/aggregate-to-monitoring": "true" }  }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
