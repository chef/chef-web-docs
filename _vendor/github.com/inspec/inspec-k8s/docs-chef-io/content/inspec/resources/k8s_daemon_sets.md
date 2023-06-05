+++
title = "k8s_daemon_sets resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_daemon_sets"
identifier = "inspec/resources/k8s/K8s DaemonSets"
parent = "inspec/resources/k8s"
+++

Use the `k8s_daemon_sets` Chef InSpec audit resource to test the configurations of all DaemonSets in a namespace.

## Installation

## Syntax

```ruby
describe k8s_daemon_sets(namespace: 'kube-system') do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uids`
: UID of the DaemonSets.

`names`
: Name of the DaemonSets.

`namespaces`
: Namespace of the DaemonSets.

`resource_versions`
: Resource version of the DaemonSets.

`labels`
: Labels associated with the DaemonSets.

`annotations`
: Annotations associated with the DaemonSets.

`kinds`
: Resource type of the DaemonSets.

## Examples

### DaemonSets for default namespace must exist

```ruby
describe k8s_daemon_sets do
  it { should exist }
  its('names') { should include 'fluentd-elasticsearch' }
end
```

### DaemonSets for specified namespace must exist and test its properties

```ruby
describe k8s_daemon_sets(namespace: 'kube-system') do
  it { should exist }
  its('names') { should include 'fluentd-elasticsearch' }
  its('resource_versions') { should include '101377' }
  its('labels') { should include 'k8s-app':'fluentd-logging' }
  its('annotations') { should_not be_empty }
  its('uids') { should include '406b569d-d4f9-4537-b047-cf35b00e88b4' }
  its('namespaces') { should include 'kube-system' }
  its('kinds') { should include 'DaemonSet' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
