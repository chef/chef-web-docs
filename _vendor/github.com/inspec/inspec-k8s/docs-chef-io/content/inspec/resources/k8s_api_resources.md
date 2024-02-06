+++
title = "k8s_api_resources resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_api_resources"
identifier = "inspec/resources/k8s/K8s API Resources"
parent = "inspec/resources/k8s"
+++

Use the `k8s_api_resources` Chef InSpec audit resource to test the configurations of all resources under the specified API.

## Installation

## Syntax

```ruby
describe k8s_api_resources(api: 'apps/v1') do
  it { should exist }
  its('name') { should include 'daemonsets' }
  its('singularName') { should include '' }
  its('namespaced') { should include true }
  its('group') { should include 'autoscaling' }
  its('version') { should include 'v1' }
  its('kind') { should include 'DaemonSet' }
  its('shortNames') { should include 'ds' }
  its('categories') { should include 'all' }
end
```

## Parameter

`api`
: API available for Kubernetes (default is **v1**).

## Properties

`name`
: Name of the resource available under the specified API.

`singularName`
: Singular name of the resource available under the specified API.

`namespaced`
: returns a boolean value if the resources under the api is namespaced.

`group`
: group of the resources under the specified API.

`version`
: version of the specified API.

`shortNames`
: Short names for resources under the specified API.

`categories`
: Categories for resources under the specified API.

`kind`
: Type of resources under the specified API.

## Examples

### Resources under default API must exist

```ruby
describe k8s_api_resources do
  it { should exist }
  its('kind') { should include 'ConfigMap' }
end
```

### Resources under specified API must exist and test its properties

```ruby
describe k8s_api_resources(api: 'apps/v1') do
  it { should exist }
  its('name') { should include 'daemonsets' }
  its('singularName') { should include '' }
  its('namespaced') { should include true }
  its('group') { should include 'autoscaling' }
  its('version') { should include 'v1' }
  its('kind') { should include 'DaemonSet' }
  its('shortNames') { should include 'ds' }
  its('categories') { should include 'all' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
