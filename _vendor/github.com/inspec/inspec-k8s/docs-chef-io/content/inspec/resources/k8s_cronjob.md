+++
title = "k8s_cronjob resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_cronjob"
identifier = "inspec/resources/k8s/K8s Cronjob"
parent = "inspec/resources/k8s"
+++


Use the `k8s_cronjob` Chef InSpec audit resource to test the configuration of a specific CronJob in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_cronjob(name: 'hello') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the CronJob.

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uid`
: UID of the CronJob.

`name`
: Name of the CronJob.

`namespace`
: Namespace of the CronJob.

`resource_version`
: Resource version of the Cronjob. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the CronJob.

`annotations`
: Annotations associated with the CronJob.

`kind`
: Resource type of the CronJob.

`creation_timestamp`
: Creation time of the CronJob. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the CronJob.

## Examples

### Cronjob for default namespace must exist and test its properties

```ruby
describe k8s_cronjob(name: 'HELLO') do
  it { should exist }
  its('uid') { should eq '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
  its('resource_version') { should eq '70517' }
  its('labels') { should be_empty }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'HELLO' }
  its('namespace') { should eq 'default' }
  its('kind') { should eq 'CronJob' }
  its('creationTimestamp') { should eq '2022-07-27T12:54:44Z' }
  its('metadata') { should_not be_nil }
end
```

### Cronjob for a specified namespace must exist

```ruby
describe k8s_cronjob(name: 'HELLO-WORLD', namespace: 'Namespace') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
