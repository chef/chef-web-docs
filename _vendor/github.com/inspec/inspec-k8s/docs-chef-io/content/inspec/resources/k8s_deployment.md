+++
title = "k8s_deployment resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_deployment"
identifier = "inspec/resources/k8s/K8s Deployment"
parent = "inspec/resources/k8s"
+++


Use the `k8s_deployment` Chef InSpec audit resource to test the configuration of a specific Deployment in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_deployment(name: 'coredns', namespace: 'kube-system') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the Deployment.

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uid`
: UID of the Deployment.

`name`
: Deployment name.

`namespace`
: Namespace of the Deployment.

`resource_version`
: Resource version of the Deployment. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the Deployment.

`annotations`
: Annotations associated with the Deployment.

`kind`
: Resource type of the Deployment.

`creation_timestamp`
: Creation time of the Deployment. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the Deployment.

## Examples

### Deployment for default namespace must exist and test its properties

```ruby
describe k8s_deployment(name: 'NEW-DEPLOYMENT') do
  it { should exist }
  its('uid') { should eq 'e948355b-adc2-4db8-af16-34f5aa38d6ec' }
  its('resource_version') { should eq '8107' }
  its('labels') { should eq :app=>'NEW-DEPLOYMENT' }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'NEW-DEPLOYMENT' }
  its('namespace') { should eq 'default' }
  its('kind') { should eq 'DEPLOYMENT' }
  its('creation_timestamp') { should eq '2022-07-21T18:54:43Z' }
  its('metadata') { should_not be_nil }
end
```

### Deployment for a specified namespace must exist

```ruby
describe k8s_deployment(namespace: 'kube-system', name: 'coredns') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
