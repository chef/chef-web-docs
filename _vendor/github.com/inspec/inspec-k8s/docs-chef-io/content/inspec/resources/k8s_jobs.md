+++
title = "k8s_jobs resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_jobs"
identifier = "inspec/resources/k8s/K8s Jobs"
parent = "inspec/resources/k8s"
+++

Use the `k8s_jobs` Chef InSpec audit resource to test the configurations of all Jobs in a namespace.

## Installation

## Syntax

```ruby
describe k8s_jobs do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uids`
: UID of the Jobs.

`names`
: Name of the Jobs.

`namespaces`
: Namespace of the Jobs.

`resource_versions`
: Resource version of the Jobs.

`labels`
: Labels associated with the Jobs.

`annotations`
: Annotations associated with the Jobs.

`kinds`
: Resource type of the Jobs.

## Examples

### Jobs for default namespace must exist and test its properties

```ruby
describe k8s_jobs do
  it { should exist }
  its('names') { should include 'HELLO' }
  its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
  its('namespaces') { should include 'default' }
  its('resource_versions') { should include '70517' }
  its('kinds') { should include 'JOB' }
  its('labels') { should_not be_empty }
  its('annotations') { should_not be_empty }
end
```

### Jobs for specified namespace must exist

```ruby
describe k8s_jobs(namespace: 'Namespace') do
  it { should exist }
  its('names') { should include 'HELLO-WORLD' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
