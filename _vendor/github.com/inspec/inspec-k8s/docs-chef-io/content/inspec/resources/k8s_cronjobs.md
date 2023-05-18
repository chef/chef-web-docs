+++
title = "k8s_cronjobs resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_cronjobs"
identifier = "inspec/resources/k8s/K8s Cronjobs"
parent = "inspec/resources/k8s"
+++

Use the `k8s_cronjobs` Chef InSpec audit resource to test the configurations of all CronJobs in a namespace.

## Installation

## Syntax

```ruby
describe k8s_cronjobs do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uids`
: UID of the CronJobs.

`names`
: Name of the CronJobs.

`namespaces`
: Namespace of the CronJobs.

`resource_versions`
: Resource version of the CronJobs.

`labels`
: Labels associated with the CronJobs.

`annotations`
: Annotations associated with the CronJobs.

`kinds`
: Resource type of the CronJobs.

## Examples

### Cronjobs for default namespace must exist and test its properties

```ruby
describe k8s_cronjobs do
  it { should exist }
  its('names') { should include 'HELLO' }
  its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
  its('namespaces') { should include 'default' }
  its('resource_versions') { should include '70517' }
  its('kinds') { should include 'CronJob' }
  its('labels') { should be_empty }
  its('annotations') { should_not be_empty }
end
```

### Cronjobs for specified namespace must exist

```ruby
describe k8s_cronjobs(namespace: 'Namespace') do
  it { should exist }
  its('names') { should include 'HELLO-WORLD' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
