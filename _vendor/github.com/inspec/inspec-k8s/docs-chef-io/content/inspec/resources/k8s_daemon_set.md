+++
title = "k8s_daemon_set resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_daemon_set"
identifier = "inspec/resources/k8s/K8s DaemonSet"
parent = "inspec/resources/k8s"
+++


Use the `k8s_daemon_set` Chef InSpec audit resource to test the configuration of a specific DaemonSet in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_daemon_set(namespace: 'kube-system', name: 'fluentd-elasticsearch') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the DaemonSet.

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uid`
: UID of the DaemonSet.

`name`
: Name of the DaemonSet.

`namespace`
: Namespace of the DaemonSet.

`resource_version`
: Resource version of the DaemonSet. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the DaemonSet.

`annotations`
: Annotations associated with the DaemonSet.

`kind`
: Resource type of the DaemonSet.

`creation_timestamp`
: Creation time of the DaemonSet. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the DaemonSet.

## Examples

### DaemonSet for default namespace must exist and test its properties

```ruby
describe k8s_daemon_set(name: 'fluentd-elasticsearch') do
  it { should exist }
  its('uid') { should eq '406b569d-d4f9-4537-b047-cf35b00e88b4' }
  its('resource_version') { should eq '101377' }
  its('labels') { should eq 'k8s-app':'fluentd-logging' }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'fluentd-elasticsearch' }
  its('namespace') { should eq 'default' }
  its('kind') { should eq 'DaemonSet' }
  its('creation_timestamp') { should eq '2022-07-31T16:41:21Z' }
end
```

### DaemonSet for a specified namespace must exist

```ruby
describe k8s_daemon_set(namespace: 'kube-system', name: 'fluentd-elasticsearch') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
